#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KPKit : NSObject

// Credits
// http://matt.coneybeare.me/my-favorite-macros-for-objective-c-development-in-xcode/
// https://github.com/mureev/ObjCMacros/blob/master/ObjCMacros/ObjCMacros.h
// http://lists.apple.com/archives/xcode-users/2005/Dec/msg00707.html
// https://github.com/openframeworks/openFrameworks/tree/master/libs/openFrameworks/math
// http://nshipster.com/__attribute__/

// Macros
#define KP_IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] || [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"])
#define KP_IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define KP_IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"] || [[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"])
#define KP_IS_IPHONE_UI ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
#define KP_IS_IPAD_UI ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define KP_IS_WIDESCREEN (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define KP_IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2)
#define KP_IS_MULTITASKING                                                                                                                                     \
  ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)] && [[UIDevice currentDevice] isMultitaskingSupported])
#define KP_COLOR_RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]
#define KP_COLOR_RGB(r, g, b) LP_RGBA(r, g, b, 1.0f)
#define KP_COLOR_HEX(hex)                                                                                                                                      \
  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1.0]
#define KP_LOG_FUNCTION NSLog((@"%s (%s:%d)"), __PRETTY_FUNCTION__, ((strrchr(__FILE__, '/') ?: __FILE__ - 1) + 1), __LINE__);

// Random (TODO convert to overloadable functions)
+ (NSInteger)randomInt:(NSInteger)value;
+ (CGFloat)randomBetweenA:(CGFloat)a andB:(CGFloat)b;
+ (NSInteger)randomIntBetweenA:(NSInteger)a andB:(NSInteger)b;

// Color (TODO convert to overloadable functions)
+ (UIColor *)randomColor;
+ (UIColor *)colorWithAlpha:(UIColor *)color alpha:(CGFloat)alpha;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alphaValue;
+ (UIColor *)randomBrightnessOfColor:(UIColor *)color;
+ (UIColor *)color:(UIColor *)color withBrightness:(CGFloat)value;

// File System
+ (NSURL *)documentDirectory;
+ (NSURL *)tempDirectory;
+ (NSURL *)cacheDirectory;
+ (void)clearTempDirectory;
+ (void)clearCacheDirectory;

// Text
+ (void)drawText:(NSAttributedString *)text onPath:(UIBezierPath *)path inContext:(CGContextRef)context withAlignment:(NSTextAlignment)alignment;

// Foundation type helpers

CGFloat KPMagnitudeOfVector(CGVector vector);
BOOL KPVectorEqualToVector(CGVector vectorA, CGVector vectorB);

CGFloat KPAngleBetweenCGPoint(CGPoint startPoint, CGPoint endPoint);
CGFloat KPDistanceBetweenCGPoint(CGPoint startPoint, CGPoint endPoint);
CGPoint KPLinearInterpolateBetweenCGPoint(CGPoint startPoint, CGPoint endPoint, CGFloat amount);

CGPoint KPPolarToCartesian(CGFloat theta, CGFloat radius);

// Arrays
+ (id)randomObjectIn:(NSArray *)array;
+ (NSNumber *)meanOf:(NSArray *)array;
+ (NSNumber *)standardDeviationOf:(NSArray *)array;

// Images
+ (UIImage *)imageFromColor:(UIColor *)color;

// Views
+ (UIView *)firstSuperviewOfView:(UIView *)view thatIsKindOfClass:(__unsafe_unretained Class)someClass;

// Math (overloads generated via template_generator.py)
float __attribute__((overloadable)) KPClamp(float value, float min, float max);
double __attribute__((overloadable)) KPClamp(double value, double min, double max);
long double __attribute__((overloadable)) KPClamp(long double value, long double min, long double max);

