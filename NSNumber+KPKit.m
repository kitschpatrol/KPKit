#import "NSNumber+KPKit.h"

// http://stackoverflow.com/questions/17067723/nsnumber-from-cgfloat

@implementation NSNumber (KPKit)

+ (NSNumber *)kp_numberWithCGFloat:(CGFloat)value {
#if CGFLOAT_IS_DOUBLE
  return [NSNumber numberWithDouble:(double)value];
#else
  return [NSNumber numberWithFloat:value];
#endif
}

- (CGFloat)kp_CGFloatValue {
#if CGFLOAT_IS_DOUBLE
  return [self doubleValue];
#else
  return [self floatValue];
#endif
}

@end
