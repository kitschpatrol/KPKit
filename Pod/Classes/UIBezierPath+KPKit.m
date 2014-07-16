#import "UIBezierPath+KPKit.h"
#import <objc/runtime.h>
#import "NSNumber+KPKit.h"
#import "KPKit.h"
#import "KPMath.h"

// Implementation options
static const CGFloat KPDefaultPointResolution = 1.0; // Points between samples (Bigger numbers are faster)
static const BOOL KPCalculateLengthPrecisely = NO;   // Use dash lengths vs. euclidian distance (NO is faster)
static const BOOL KPInterpolatePoints = YES;         // Linear interpolation if a % or length sample request falls between cached samples
static const BOOL KPInterpolateAngles = NO;          // Kind of weird, because underlying line interpolation is linear...

@interface UIBezierPath ()

@property (nonatomic, assign) BOOL kp_pathPointsNeedUpdate;

@end

@implementation UIBezierPath (KPKit)

#pragma mark - properties

- (NSArray *)kp_points {
  if (!objc_getAssociatedObject(self, @selector(kp_points))) {
    self.kp_pathPointsNeedUpdate = YES;
  }
  [self updatePathPoints];
  return objc_getAssociatedObject(self, @selector(kp_points));
}

- (void)setKp_points:(NSArray *)kp_points {
  // Internal only
  objc_setAssociatedObject(self, @selector(kp_points), kp_points, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)kp_angles {
  if (!objc_getAssociatedObject(self, @selector(kp_angles))) {
    self.kp_pathPointsNeedUpdate = YES;
  }
  [self updatePathPoints];
  return objc_getAssociatedObject(self, @selector(kp_angles));
}

- (void)setKp_angles:(NSArray *)kp_angles {
  // Internal only
  objc_setAssociatedObject(self, @selector(kp_angles), kp_angles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)kp_pointResolution {
  // Set default if necessary
  if (!objc_getAssociatedObject(self, @selector(kp_pointResolution))) {
    self.kp_pointResolution = KPDefaultPointResolution; // Default
  }

  return [objc_getAssociatedObject(self, @selector(kp_pointResolution)) kp_CGFloatValue];
}

- (void)setKp_pointResolution:(CGFloat)kp_pointResolution {
  if ((kp_pointResolution != KPDefaultPointResolution) && (kp_pointResolution != self.kp_pointResolution)) {
    self.kp_pathPointsNeedUpdate = YES;
  }
  objc_setAssociatedObject(self, @selector(kp_pointResolution), [NSNumber kp_numberWithCGFloat:kp_pointResolution], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self updatePathPoints];
}

- (CGFloat)kp_length {
  // Calculate lazily
  if (!objc_getAssociatedObject(self, @selector(kp_length))) {
    self.kp_pathPointsNeedUpdate = YES;
  }
  [self updatePathPoints];
  return [objc_getAssociatedObject(self, @selector(kp_length)) kp_CGFloatValue];
}

- (void)setKp_length:(CGFloat)kp_length {
  // Internal only...
  objc_setAssociatedObject(self, @selector(kp_length), [NSNumber kp_numberWithCGFloat:kp_length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - methods

- (CGPoint)kp_pointAtPercent:(CGFloat)percent {
  if ([self.kp_points count] == 0) {
    return CGPointZero;
  }

  CGFloat exactIndex = KPClamp(percent, (CGFloat)0.0, (CGFloat)1.0) * ([self.kp_points count] - 1);

  if (KPInterpolatePoints) {
    CGFloat leftIndex = floor(exactIndex);
    CGFloat rightIndex = ceil(exactIndex);

    if (leftIndex == rightIndex) {
      // exact index really was exact
      return [self.kp_points[(NSUInteger)leftIndex] CGPointValue];
    } else {
      // Interpolate
      CGPoint leftPoint = [self.kp_points[(NSUInteger)leftIndex] CGPointValue];
      CGPoint rightPoint = [self.kp_points[(NSUInteger)rightIndex] CGPointValue];
      CGFloat amount = exactIndex - leftIndex;
      return KPLinearInterpolateBetweenCGPoint(leftPoint, rightPoint, amount);
    }
  } else {
    return [self.kp_points[(NSUInteger)round(exactIndex)] CGPointValue];
  }
}

- (CGFloat)kp_angleAtPercent:(CGFloat)percent {
  if ([self.kp_points count] == 0) {
    return 0.0;
  }

  CGFloat exactIndex = KPClamp(percent, (CGFloat)0.0, (CGFloat)1.0) * ([self.kp_angles count] - 1);

  if (KPInterpolateAngles) {
    CGFloat leftIndex = floor(exactIndex);
    CGFloat rightIndex = ceil(exactIndex);

    if (leftIndex == rightIndex) {
      // exact index really was exact
      return [self.kp_angles[(NSUInteger)leftIndex] kp_CGFloatValue];
    } else {
      // Interpolate
      CGFloat leftAngle = [self.kp_angles[(NSUInteger)leftIndex] kp_CGFloatValue];
      CGFloat rightAngle = [self.kp_angles[(NSUInteger)rightIndex] kp_CGFloatValue];
      CGFloat amount = exactIndex - leftIndex;
      return leftAngle + (KPAngleDifferenceRadians(leftAngle, rightAngle) * amount);
    }
  } else {
    return [self.kp_angles[(NSUInteger)round(exactIndex)] kp_CGFloatValue];
  }
}

- (CGPoint)kp_pointAtLength:(CGFloat)length {
  return [self kp_pointAtPercent:length / self.kp_length];
}

- (CGFloat)kp_angleAtLength:(CGFloat)length {
  return [self kp_angleAtPercent:length / self.kp_length];
}

- (void)kp_setNeedsPathPointsUpdate {
  // Expose this publicly until we can figure out exactly when to mark this as necessary
  // based on mutations to self
  self.kp_pathPointsNeedUpdate = YES;
}

#pragma mark - internal

- (void)updatePathPoints {
  if (self.kp_pathPointsNeedUpdate) {
    self.kp_pathPointsNeedUpdate = NO;

    // Calculate points
    // TODO what about the "last" point? Value of tracing in reverse?
    // Tried several things without success (Dash phase, bezierPathByReversingPath)
    self.kp_points = getAllPointsFromCGPath(self.CGPath, self.kp_pointResolution);

    // Edge cases
    if ([self.kp_points count] == 0) {
      NSLog(@"No points");
      self.kp_length = 0.0;
      self.kp_angles = @[];
      return;
    }

    if ([self.kp_points count] == 1) {
      NSLog(@"One point");
      self.kp_length = 0.0;
      self.kp_angles = @[@(0.0)];
      return;
    }

    // From here, we have at least two points
    NSMutableArray *tempAngles = [@[] mutableCopy];

    // Calculate first angle
    CGPoint firstPoint = [self.kp_points[0] CGPointValue];
    CGPoint secondPoint = [self.kp_points[1] CGPointValue];
    CGFloat firstAngle = KPAngleBetweenCGPoint(firstPoint, secondPoint);
    [tempAngles addObject:@(firstAngle)];

    // Calculate intermediate angles (if there are at least three points)
    if ([self.kp_points count] >= 3) {
      for (CFIndex i = 1; i < [self.kp_points count] - 1; i++) {
        CGPoint pointLeft = [self.kp_points[i - 1] CGPointValue];
        CGPoint pointRight = [self.kp_points[i + 1] CGPointValue];
        CGFloat angle = KPAngleBetweenCGPoint(pointLeft, pointRight);
        [tempAngles addObject:@(angle)];
      }
    }

    // Calculate last angle
    CGPoint penultimatePoint = [self.kp_points[[self.kp_points count] - 2] CGPointValue];
    CGPoint ultimatePoint = [self.kp_points[[self.kp_points count] - 1] CGPointValue];
    CGFloat lastAngle = KPAngleBetweenCGPoint(penultimatePoint, ultimatePoint);
    [tempAngles addObject:@(lastAngle)];

    self.kp_angles = tempAngles;

    // Calculate length
    if (KPCalculateLengthPrecisely) {
      // Length based on actual distances between points - slower and more precise
      CGFloat distance = 0.0;
      for (CFIndex i = 0; i < [self.kp_points count] - 1; i++) {
        CGPoint pointA = [self.kp_points[i] CGPointValue];
        CGPoint pointB = [self.kp_points[i + 1] CGPointValue];
        distance += KPDistanceBetweenCGPoint(pointA, pointB);
      }
      self.kp_length = distance;
    } else {
      // Length based on number of dashes - faster and less precise
      self.kp_length = self.kp_pointResolution * [self.kp_points count];
    }
  }
}

- (BOOL)kp_pathPointsNeedUpdate {
  return [objc_getAssociatedObject(self, @selector(kp_pathPointsNeedUpdate)) boolValue];
}

- (void)setKp_pathPointsNeedUpdate:(BOOL)kp_pathPointsNeedUpdate {
  objc_setAssociatedObject(self, @selector(kp_pathPointsNeedUpdate), @(kp_pathPointsNeedUpdate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - very internal

// http://iphonedevsdk.com/discussion/comment/432941/#Comment_432941

void MoveToPointsPathApplierFunction(void *info, const CGPathElement *element) {
  NSMutableArray *moveToPoints = (__bridge NSMutableArray *)info;

  CGPoint *points = element->points;
  CGPathElementType type = element->type;
  if (type == kCGPathElementMoveToPoint) {
    [moveToPoints addObject:[NSValue valueWithCGPoint:points[0]]];
  }
}

NSArray *getAllPointsFromCGPath(CGPathRef path, CGFloat stepDistance) {
  // One pass of points
  NSMutableArray *points = [@[] mutableCopy];
  CGFloat lengths[] = {0, stepDistance};

  CGPathRef dashingPath = CGPathCreateCopyByDashingPath(path, NULL, 0.0, lengths, 2);
  CGPathApply(dashingPath, (__bridge void *)points, MoveToPointsPathApplierFunction);
  CGPathRelease(dashingPath);

  return points;
}

#pragma mark - convenience constructors

+ (UIBezierPath *)kp_bezierPathWithDonut:(CGPoint)center innerRadius:(CGFloat)innerRadius outerRadius:(CGFloat)outerRadius {
  CGRect donutRect = CGRectMake(center.x - outerRadius, center.y - outerRadius, outerRadius * 2, outerRadius * 2);
  CGRect holeRect = CGRectMake(center.x - innerRadius, center.y - innerRadius, innerRadius * 2, innerRadius * 2);

  UIBezierPath *donut = [UIBezierPath bezierPathWithOvalInRect:donutRect];
  donut.usesEvenOddFillRule = YES;
  UIBezierPath *hole = [UIBezierPath bezierPathWithOvalInRect:holeRect];

  [donut appendPath:hole];
  return donut;
}

+ (UIBezierPath *)kp_bezierPathWithDonut:(CGPoint)center
                             innerRadius:(CGFloat)innerRadius
                             outerRadius:(CGFloat)outerRadius
                              startAngle:(CGFloat)startAngle
                                endAngle:(CGFloat)endAngle
                               clockwise:(BOOL)clockwise {

  UIBezierPath *donut = [UIBezierPath bezierPath];
  [donut addArcWithCenter:center radius:outerRadius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
  [donut addArcWithCenter:center radius:innerRadius startAngle:endAngle endAngle:startAngle clockwise:!clockwise];
  [donut closePath];
  return donut;
}

@end
