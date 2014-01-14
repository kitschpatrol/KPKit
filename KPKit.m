#import "KPKit.h"
#import <UIKit/UIKit.h>
#include <tgmath.h> // Type generic math to handle CGFloat

// Pretty major mess... these should be moved to categories eventually.

@implementation KPKit

// Via C4
+ (CGFloat)map:(CGFloat)value fromMin:(CGFloat)min1 max:(CGFloat)max1 toMin:(CGFloat)min2 max:(CGFloat)max2
{
	CGFloat rangeLength1 = max1 - min1;
	CGFloat rangeLength2 = max2 - min2;
	CGFloat multiplier = (value - min1) / rangeLength1;
	return multiplier * rangeLength2 + min2;
}

+ (CGFloat)mapClamp:(CGFloat)value fromMin:(CGFloat)min1 max:(CGFloat)max1 toMin:(CGFloat)min2 max:(CGFloat)max2
{
	return [self clamp:[self map:value fromMin:min1 max:max1 toMin:min2 max:max2] betweenMin:min2 max:max2];
}

+ (CGFloat)clamp:(CGFloat)value betweenMin:(CGFloat)min max:(CGFloat)max
{
	if (value <= min) return min;
	if (value >= max) return max;
	return value;
}

// Via C4
+ (CGFloat)lerpBetweenA:(CGFloat)a B:(CGFloat)b byAmount:(CGFloat)amount
{
	CGFloat range = b - a;
	return a + range * amount;
}

+ (NSInteger)randomInt:(NSInteger)value
{
	return ((NSInteger)arc4random())%value;
}

+ (NSInteger)randomIntBetweenA:(NSInteger)a andB:(NSInteger)b
{
	NSInteger returnVal;
	if (a == b) {
		returnVal = a;
	}
	else {
		NSInteger max = a > b ? a : b;
		NSInteger min = a < b ? a : b;
		NSAssert(max-min > 0, @"Your expression returned true for max-min <= 0 for some reason... max = %ld, min = %ld", (long)max, (long)min);
		returnVal = (((NSInteger)arc4random())%(max-min) + min);
	}
	return returnVal;
}

+ (CGFloat)degreesInRadians:(CGFloat)radianValue
{
	return radianValue * 180.0f / (CGFloat)M_PI;
}

+ (CGFloat)radiansInDegrees:(CGFloat)degreeValue
{
	return degreeValue * (CGFloat)M_PI / 180.0f;
}

+ (UIColor*)randomColor
{
    return [self randomColorWithAlpha:1.0];
}

+ (UIColor*)randomColorWithAlpha:(CGFloat)alphaValue
{
    CGFloat red = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alphaValue];
}




// Easing, via Futil, via Robert Penner, and Jesús Gollonet's port for openFrameworks.

CGFloat easeInBack(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	CGFloat s = 1.70158;
	CGFloat postFix = t/=d;
	return c*(postFix)*t*((s+1)*t - s) + b;
}

CGFloat easeOutBack(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	CGFloat s = 1.70158;
    t=t/d-1;
	return c*(t*t*((s+1)*t + s) + 1) + b;
}

CGFloat easeInOutBack(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	CGFloat s = 1.70158;
    
	if ((t/=d/2) < 1) {
        s*=1.525f;
        return c/2*(t*t*((s+1)*t - s)) + b;
    }
    else {
        CGFloat postFix = t-=2;
        s*=1.525f;
        return c/2*((postFix)*t*((s+1)*t + s) + 2) + b;
    }
}

CGFloat easeInBounce(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return c - easeOutBounce(d-t, 0, c, d) + b;
}

CGFloat easeOutBounce(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	if ((t/=d) < (1/2.75f)) {
		return c*(7.5625f*t*t) + b;
	} else if (t < (2/2.75f)) {
		CGFloat postFix = t-=(1.5f/2.75f);
		return c*(7.5625f*(postFix)*t + .75f) + b;
	} else if (t < (2.5/2.75)) {
        CGFloat postFix = t-=(2.25f/2.75f);
		return c*(7.5625f*(postFix)*t + .9375f) + b;
	} else {
		CGFloat postFix = t-=(2.625f/2.75f);
		return c*(7.5625f*(postFix)*t + .984375f) + b;
	}
}

