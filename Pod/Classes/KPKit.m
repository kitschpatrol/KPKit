#import "KPKit.h"
#import <UIKit/UIKit.h>

#import "UIBezierPath+KPKit.h"

@import CoreText;

// Pretty major mess... these should (maybe) be moved into descrete classes and / or categories eventually.

@implementation KPKit

#pragma mark - Random

+ (NSInteger)randomInt:(NSInteger)value {
  return ((NSInteger)arc4random()) % value;
}

+ (CGFloat)randomBetweenA:(CGFloat)a andB:(CGFloat)b {
  if (a == b) {
    return a;
  } else {
    CGFloat max = a > b ? a : b;
    CGFloat min = a < b ? a : b;
    NSAssert(max - min > 0, @"Your expression returned true for max-min <= 0 " @"for some reason... max = %f, min = %f", max, min);
    return (((CGFloat)arc4random() / 4294967295.0) * (max - min)) + min;
  }
}

+ (NSInteger)randomIntBetweenA:(NSInteger)a andB:(NSInteger)b {
  NSInteger returnVal;
  if (a == b) {
    returnVal = a;
  } else {
    NSInteger max = a > b ? a : b;
    NSInteger min = a < b ? a : b;
    NSAssert(max - min > 0, @"Your expression returned true for max-min <= 0 " @"for some reason... max = %ld, min = %ld", (long)max, (long)min);
    returnVal = (((NSInteger)arc4random()) % (max - min) + min);
  }
  return returnVal;
}

#pragma mark - Color

+ (UIColor *)randomColor {
  return [self randomColorWithAlpha:1.0];
}

+ (UIColor *)colorWithAlpha:(UIColor *)color alpha:(CGFloat)alpha {
  CGFloat hue;
  CGFloat saturation;
  CGFloat brightness;
  CGFloat oldAlpha;

  if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&oldAlpha]) {
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
  } else {
    // Error, could not convert
    return color;
  }
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alphaValue {
  CGFloat red = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
  CGFloat blue = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
  CGFloat green = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
  return [UIColor colorWithRed:red green:green blue:blue alpha:alphaValue];
}

+ (UIColor *)randomBrightnessOfColor:(UIColor *)color {
  CGFloat hue;
  CGFloat saturation;
  CGFloat brightness;
  CGFloat alpha;

  if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
    return [UIColor colorWithHue:hue saturation:saturation brightness:[KPKit randomBetweenA:0.5 andB:0.9] alpha:alpha];
  } else {
    // Error, could not convert
    return color;
  }
}

+ (UIColor *)color:(UIColor *)color withBrightness:(CGFloat)value {
  CGFloat hue;
  CGFloat saturation;
  CGFloat brightness;
  CGFloat alpha;

  if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
    return [UIColor colorWithHue:hue saturation:saturation brightness:value alpha:alpha];
  } else {
    // Error, could not convert
    return color;
  }
}

#pragma mark - Text

+ (void)drawText:(NSAttributedString *)text onPath:(UIBezierPath *)path {
  [self drawText:text onPath:path inContext:UIGraphicsGetCurrentContext() withAlignment:NSTextAlignmentLeft clockwiseBaseline:YES];
}

+ (void)drawText:(NSAttributedString *)text onPath:(UIBezierPath *)path inContext:(CGContextRef)context {
  [self drawText:text onPath:path inContext:context withAlignment:NSTextAlignmentLeft clockwiseBaseline:YES];
}

+ (void)drawText:(NSAttributedString *)text onPath:(UIBezierPath *)path inContext:(CGContextRef)context withAlignment:(NSTextAlignment)alignment {
  [self drawText:text onPath:path inContext:context withAlignment:alignment clockwiseBaseline:YES];
}