float __attribute__((overloadable)) KPMap(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMap(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMap(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapAndClamp(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapAndClamp(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapAndClamp(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPNormalize(float value, float min, float max);
double __attribute__((overloadable)) KPNormalize(double value, double min, double max);
long double __attribute__((overloadable)) KPNormalize(long double value, long double min, long double max);

float __attribute__((overloadable)) KPDistance(float x1, float y1, float x2, float y2);
double __attribute__((overloadable)) KPDistance(double x1, double y1, double x2, double y2);
long double __attribute__((overloadable)) KPDistance(long double x1, long double y1, long double x2, long double y2);

float __attribute__((overloadable)) KPDistanceSquared(float x1, float y1, float x2, float y2);
double __attribute__((overloadable)) KPDistanceSquared(double x1, double y1, double x2, double y2);
long double __attribute__((overloadable)) KPDistanceSquared(long double x1, long double y1, long double x2, long double y2);

float __attribute__((overloadable)) KPLerp(float start, float end, float amount);
double __attribute__((overloadable)) KPLerp(double start, double end, double amount);
long double __attribute__((overloadable)) KPLerp(long double start, long double end, long double amount);

float __attribute__((overloadable)) KPRadiansToDegrees(float radians);
double __attribute__((overloadable)) KPRadiansToDegrees(double radians);
long double __attribute__((overloadable)) KPRadiansToDegrees(long double radians);

float __attribute__((overloadable)) KPDegreesToRadians(float degrees);
double __attribute__((overloadable)) KPDegreesToRadians(double degrees);
long double __attribute__((overloadable)) KPDegreesToRadians(long double degrees);

float __attribute__((overloadable)) KPAngleDifferenceDegrees(float currentAngle, float targetAngle);
double __attribute__((overloadable)) KPAngleDifferenceDegrees(double currentAngle, double targetAngle);
long double __attribute__((overloadable)) KPAngleDifferenceDegrees(long double currentAngle, long double targetAngle);

float __attribute__((overloadable)) KPAngleDifferenceRadians(float currentAngle, float targetAngle);
double __attribute__((overloadable)) KPAngleDifferenceRadians(double currentAngle, double targetAngle);
long double __attribute__((overloadable)) KPAngleDifferenceRadians(long double currentAngle, long double targetAngle);

float __attribute__((overloadable)) KPWrap(float value, float from, float to);
double __attribute__((overloadable)) KPWrap(double value, double from, double to);
long double __attribute__((overloadable)) KPWrap(long double value, long double from, long double to);

float __attribute__((overloadable)) KPWrapRadians(float angle);
double __attribute__((overloadable)) KPWrapRadians(double angle);
long double __attribute__((overloadable)) KPWrapRadians(long double angle);

float __attribute__((overloadable)) KPWrapDegrees(float angle);
double __attribute__((overloadable)) KPWrapDegrees(double angle);
long double __attribute__((overloadable)) KPWrapDegrees(long double angle);

float __attribute__((overloadable)) KPLerpDegrees(float currentAngle, float targetAngle, float pct);
double __attribute__((overloadable)) KPLerpDegrees(double currentAngle, double targetAngle, double pct);
long double __attribute__((overloadable)) KPLerpDegrees(long double currentAngle, long double targetAngle, long double pct);

float __attribute__((overloadable)) KPLerpRadians(float currentAngle, float targetAngle, float pct);
double __attribute__((overloadable)) KPLerpRadians(double currentAngle, double targetAngle, double pct);
long double __attribute__((overloadable)) KPLerpRadians(long double currentAngle, long double targetAngle, long double pct);

float __attribute__((overloadable)) KPInterpolateCosine(float y1, float y2, float pct);
double __attribute__((overloadable)) KPInterpolateCosine(double y1, double y2, float pct);
long double __attribute__((overloadable)) KPInterpolateCosine(long double y1, long double y2, float pct);

float __attribute__((overloadable)) KPInterpolateCubic(float y0, float y1, float y2, float y3, float pct);
double __attribute__((overloadable)) KPInterpolateCubic(double y0, double y1, double y2, double y3, double pct);
long double __attribute__((overloadable)) KPInterpolateCubic(long double y0, long double y1, long double y2, long double y3, long double pct);

float __attribute__((overloadable)) KPInterpolateCatmullRom(float y0, float y1, float y2, float y3, float pct);
double __attribute__((overloadable)) KPInterpolateCatmullRom(double y0, double y1, double y2, double y3, double pct);
long double __attribute__((overloadable)) KPInterpolateCatmullRom(long double y0, long double y1, long double y2, long double y3, long double pct);

float __attribute__((overloadable)) KPInterpolateHermite(float y0, float y1, float y2, float y3, float pct);
double __attribute__((overloadable)) KPInterpolateHermite(double y0, double y1, double y2, double y3, double pct);
long double __attribute__((overloadable)) KPInterpolateHermite(long double y0, long double y1, long double y2, long double y3, long double pct);

float __attribute__((overloadable)) KPInterpolateHermite(float y0, float y1, float y2, float y3, float pct, float tension, float bias);
double __attribute__((overloadable)) KPInterpolateHermite(double y0, double y1, double y2, double y3, double pct, double tension, double bias);
long double __attribute__((overloadable))
KPInterpolateHermite(long double y0, long double y1, long double y2, long double y3, long double pct, long double tension, long double bias);

// Easing (overloads generated via template_generator.py)
float __attribute__((overloadable)) KPEaseInBack(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInBack(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInBack(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutBack(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutBack(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutBack(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutBack(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutBack(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutBack(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInBounce(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInBounce(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInBounce(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutBounce(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutBounce(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutBounce(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutBounce(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutBounce(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutBounce(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInCirc(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInCirc(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInCirc(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutCirc(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutCirc(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutCirc(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutCirc(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutCirc(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutCirc(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInCubic(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInCubic(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInCubic(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutCubic(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutCubic(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutCubic(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutCubic(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutCubic(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutCubic(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInElastic(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInElastic(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInElastic(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutElastic(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutElastic(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutElastic(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutElastic(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutElastic(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutElastic(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInExpo(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInExpo(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInExpo(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutExpo(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutExpo(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutExpo(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutExpo(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutExpo(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutExpo(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInLinear(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInLinear(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInLinear(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutLinear(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutLinear(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutLinear(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutLinear(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutLinear(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutLinear(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInQuad(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInQuad(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInQuad(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutQuad(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutQuad(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutQuad(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutQuad(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutQuad(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutQuad(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInQuart(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInQuart(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInQuart(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutQuart(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutQuart(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutQuart(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutQuart(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutQuart(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutQuart(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInQuint(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInQuint(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInQuint(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutQuint(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutQuint(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutQuint(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutQuint(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutQuint(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutQuint(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInSine(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInSine(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInSine(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseOutSine(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseOutSine(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseOutSine(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPEaseInOutSine(float t, float b, float c, float d);
double __attribute__((overloadable)) KPEaseInOutSine(double t, double b, double c, double d);
long double __attribute__((overloadable)) KPEaseInOutSine(long double t, long double b, long double c, long double d);

float __attribute__((overloadable)) KPMapEaseInBack(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInBack(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInBack(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutBack(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutBack(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutBack(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutBack(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutBack(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutBack(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInBounce(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInBounce(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInBounce(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutBounce(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutBounce(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutBounce(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutBounce(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutBounce(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutBounce(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInCirc(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInCirc(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInCirc(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutCirc(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutCirc(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutCirc(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutCirc(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutCirc(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutCirc(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInCubic(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInCubic(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInCubic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutCubic(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutCubic(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutCubic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutCubic(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutCubic(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutCubic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInElastic(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInElastic(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInElastic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutElastic(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutElastic(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutElastic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutElastic(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutElastic(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable))
KPMapEaseInOutElastic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInExpo(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInExpo(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInExpo(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutExpo(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutExpo(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutExpo(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutExpo(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutExpo(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutExpo(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInLinear(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInLinear(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInLinear(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutLinear(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutLinear(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutLinear(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutLinear(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutLinear(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutLinear(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInQuad(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInQuad(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInQuad(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutQuad(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutQuad(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutQuad(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutQuad(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutQuad(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutQuad(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInQuart(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInQuart(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInQuart(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutQuart(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutQuart(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutQuart(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutQuart(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutQuart(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutQuart(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInQuint(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInQuint(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInQuint(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutQuint(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutQuint(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutQuint(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutQuint(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutQuint(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutQuint(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInSine(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInSine(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInSine(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseOutSine(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseOutSine(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseOutSine(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

float __attribute__((overloadable)) KPMapEaseInOutSine(float value, float minIn, float maxIn, float minOut, float maxOut);
double __attribute__((overloadable)) KPMapEaseInOutSine(double value, double minIn, double maxIn, double minOut, double maxOut);
long double __attribute__((overloadable)) KPMapEaseInOutSine(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut);

@end