CGFloat easeInOutBounce(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	if (t < d/2) return easeInBounce(t*2, 0, c, d) * .5f + b;
	else return easeOutBounce(t*2-d, 0, c, d) * .5f + c*.5f + b;
}

CGFloat easeInCirc(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t /= d;
	return -c * (sqrt(1 - t*t) - 1) + b;
}
CGFloat easeOutCirc(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t /= d;
	t--;
	return c * sqrt(1 - t*t) + b;
}

CGFloat easeInOutCirc(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	t /= d/2;
	if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
	t -= 2;
	return c/2 * (sqrt(1 - t*t) + 1) + b;
}

CGFloat easeInCubic(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d;
	return c*t*t*t + b;
}
CGFloat easeOutCubic(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t=t/d-1;
	return c*(t*t*t + 1) + b;
}

CGFloat easeInOutCubic(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d/2;
	if (t < 1) return c/2*t*t*t + b;
    t-=2;
	return c/2*(t*t*t + 2) + b;
}

CGFloat easeInElastic(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	if (t==0) return b;  if ((t/=d)==1) return b+c;
	CGFloat p=d*0.3;
	CGFloat a=c;
	CGFloat s=p/4;
	CGFloat postFix =a*pow(2,10*(t-=1)); // this is a fix, again, with post-increment operators
	return -(postFix * sin((t*d-s)*(2*M_PI)/p )) + b;
}

CGFloat easeOutElastic(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	if (t==0) return b;  if ((t/=d)==1) return b+c;
	CGFloat p=d*0.3;
	CGFloat a=c;
	CGFloat s=p/4;
	return (a*pow(2,-10*t) * sin( (t*d-s)*(2*M_PI)/p ) + c + b);
}

CGFloat easeInOutElastic(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	if (t==0) return b;  if ((t/=d/2)==2) return b+c;
	CGFloat p=d*(.3f*1.5f);
	CGFloat a=c;
	CGFloat s=p/4;
    
	if (t < 1) {
		CGFloat postFix =a*pow(2,10*(t-=1)); // postIncrement is evil
		return -.5f*(postFix* sin( (t*d-s)*(2*M_PI)/p )) + b;
	}
	CGFloat postFix =  a*pow(2,-10*(t-=1)); // postIncrement is evil
	return postFix * sin( (t*d-s)*(2*M_PI)/p )*.5f + c + b;
}

CGFloat easeInExpo(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return (t==0) ? b : c * pow(2, 10 * (t/d - 1)) + b;
}
CGFloat easeOutExpo(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return (t==d) ? b+c : c * (-pow(2, -10 * t/d) + 1) + b;
}

CGFloat easeInOutExpo(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	if (t==0) return b;
	if (t==d) return b+c;
	if ((t/=d/2) < 1) return c/2 * pow(2, 10 * (t - 1)) + b;
	return c/2 * (-pow(2, -10 * --t) + 2) + b;
}

CGFloat easeInLinear(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return c*t/d + b;
}
CGFloat easeOutLinear(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return c*t/d + b;
}

CGFloat easeInOutLinear(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return c*t/d + b;
}

CGFloat easeInQuad(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d;
	return c*t*t + b;
}

CGFloat easeOutQuad(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d;
	return -c *t*(t-2) + b;
}

CGFloat easeInOutQuad(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d/2;
	if (t < 1) return ((c/2)*(t*t)) + b;
	return -c/2 * (((t-2)*((t - 1))) - 1) + b;
	/*
     originally return -c/2 * (((t-2)*(--t)) - 1) + b;
     
     I've had to swap (--t)*(t-2) due to diffence in behaviour in
     pre-increment operators between java and c++, after hours
     of joy
     */
	
}

CGFloat easeInQuart(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d;
	return c*t*t*t*t + b;
}
CGFloat easeOutQuart(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t=t/d-1;
	return -c * (t*t*t*t - 1) + b;
}

