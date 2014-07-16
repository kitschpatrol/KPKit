#import <Foundation/Foundation.h>

@interface NSNumber (KPKit)

+ (NSNumber *)kp_numberWithCGFloat:(CGFloat)value;
- (CGFloat)kp_CGFloatValue;

@end