+ (void)drawText:(NSAttributedString *)text
               onPath:(UIBezierPath *)path
            inContext:(CGContextRef)context
        withAlignment:(NSTextAlignment)alignment
    clockwiseBaseline:(BOOL)clockwiseBaseline {
  NSAssert((alignment != NSTextAlignmentJustified), @"Justified text alginment not supported for drawing text on a path.");
  NSAssert((alignment != NSTextAlignmentNatural), @"Natural text alginment not supported for drawing text on a path.");

  CGContextSaveGState(context);

  CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)text);
  NSAssert(line != NULL, @"Problems creating core text line reference.");
  CFArrayRef runArray = CTLineGetGlyphRuns(line);
  CFRelease(line);

  CFIndex runCount = CFArrayGetCount(runArray);

  // Go through each run
  for (CFIndex runIndex = 0; runIndex < runCount; runIndex++) {
    CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
    CFIndex runGlyphCount = CTRunGetGlyphCount(run);
    // CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);

    // Get all the glyph positions
    CFRange allGlyphsInRunRange = CFRangeMake(0, runGlyphCount);
    CGPoint glyphPositions[allGlyphsInRunRange.length];
    CTRunGetPositions(run, CFRangeMake(0, runGlyphCount), glyphPositions);

    // Align the text on the path with an offset
    CGFloat runWidth = CTRunGetTypographicBounds(run, allGlyphsInRunRange, NULL, NULL, NULL);

    CGFloat textOffset;
    // Center it
    switch (alignment) {
      case NSTextAlignmentNatural:
      case NSTextAlignmentJustified:
      case NSTextAlignmentLeft:
        textOffset = 0.0;
        break;
      case NSTextAlignmentRight:
        textOffset = (path.kp_length - runWidth);
        break;
      case NSTextAlignmentCenter:
        textOffset = (path.kp_length - runWidth) / 2;
        break;
    }

    for (CFIndex runGlyphIndex = 0; runGlyphIndex < runGlyphCount; runGlyphIndex++) {
      // Get position the glyph would have had in a normally presented string
      // This ensures that we have kerning and other details correct
      CGPoint glyphPosition = glyphPositions[runGlyphIndex];

      // The "origin" seems to be in the bottom left by default. Compensate for the width of the glyph.
      CFRange glyphRange = CFRangeMake(runGlyphIndex, 1);
      CGFloat glyphWidth = CTRunGetTypographicBounds(run, glyphRange, NULL, NULL, NULL);
      glyphPosition.x = glyphPosition.x + (glyphWidth / 2);

      // Find point and angle on the line at corresponding position
      CGPoint pointOnPath = [path kp_pointAtLength:glyphPosition.x + textOffset];
      CGFloat angleOnPath = [path kp_angleAtLength:glyphPosition.x + textOffset];

      if (!clockwiseBaseline) {
        angleOnPath += M_PI;
      }

      // A bunch of hairy transforms.
      CGAffineTransform runOffsetMatrix = CGAffineTransformTranslate(CGAffineTransformIdentity, -(glyphPosition.x), 0.0);
      CGAffineTransform flipMatrix = CGAffineTransformMakeScale(1.0, -1.0);
      CGAffineTransform lineRotationMatrix = CGAffineTransformRotate(CGAffineTransformIdentity, angleOnPath);
      CGAffineTransform linePositionMatrix = CGAffineTransformTranslate(CGAffineTransformIdentity, pointOnPath.x, pointOnPath.y);

      CGAffineTransform textMatrix =
          CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformConcat(runOffsetMatrix, flipMatrix), lineRotationMatrix), linePositionMatrix);
      CGContextSetTextMatrix(context, textMatrix);
      // TODO restore text matrix?

      CTRunDraw(run, context, glyphRange);
    }
  }

  CGContextRestoreGState(context);
}

+ (void)logAvailabeFontNames {
  for (NSString *family in [UIFont familyNames]) {
    NSLog(@"%@", family);

    for (NSString *name in [UIFont fontNamesForFamilyName:family]) {
      NSLog(@"  %@", name);
    }
  }
}

#pragma mark - File System

+ (NSURL *)documentDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)tempDirectory {
  return [NSURL URLWithString:NSTemporaryDirectory()];
}

+ (NSURL *)cacheDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (void)clearTempDirectory {
  NSArray *tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
  for (NSString *file in tmpDirectory) {
    NSLog(@"deleting: %@", file);
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
  }
}

+ (void)clearCacheDirectory {
  NSArray *cacheDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[KPKit cacheDirectory] path] error:NULL];
  for (NSString *file in cacheDirectory) {
    NSLog(@"deleting: %@", file);
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
  }
}