CGFloat easeInOutQuart(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d/2;
	if (t < 1) return c/2*t*t*t*t + b;
    t-=2;
	return -c/2 * (t*t*t*t - 2) + b;
}

CGFloat easeInQuint(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d;
	return c*t*t*t*t*t + b;
}
CGFloat easeOutQuint(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t=t/d-1;
	return c*(t*t*t*t*t + 1) + b;
}

CGFloat easeInOutQuint(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
    t/=d/2;
	if (t < 1) return c/2*t*t*t*t*t + b;
    t-=2;
	return c/2*(t*t*t*t*t + 2) + b;
}

CGFloat easeInSine(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return -c * cos(t/d * (M_PI/2)) + c + b;
}
CGFloat easeOutSine(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return c * sin(t/d * (M_PI/2)) + b;
}

CGFloat easeInOutSine(CGFloat t,CGFloat b , CGFloat c, CGFloat d) {
	return -c/2 * (cos(M_PI*t/d) - 1) + b;
}



// Ease mappings, via futil
+ (CGFloat)mapEaseInBack:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInBack(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutBack:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutBack(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutBack:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutBack(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInBounce:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInBounce(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutBounce:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutBounce(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutBounce:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutBounce(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInCirc:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInCirc(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutCirc:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutCirc(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutCirc:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutCirc(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInCubic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInCubic(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutCubic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutCubic(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutCubic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutCubic(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInElastic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInElastic(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutElastic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutElastic(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutElastic:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutElastic(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInExpo:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInExpo(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutExpo:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutExpo(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutExpo:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutExpo(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInLinear:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInLinear(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutLinear:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutLinear(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutLinear:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutLinear(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInQuad:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInQuad(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutQuad:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutQuad(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutQuad:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutQuad(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInQuart:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInQuart(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutQuart:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutQuart(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutQuart:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutQuart(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInQuint:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInQuint(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutQuint:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutQuint(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutQuint:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutQuint(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInSine:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInSine(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseOutSine:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeOutSine(value - low1, low2, high2 - low2, high1 - low1);
}

+ (CGFloat)mapEaseInOutSine:(CGFloat)value fromMin:(CGFloat)low1 max:(CGFloat)high1 toMin:(CGFloat)low2 max:(CGFloat)high2
{
    return easeInOutSine(value - low1, low2, high2 - low2, high1 - low1);
}

// Array helpers
+ (id)randomObjectIn:(NSArray *)array
{
    uint32_t randomIndex = arc4random_uniform([array count]);
    return [array objectAtIndex:randomIndex];
}


+ (NSNumber *)meanOf:(NSArray *)array
{
    double runningTotal = 0.0;
    
    for(NSNumber *number in array) {
        runningTotal += [number doubleValue];
    }
    
    return [NSNumber numberWithDouble:(runningTotal / [array count])];
}

+ (NSNumber *)standardDeviationOf:(NSArray *)array
{
    if(![array count]) return nil;
    
    double mean = [[self meanOf:array] doubleValue];
    double sumOfSquaredDifferences = 0.0;
    
    for(NSNumber *number in array) {
        double valueOfNumber = [number doubleValue];
        double difference = valueOfNumber - mean;
        sumOfSquaredDifferences += difference * difference;
    }
    
    return [NSNumber numberWithDouble:sqrt(sumOfSquaredDifferences / [array count])];
}



+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (NSURL *)documentDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)tempDirectory {
    return [NSURL URLWithString:NSTemporaryDirectory()];
}

+ (NSURL *)cacheDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}


+ (UIView *)firstSuperviewOfView:(UIView *)view thatIsKindOfClass:(__unsafe_unretained Class)someClass {
    if (view.superview) {
        if ([view.superview isKindOfClass:someClass]) {
            // Found it
            return view.superview;
        }
        else {
            // Keep climbing recursively
            return [self firstSuperviewOfView:view.superview thatIsKindOfClass:someClass];
        }
    }
    else {
        // Rached the top... no superview of the class we want
        return nil;
    }
}


@end
