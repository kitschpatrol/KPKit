#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KPKit : NSObject

// Credits...
// http://matt.coneybeare.me/my-favorite-macros-for-objective-c-development-in-xcode/
// https://github.com/mureev/ObjCMacros/blob/master/ObjCMacros/ObjCMacros.h
// http://lists.apple.com/archives/xcode-users/2005/Dec/msg00707.html

// Macros
#define KP_IS_IPHONE            ([[[UIDevice currentDevice] model] isEqualToString: @"iPhone"] || [[[UIDevice currentDevice] model] isEqualToString: @"iPhone Simulator"])
#define KP_IS_IPOD              ([[[UIDevice currentDevice] model] isEqualToString: @"iPod touch"])
#define KP_IS_IPAD              ([[[UIDevice currentDevice] model] isEqualToString: @"iPad"] || [[[UIDevice currentDevice] model] isEqualToString: @"iPad Simulator"])
#define KP_IS_IPHONE_UI         ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
#define KP_IS_IPAD_UI           ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define KP_IS_WIDESCREEN        (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define KP_IS_RETINA            ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2)
#define KP_IS_MULTITASKING      ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)] && [[UIDevice currentDevice] isMultitaskingSupported])
#define KP_COLOR_RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define KP_COLOR_RGB(r,g,b)     LP_RGBA(r, g, b, 1.0f)
#define KP_COLOR_HEX(hex)       [UIColor colorWithRed: ((float)((hex & 0xFF0000) >> 16)) / 255.0 green: ((float)((hex & 0xFF00) >> 8)) / 255.0 blue: ((float)(hex & 0xFF)) / 255.0 alpha: 1.0]
#define KP_LOG_FUNCTION         NSLog((@"%s (%s:%d)"), __PRETTY_FUNCTION__, ((strrchr(__FILE__, '/') ?: __FILE__ - 1) + 1), __LINE__);

// Handy math functions
+ (CGFloat)map:(CGFloat)value fromMin:(CGFloat)min1 max:(CGFloat)max1 toMin:(CGFloat)min2 max:(CGFloat)max2;
+ (double)mapDouble:(double)value fromMin:(double)min1 max:(double)max1 toMin:(double)min2 max:(double)max2;
+ (CGFloat)mapClamp:(CGFloat)value fromMin:(CGFloat)min1 max:(CGFloat)max1 toMin:(CGFloat)min2 max:(CGFloat)max2;
+ (double)clampDouble:(double)value betweenMin:(double)min max:(double)max;
+ (CGFloat)clamp:(CGFloat)value betweenMin:(CGFloat)min max:(CGFloat)max;
+ (CGFloat)lerpBetweenA:(CGFloat)a B:(CGFloat)b byAmount:(CGFloat)amount;
+ (NSInteger)randomInt:(NSInteger)value;
+ (NSInteger)randomIntBetweenA:(NSInteger)a andB:(NSInteger)b;
+ (CGFloat)randomBetweenA:(CGFloat)a andB:(CGFloat)b;
+ (CGFloat)degreesInRadians:(CGFloat)radianValue;
+ (CGFloat)radiansInDegrees:(CGFloat)degreeValue;
+ (UIColor *)randomColor;
+ (UIColor *)colorWithAlpha:(UIColor *)color alpha:(CGFloat)alpha;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alphaValue;
+ (UIColor *)randomBrightnessOfColor:(UIColor *)color;

// File functions
+ (NSURL *)documentDirectory;
+ (NSURL *)tempDirectory;
+ (NSURL *)cacheDirectory;

// Easing functions in C


CGFloat distanceBetweenCGPoint(CGPoint startPoint, CGPoint endPoint);
CGFloat magnitudeOfVector(CGVector vector);
bool CGVectorEqualToVector(CGVector vectorA, CGVector vectorB);

+ (UIColor *)color:(UIColor *)color withBrightness:(CGFloat)value;


CGFloat easeInBack(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutBack(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutBack(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInBounce(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutBounce(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutBounce(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInCirc(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutCirc(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutCirc(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInCubic(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutCubic(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutCubic(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInElastic(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutElastic(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutElastic(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInExpo(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutExpo(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutExpo(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInLinear(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutLinear(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutLinear(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInQuad(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutQuad(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutQuad(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInQuart(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutQuart(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutQuart(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInQuint(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutQuint(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutQuint(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

CGFloat easeInSine(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeOutSine(CGFloat t,CGFloat b , CGFloat c, CGFloat d);
CGFloat easeInOutSine(CGFloat t,CGFloat b , CGFloat c, CGFloat d);

// Ease functions mapped
+ (CGFloat)mapEaseInBack:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutBack:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutBack:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInBounce:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutBounce:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutBounce:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInCirc:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutCirc:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutCirc:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInCubic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutCubic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutCubic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInElastic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutElastic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutElastic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInExpo:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutExpo:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutExpo:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInLinear:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutLinear:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutLinear:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInQuad:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutQuad:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutQuad:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInQuart:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutQuart:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutQuart:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInQuint:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutQuint:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutQuint:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInSine:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseOutSine:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;
+ (CGFloat)mapEaseInOutSine:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2;

// Handy Array functions
+ (id)randomObjectIn:(NSArray *)array;
+ (NSNumber *)meanOf:(NSArray *)array;
+ (NSNumber *)standardDeviationOf:(NSArray *)array;

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (UIView *)firstSuperviewOfView:(UIView *)view thatIsKindOfClass:(__unsafe_unretained Class)someClass;


+ (void)clearTempDirectory;
+ (void)clearCacheDirectory;

@end