#pragma mark - Foundation type helpers

CGFloat KPMagnitudeOfVector(CGVector vector) { return hypotf((float)vector.dx, (float)vector.dy); }

BOOL KPVectorEqualToVector(CGVector vectorA, CGVector vectorB) { return ((vectorA.dx == vectorB.dx) && (vectorA.dy == vectorB.dy)); }

#pragma mark - Arrays

+ (id)randomObjectIn:(NSArray *)array {
  NSUInteger randomIndex = (NSUInteger)arc4random_uniform((u_int32_t)[array count]);
  return [array objectAtIndex:randomIndex];
}

+ (NSNumber *)meanOf:(NSArray *)array {
  double runningTotal = 0.0;

  for (NSNumber *number in array) {
    runningTotal += [number doubleValue];
  }

  return [NSNumber numberWithDouble:(runningTotal / [array count])];
}

+ (NSNumber *)standardDeviationOf:(NSArray *)array {
  if (![array count]) return nil;

  double mean = [[self meanOf:array] doubleValue];
  double sumOfSquaredDifferences = 0.0;

  for (NSNumber *number in array) {
    double valueOfNumber = [number doubleValue];
    double difference = valueOfNumber - mean;
    sumOfSquaredDifferences += difference * difference;
  }

  return [NSNumber numberWithDouble:sqrt(sumOfSquaredDifferences / [array count])];
}

#pragma mark - Images

+ (UIImage *)imageFromColor:(UIColor *)color {
  CGRect rect = CGRectMake(0, 0, 1, 1);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1]
  // CGColor]) ;
  CGContextFillRect(context, rect);
  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}

#pragma mark - Views

+ (UIView *)firstSuperviewOfView:(UIView *)view thatIsKindOfClass:(__unsafe_unretained Class)someClass {
  if (view.superview) {
    if ([view.superview isKindOfClass:someClass]) {
      // Found it
      return view.superview;
    } else {
      // Keep climbing recursively
      return [self firstSuperviewOfView:view.superview thatIsKindOfClass:someClass];
    }
  } else {
    // Rached the top... no superview of the class we want
    return nil;
  }
}

// goes deep
+ (NSArray *)subviewsOfView:(UIView *)view thatAreKindOfClass:(__unsafe_unretained Class)someClass {
  NSMutableArray *classySubviews = [@[] mutableCopy];
  for (UIView *subview in view.subviews) {
    if ([subview isKindOfClass:someClass]) {
      [classySubviews addObject:subview];
    }

    NSArray *subSubViews = [KPKit subviewsOfView:subview thatAreKindOfClass:someClass];
    [classySubviews addObjectsFromArray:subSubViews];
  }
  return classySubviews;
}

CGPoint KPPolarToCartesian(CGFloat theta, CGFloat radius) {
#if CGFLOAT_IS_DOUBLE
  return CGPointMake(radius * cos(theta), radius * sin(theta));
#else
  return CGPointMake(radius * cosf(theta), radius * sinf(theta));
#endif
}

CGFloat KPRectLongestSide(CGRect rect) { return MAX(rect.size.width, rect.size.height); }

// Flip coordinate space, useful for going between from core to UI frameworks
CGPoint KPCIImagePointToUIImagePoint(CGPoint coreImagePoint, UIImage *image) { return CGPointMake(coreImagePoint.x, image.size.height - coreImagePoint.y); }

CGRect KPCIImageRectToUIImagePRect(CGRect coreImageRect, UIImage *image) {
  return CGRectMake(coreImageRect.origin.x, (image.size.height - coreImageRect.origin.y) - coreImageRect.size.height, coreImageRect.size.width,
                    coreImageRect.size.height);
};

CGRect KPSquareRectThatFitsOutside(CGRect rect) {
  if (rect.size.width > rect.size.height) {
    // increase height
    CGFloat heightIncrease = rect.size.width - rect.size.height;
    return CGRectMake(rect.origin.x, rect.origin.y - heightIncrease / 2, rect.size.width, rect.size.height + heightIncrease);
  } else if (rect.size.height > rect.size.width) {
    // increase width
    CGFloat widthIncrease = rect.size.height - rect.size.width;
    return CGRectMake(rect.origin.x - widthIncrease / 2, rect.origin.y, rect.size.width + widthIncrease, rect.size.height);
  } else {
    // Image was already square
    return rect;
  }
}

