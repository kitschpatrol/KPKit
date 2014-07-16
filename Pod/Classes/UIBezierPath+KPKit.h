#import <UIKit/UIKit.h>

@interface UIBezierPath (KPKit)

// Points along path
@property (nonatomic, assign) CGFloat kp_pointResolution;
@property (nonatomic, assign, readonly) CGFloat kp_length;
@property (nonatomic, assign, readonly) NSArray *kp_points;
@property (nonatomic, assign, readonly) NSArray *kp_angles;

- (CGPoint)kp_pointAtPercent:(CGFloat)percent; // 0.0 - 1.0
- (CGFloat)kp_angleAtPercent:(CGFloat)percent; // 0.0 - 1.0
- (CGPoint)kp_pointAtLength:(CGFloat)length;
- (CGFloat)kp_angleAtLength:(CGFloat)length;
- (void)kp_setNeedsPathPointsUpdate;

// Convenience constructors

+ (UIBezierPath *)kp_bezierPathWithDonut:(CGPoint)center innerRadius:(CGFloat)innerRadius outerRadius:(CGFloat)outerRadius;
+ (UIBezierPath *)kp_bezierPathWithDonut:(CGPoint)center
                             innerRadius:(CGFloat)innerRadius
                             outerRadius:(CGFloat)outerRadius
                              startAngle:(CGFloat)startAngle
                                endAngle:(CGFloat)endAngle
                               clockwise:(BOOL)clockwise;

@end