CGRect KPSquareRectThatFitsInside(CGRect rect) {
  if (rect.size.height > rect.size.width) {
    // decrease height
    CGFloat heightDecrease = rect.size.height - rect.size.width;
    return CGRectMake(rect.origin.x, rect.origin.y + heightDecrease / 2, rect.size.width, rect.size.height - heightDecrease);
  } else if (rect.size.width > rect.size.height) {
    // decrease width
    CGFloat widthDecrease = rect.size.width - rect.size.height;
    return CGRectMake(rect.origin.x + widthDecrease / 2, rect.origin.y, rect.size.width - widthDecrease, rect.size.height);
  } else {
    // Image was already square
    return rect;
  }
}

// Hmm... clockwise rotation?
// Returns radian angle between -PI and PI.
// "Origin" is the positive X axis
// Clockwise is positive
CGFloat KPAngleBetweenCGPoint(CGPoint startPoint, CGPoint endPoint) {
#if CGFLOAT_IS_DOUBLE
  CGFloat angle = -atan2(endPoint.x - startPoint.x, endPoint.y - startPoint.y) + M_PI_2;
#else
  CGFloat angle = -atan2f(endPoint.x - startPoint.x, endPoint.y - startPoint.y) + M_PI_2;
#endif
  // ugly, but hopefully faster than fmod-based wrap
  if (angle > M_PI) {
    angle -= (M_PI * 2);
  }
  return angle;
}

CGFloat KPDistanceBetweenCGPoint(CGPoint startPoint, CGPoint endPoint) {
#if CGFLOAT_IS_DOUBLE
  return hypotf(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
#else
  return hypot(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
#endif
}

CGPoint KPLinearInterpolateBetweenCGPoint(CGPoint startPoint, CGPoint endPoint, CGFloat amount) {
  return CGPointMake(startPoint.x + ((endPoint.x - startPoint.x) * amount), startPoint.y + ((endPoint.y - startPoint.y) * amount));
}

CGRect KPSqareAroundPoint(CGPoint point, CGFloat side) { return KPRectAroundPoint(point, CGSizeMake(side, side)); }

CGRect KPRectAroundPoint(CGPoint point, CGSize size) { return CGRectMake(point.x - size.width / 2, point.y - size.height / 2, size.width, size.height); }

// Vectory stuff
CGPoint KPPointAdd(CGPoint a, CGPoint b) { return CGPointMake(a.x + b.x, a.y + b.y); }
CGPoint KPPointSubtract(CGPoint a, CGPoint b) { return CGPointMake(a.x - b.x, a.y - b.y); }

CGPoint KPPointMultiplyScalar(CGPoint point, CGFloat scalar) { return CGPointMake(point.x * scalar, point.y * scalar); }
CGPoint KPPointDivideScalar(CGPoint point, CGFloat scalar) { return CGPointMake(point.x / scalar, point.y / scalar); }
CGPoint KPPointNormalize(CGPoint point) {
  CGFloat magnitude = KPPointGetMagnitude(point);
  if (magnitude == 0 || magnitude == 1) {
    return point;

  } else {
    return KPPointDivideScalar(point, magnitude);
  }
}

CGFloat KPPointGetMagnitude(CGPoint point) { return KPDistanceBetweenCGPoint(CGPointZero, point); }
CGPoint KPPointSetMagnitude(CGPoint point, CGFloat magnitude) { return KPPointMultiplyScalar(KPPointNormalize(point), magnitude); }

CGPoint KPPointMultiply(CGPoint a, CGPoint b) { return CGPointMake(a.x * b.x, a.y * b.y); }
CGPoint KPPointDivide(CGPoint a, CGPoint b) { return CGPointMake(a.x / b.x, a.y / b.y); }

CGPoint KPRectGetMidPoint(CGRect rect) { return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)); }

@end
