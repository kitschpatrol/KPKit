#import "KPKit.h"
#import <UIKit/UIKit.h>
#include <tgmath.h> // Type generic math to handle CGFloat
#include "UIBezierPath+KPKit.h"

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

+ (void)drawText:(NSAttributedString *)text onPath:(UIBezierPath *)path inContext:(CGContextRef)context withAlignment:(NSTextAlignment)alignment {
  NSAssert((alignment != NSTextAlignmentJustified), @"Justified text alginment not supported for drawing text on a path.");
  NSAssert((alignment != NSTextAlignmentNatural), @"Natural text alginment not supported for drawing text on a path.");

  CGContextSaveGState(context);

  CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)text);
  NSAssert(line != NULL, @"Problems creating core text line reference.");

  CFArrayRef runArray = CTLineGetGlyphRuns(line);
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

#pragma mark - Math (overloads generated via template_generator.py)

float __attribute__((overloadable)) KPClamp(float value, float min, float max) { return value < min ? min : value > max ? max : value; }

double __attribute__((overloadable)) KPClamp(double value, double min, double max) { return value < min ? min : value > max ? max : value; }

long double __attribute__((overloadable)) KPClamp(long double value, long double min, long double max) { return value < min ? min : value > max ? max : value; }

float __attribute__((overloadable)) KPMap(float value, float minIn, float maxIn, float minOut, float maxOut) {
  float rangeLength1 = maxIn - minIn;
  float rangeLength2 = maxOut - minOut;
  float multiplier = (value - minIn) / rangeLength1;
  return multiplier * rangeLength2 + minOut;
}

double __attribute__((overloadable)) KPMap(double value, double minIn, double maxIn, double minOut, double maxOut) {
  double rangeLength1 = maxIn - minIn;
  double rangeLength2 = maxOut - minOut;
  double multiplier = (value - minIn) / rangeLength1;
  return multiplier * rangeLength2 + minOut;
}

long double __attribute__((overloadable)) KPMap(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  long double rangeLength1 = maxIn - minIn;
  long double rangeLength2 = maxOut - minOut;
  long double multiplier = (value - minIn) / rangeLength1;
  return multiplier * rangeLength2 + minOut;
}

float __attribute__((overloadable)) KPMapAndClamp(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPClamp(KPMap(value, minIn, maxIn, minOut, maxOut), minOut, maxOut);
}

double __attribute__((overloadable)) KPMapAndClamp(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPClamp(KPMap(value, minIn, maxIn, minOut, maxOut), minOut, maxOut);
}

long double __attribute__((overloadable)) KPMapAndClamp(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPClamp(KPMap(value, minIn, maxIn, minOut, maxOut), minOut, maxOut);
}

float __attribute__((overloadable)) KPNormalize(float value, float min, float max) { return KPClamp((value - min) / (max - min), 0, 1); }

double __attribute__((overloadable)) KPNormalize(double value, double min, double max) { return KPClamp((value - min) / (max - min), 0, 1); }

long double __attribute__((overloadable)) KPNormalize(long double value, long double min, long double max) {
  return KPClamp((value - min) / (max - min), 0, 1);
}

float __attribute__((overloadable)) KPDistance(float x1, float y1, float x2, float y2) { return sqrt(KPDistanceSquared(x1, y1, x2, y2)); }

double __attribute__((overloadable)) KPDistance(double x1, double y1, double x2, double y2) { return sqrt(KPDistanceSquared(x1, y1, x2, y2)); }

long double __attribute__((overloadable)) KPDistance(long double x1, long double y1, long double x2, long double y2) {
  return sqrt(KPDistanceSquared(x1, y1, x2, y2));
}

float __attribute__((overloadable)) KPDistanceSquared(float x1, float y1, float x2, float y2) { return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2); }

double __attribute__((overloadable)) KPDistanceSquared(double x1, double y1, double x2, double y2) { return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2); }

long double __attribute__((overloadable)) KPDistanceSquared(long double x1, long double y1, long double x2, long double y2) {
  return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
}

float __attribute__((overloadable)) KPLerp(float start, float end, float amount) {
  float range = end - start;
  return start + range * amount;
}

float __attribute__((overloadable)) KPInRange(float t, float min, float max) { return t >= min && t <= max; }

double __attribute__((overloadable)) KPLerp(double start, double end, double amount) {
  double range = end - start;
  return start + range * amount;
}

double __attribute__((overloadable)) KPInRange(double t, double min, double max) { return t >= min && t <= max; }

long double __attribute__((overloadable)) KPLerp(long double start, long double end, long double amount) {
  long double range = end - start;
  return start + range * amount;
}

long double __attribute__((overloadable)) KPInRange(long double t, long double min, long double max) { return t >= min && t <= max; }

float __attribute__((overloadable)) KPRadiansToDegrees(float radians) { return radians * (180.0 / M_PI); }

double __attribute__((overloadable)) KPRadiansToDegrees(double radians) { return radians * (180.0 / M_PI); }

long double __attribute__((overloadable)) KPRadiansToDegrees(long double radians) { return radians * (180.0 / M_PI); }

float __attribute__((overloadable)) KPDegreesToRadians(float degrees) { return degrees * (M_PI / 180.0); }

double __attribute__((overloadable)) KPDegreesToRadians(double degrees) { return degrees * (M_PI / 180.0); }

long double __attribute__((overloadable)) KPDegreesToRadians(long double degrees) { return degrees * (M_PI / 180.0); }

float __attribute__((overloadable)) KPAngleDifferenceDegrees(float currentAngle, float targetAngle) { return KPWrapDegrees(targetAngle - currentAngle); }

double __attribute__((overloadable)) KPAngleDifferenceDegrees(double currentAngle, double targetAngle) { return KPWrapDegrees(targetAngle - currentAngle); }

long double __attribute__((overloadable)) KPAngleDifferenceDegrees(long double currentAngle, long double targetAngle) {
  return KPWrapDegrees(targetAngle - currentAngle);
}

float __attribute__((overloadable)) KPAngleDifferenceRadians(float currentAngle, float targetAngle) { return KPWrapRadians(targetAngle - currentAngle); }

double __attribute__((overloadable)) KPAngleDifferenceRadians(double currentAngle, double targetAngle) { return KPWrapRadians(targetAngle - currentAngle); }

long double __attribute__((overloadable)) KPAngleDifferenceRadians(long double currentAngle, long double targetAngle) {
  return KPWrapRadians(targetAngle - currentAngle);
}

float __attribute__((overloadable)) KPWrap(float value, float from, float to) {
  // algorithm from http://stackoverflow.com/a/5852628/599884
  if (from > to) {
    float swapTemp = from;
    from = to;
    to = swapTemp;
  }
  float cycle = to - from;
  if (cycle == 0) {
    return to;
  }
  return value - cycle * floor((value - from) / cycle);
}

double __attribute__((overloadable)) KPWrap(double value, double from, double to) {
  // algorithm from http://stackoverflow.com/a/5852628/599884
  if (from > to) {
    double swapTemp = from;
    from = to;
    to = swapTemp;
  }
  double cycle = to - from;
  if (cycle == 0) {
    return to;
  }
  return value - cycle * floor((value - from) / cycle);
}

long double __attribute__((overloadable)) KPWrap(long double value, long double from, long double to) {
  // algorithm from http://stackoverflow.com/a/5852628/599884
  if (from > to) {
    long double swapTemp = from;
    from = to;
    to = swapTemp;
  }
  long double cycle = to - from;
  if (cycle == 0) {
    return to;
  }
  return value - cycle * floor((value - from) / cycle);
}

float __attribute__((overloadable)) KPWrapRadians(float angle) { return KPWrap(angle, (float)-M_PI, (float)M_PI); }

double __attribute__((overloadable)) KPWrapRadians(double angle) { return KPWrap(angle, (double)-M_PI, (double)M_PI); }

long double __attribute__((overloadable)) KPWrapRadians(long double angle) { return KPWrap(angle, (long double)-M_PI, (long double)M_PI); }

float __attribute__((overloadable)) KPWrapDegrees(float angle) { return KPWrap(angle, (float)-180, (float)180); }

double __attribute__((overloadable)) KPWrapDegrees(double angle) { return KPWrap(angle, (double)-180, (double)180); }

long double __attribute__((overloadable)) KPWrapDegrees(long double angle) { return KPWrap(angle, (long double)-180, (long double)180); }

float __attribute__((overloadable)) KPLerpDegrees(float currentAngle, float targetAngle, float pct) {
  return currentAngle + KPAngleDifferenceDegrees(currentAngle, targetAngle) * pct;
}

double __attribute__((overloadable)) KPLerpDegrees(double currentAngle, double targetAngle, double pct) {
  return currentAngle + KPAngleDifferenceDegrees(currentAngle, targetAngle) * pct;
}

long double __attribute__((overloadable)) KPLerpDegrees(long double currentAngle, long double targetAngle, long double pct) {
  return currentAngle + KPAngleDifferenceDegrees(currentAngle, targetAngle) * pct;
}

float __attribute__((overloadable)) KPLerpRadians(float currentAngle, float targetAngle, float pct) {
  return currentAngle + KPAngleDifferenceRadians(currentAngle, targetAngle) * pct;
}

double __attribute__((overloadable)) KPLerpRadians(double currentAngle, double targetAngle, double pct) {
  return currentAngle + KPAngleDifferenceRadians(currentAngle, targetAngle) * pct;
}

long double __attribute__((overloadable)) KPLerpRadians(long double currentAngle, long double targetAngle, long double pct) {
  return currentAngle + KPAngleDifferenceRadians(currentAngle, targetAngle) * pct;
}

float __attribute__((overloadable)) KPInterpolateCosine(float y1, float y2, float pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float pct2;
  pct2 = (1 - cos(pct * M_PI)) / 2;
  return (y1 * (1 - pct2) + y2 * pct2);
}

double __attribute__((overloadable)) KPInterpolateCosine(double y1, double y2, float pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float pct2;
  pct2 = (1 - cos(pct * M_PI)) / 2;
  return (y1 * (1 - pct2) + y2 * pct2);
}

long double __attribute__((overloadable)) KPInterpolateCosine(long double y1, long double y2, float pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float pct2;
  pct2 = (1 - cos(pct * M_PI)) / 2;
  return (y1 * (1 - pct2) + y2 * pct2);
}

float __attribute__((overloadable)) KPInterpolateCubic(float y0, float y1, float y2, float y3, float pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float a0, a1, a2, a3;
  float pct2;

  pct2 = pct * pct;
  a0 = y3 - y2 - y0 + y1;
  a1 = y0 - y1 - a0;
  a2 = y2 - y0;
  a3 = y1;

  return (a0 * pct * pct2 + a1 * pct2 + a2 * pct + a3);
}

double __attribute__((overloadable)) KPInterpolateCubic(double y0, double y1, double y2, double y3, double pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  double a0, a1, a2, a3;
  float pct2;

  pct2 = pct * pct;
  a0 = y3 - y2 - y0 + y1;
  a1 = y0 - y1 - a0;
  a2 = y2 - y0;
  a3 = y1;

  return (a0 * pct * pct2 + a1 * pct2 + a2 * pct + a3);
}

long double __attribute__((overloadable)) KPInterpolateCubic(long double y0, long double y1, long double y2, long double y3, long double pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  long double a0, a1, a2, a3;
  float pct2;

  pct2 = pct * pct;
  a0 = y3 - y2 - y0 + y1;
  a1 = y0 - y1 - a0;
  a2 = y2 - y0;
  a3 = y1;

  return (a0 * pct * pct2 + a1 * pct2 + a2 * pct + a3);
}

float __attribute__((overloadable)) KPInterpolateCatmullRom(float y0, float y1, float y2, float y3, float pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float a0, a1, a2, a3;
  float pct2 = pct * pct;
  a0 = -0.5 * y0 + 1.5 * y1 - 1.5 * y2 + 0.5 * y3;
  a1 = y0 - 2.5 * y1 + 2 * y2 - 0.5 * y3;
  a2 = -0.5 * y0 + 0.5 * y2;
  a3 = y1;
  return (a0 * pct * pct2 + a1 * pct2 + a2 * pct + a3);
}

double __attribute__((overloadable)) KPInterpolateCatmullRom(double y0, double y1, double y2, double y3, double pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  double a0, a1, a2, a3;
  float pct2 = pct * pct;
  a0 = -0.5 * y0 + 1.5 * y1 - 1.5 * y2 + 0.5 * y3;
  a1 = y0 - 2.5 * y1 + 2 * y2 - 0.5 * y3;
  a2 = -0.5 * y0 + 0.5 * y2;
  a3 = y1;
  return (a0 * pct * pct2 + a1 * pct2 + a2 * pct + a3);
}

long double __attribute__((overloadable)) KPInterpolateCatmullRom(long double y0, long double y1, long double y2, long double y3, long double pct) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  long double a0, a1, a2, a3;
  float pct2 = pct * pct;
  a0 = -0.5 * y0 + 1.5 * y1 - 1.5 * y2 + 0.5 * y3;
  a1 = y0 - 2.5 * y1 + 2 * y2 - 0.5 * y3;
  a2 = -0.5 * y0 + 0.5 * y2;
  a3 = y1;
  return (a0 * pct * pct2 + a1 * pct2 + a2 * pct + a3);
}

float __attribute__((overloadable)) KPInterpolateHermite(float y0, float y1, float y2, float y3, float pct) {
  // from http://musicdsp.org/showArchiveComment.php?ArchiveID=93
  // laurent de soras
  const float c = (y2 - y0) * 0.5f;
  const float v = y1 - y2;
  const float w = c + v;
  const float a = w + v + (y3 - y1) * 0.5f;
  const float b_neg = w + a;

  return ((((a * pct) - b_neg) * pct + c) * pct + y1);
}

double __attribute__((overloadable)) KPInterpolateHermite(double y0, double y1, double y2, double y3, double pct) {
  // from http://musicdsp.org/showArchiveComment.php?ArchiveID=93
  // laurent de soras
  const double c = (y2 - y0) * 0.5f;
  const double v = y1 - y2;
  const double w = c + v;
  const double a = w + v + (y3 - y1) * 0.5f;
  const double b_neg = w + a;

  return ((((a * pct) - b_neg) * pct + c) * pct + y1);
}

long double __attribute__((overloadable)) KPInterpolateHermite(long double y0, long double y1, long double y2, long double y3, long double pct) {
  // from http://musicdsp.org/showArchiveComment.php?ArchiveID=93
  // laurent de soras
  const long double c = (y2 - y0) * 0.5f;
  const long double v = y1 - y2;
  const long double w = c + v;
  const long double a = w + v + (y3 - y1) * 0.5f;
  const long double b_neg = w + a;

  return ((((a * pct) - b_neg) * pct + c) * pct + y1);
}

float __attribute__((overloadable)) KPInterpolateHermite(float y0, float y1, float y2, float y3, float pct, float tension, float bias) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float pct2, pct3;
  float m0, m1;
  float a0, a1, a2, a3;

  pct2 = pct * pct;
  pct3 = pct2 * pct;
  m0 = (y1 - y0) * (1 + bias) * (1 - tension) / 2;
  m0 += (y2 - y1) * (1 - bias) * (1 - tension) / 2;
  m1 = (y2 - y1) * (1 + bias) * (1 - tension) / 2;
  m1 += (y3 - y2) * (1 - bias) * (1 - tension) / 2;
  a0 = (float)(2 * pct3 - 3 * pct2 + 1);
  a1 = (float)(pct3 - 2 * pct2 + pct);
  a2 = (float)(pct3 - pct2);
  a3 = (float)(-2 * pct3 + 3 * pct2);

  return (a0 * y1 + a1 * m0 + a2 * m1 + a3 * y2);
}

double __attribute__((overloadable)) KPInterpolateHermite(double y0, double y1, double y2, double y3, double pct, double tension, double bias) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float pct2, pct3;
  double m0, m1;
  double a0, a1, a2, a3;

  pct2 = pct * pct;
  pct3 = pct2 * pct;
  m0 = (y1 - y0) * (1 + bias) * (1 - tension) / 2;
  m0 += (y2 - y1) * (1 - bias) * (1 - tension) / 2;
  m1 = (y2 - y1) * (1 + bias) * (1 - tension) / 2;
  m1 += (y3 - y2) * (1 - bias) * (1 - tension) / 2;
  a0 = (double)(2 * pct3 - 3 * pct2 + 1);
  a1 = (double)(pct3 - 2 * pct2 + pct);
  a2 = (double)(pct3 - pct2);
  a3 = (double)(-2 * pct3 + 3 * pct2);

  return (a0 * y1 + a1 * m0 + a2 * m1 + a3 * y2);
}

long double __attribute__((overloadable))
KPInterpolateHermite(long double y0, long double y1, long double y2, long double y3, long double pct, long double tension, long double bias) {
  // from http://paulbourke.net/miscellaneous/interpolation/
  float pct2, pct3;
  long double m0, m1;
  long double a0, a1, a2, a3;

  pct2 = pct * pct;
  pct3 = pct2 * pct;
  m0 = (y1 - y0) * (1 + bias) * (1 - tension) / 2;
  m0 += (y2 - y1) * (1 - bias) * (1 - tension) / 2;
  m1 = (y2 - y1) * (1 + bias) * (1 - tension) / 2;
  m1 += (y3 - y2) * (1 - bias) * (1 - tension) / 2;
  a0 = (long double)(2 * pct3 - 3 * pct2 + 1);
  a1 = (long double)(pct3 - 2 * pct2 + pct);
  a2 = (long double)(pct3 - pct2);
  a3 = (long double)(-2 * pct3 + 3 * pct2);

  return (a0 * y1 + a1 * m0 + a2 * m1 + a3 * y2);
}

#pragma mark - Easing (overloads generated via template_generator.py)

// Via Futil, via Robert Penner, and Jesús Gollonet's port of openFrameworks.
float __attribute__((overloadable)) KPEaseInBack(float t, float b, float c, float d) {
  float s = 1.70158;
  float postFix = t /= d;
  return c * (postFix)*t * ((s + 1) * t - s) + b;
}

double __attribute__((overloadable)) KPEaseInBack(double t, double b, double c, double d) {
  double s = 1.70158;
  double postFix = t /= d;
  return c * (postFix)*t * ((s + 1) * t - s) + b;
}

long double __attribute__((overloadable)) KPEaseInBack(long double t, long double b, long double c, long double d) {
  long double s = 1.70158;
  long double postFix = t /= d;
  return c * (postFix)*t * ((s + 1) * t - s) + b;
}

float __attribute__((overloadable)) KPEaseOutBack(float t, float b, float c, float d) {
  float s = 1.70158;
  t = t / d - 1;
  return c * (t * t * ((s + 1) * t + s) + 1) + b;
}

double __attribute__((overloadable)) KPEaseOutBack(double t, double b, double c, double d) {
  double s = 1.70158;
  t = t / d - 1;
  return c * (t * t * ((s + 1) * t + s) + 1) + b;
}

long double __attribute__((overloadable)) KPEaseOutBack(long double t, long double b, long double c, long double d) {
  long double s = 1.70158;
  t = t / d - 1;
  return c * (t * t * ((s + 1) * t + s) + 1) + b;
}

float __attribute__((overloadable)) KPEaseInOutBack(float t, float b, float c, float d) {
  float s = 1.70158;

  if ((t /= d / 2) < 1) {
    s *= 1.525f;
    return c / 2 * (t * t * ((s + 1) * t - s)) + b;
  } else {
    float postFix = t -= 2;
    s *= 1.525f;
    return c / 2 * ((postFix)*t * ((s + 1) * t + s) + 2) + b;
  }
}

double __attribute__((overloadable)) KPEaseInOutBack(double t, double b, double c, double d) {
  double s = 1.70158;

  if ((t /= d / 2) < 1) {
    s *= 1.525f;
    return c / 2 * (t * t * ((s + 1) * t - s)) + b;
  } else {
    double postFix = t -= 2;
    s *= 1.525f;
    return c / 2 * ((postFix)*t * ((s + 1) * t + s) + 2) + b;
  }
}

long double __attribute__((overloadable)) KPEaseInOutBack(long double t, long double b, long double c, long double d) {
  long double s = 1.70158;

  if ((t /= d / 2) < 1) {
    s *= 1.525f;
    return c / 2 * (t * t * ((s + 1) * t - s)) + b;
  } else {
    long double postFix = t -= 2;
    s *= 1.525f;
    return c / 2 * ((postFix)*t * ((s + 1) * t + s) + 2) + b;
  }
}

float __attribute__((overloadable)) KPEaseInBounce(float t, float b, float c, float d) { return c - KPEaseOutBounce(d - t, 0, c, d) + b; }

double __attribute__((overloadable)) KPEaseInBounce(double t, double b, double c, double d) { return c - KPEaseOutBounce(d - t, 0, c, d) + b; }

long double __attribute__((overloadable)) KPEaseInBounce(long double t, long double b, long double c, long double d) {
  return c - KPEaseOutBounce(d - t, 0, c, d) + b;
}

float __attribute__((overloadable)) KPEaseOutBounce(float t, float b, float c, float d) {
  if ((t /= d) < (1 / 2.75f)) {
    return c * (7.5625f * t * t) + b;
  } else if (t < (2 / 2.75f)) {
    float postFix = t -= (1.5f / 2.75f);
    return c * (7.5625f * (postFix)*t + .75f) + b;
  } else if (t < (2.5 / 2.75)) {
    float postFix = t -= (2.25f / 2.75f);
    return c * (7.5625f * (postFix)*t + .9375f) + b;
  } else {
    float postFix = t -= (2.625f / 2.75f);
    return c * (7.5625f * (postFix)*t + .984375f) + b;
  }
}

double __attribute__((overloadable)) KPEaseOutBounce(double t, double b, double c, double d) {
  if ((t /= d) < (1 / 2.75f)) {
    return c * (7.5625f * t * t) + b;
  } else if (t < (2 / 2.75f)) {
    double postFix = t -= (1.5f / 2.75f);
    return c * (7.5625f * (postFix)*t + .75f) + b;
  } else if (t < (2.5 / 2.75)) {
    double postFix = t -= (2.25f / 2.75f);
    return c * (7.5625f * (postFix)*t + .9375f) + b;
  } else {
    double postFix = t -= (2.625f / 2.75f);
    return c * (7.5625f * (postFix)*t + .984375f) + b;
  }
}

long double __attribute__((overloadable)) KPEaseOutBounce(long double t, long double b, long double c, long double d) {
  if ((t /= d) < (1 / 2.75f)) {
    return c * (7.5625f * t * t) + b;
  } else if (t < (2 / 2.75f)) {
    long double postFix = t -= (1.5f / 2.75f);
    return c * (7.5625f * (postFix)*t + .75f) + b;
  } else if (t < (2.5 / 2.75)) {
    long double postFix = t -= (2.25f / 2.75f);
    return c * (7.5625f * (postFix)*t + .9375f) + b;
  } else {
    long double postFix = t -= (2.625f / 2.75f);
    return c * (7.5625f * (postFix)*t + .984375f) + b;
  }
}

float __attribute__((overloadable)) KPEaseInOutBounce(float t, float b, float c, float d) {
  if (t < d / 2)
    return KPEaseInBounce(t * 2, 0, c, d) * .5f + b;
  else
    return KPEaseOutBounce(t * 2 - d, 0, c, d) * .5f + c * .5f + b;
}

double __attribute__((overloadable)) KPEaseInOutBounce(double t, double b, double c, double d) {
  if (t < d / 2)
    return KPEaseInBounce(t * 2, 0, c, d) * .5f + b;
  else
    return KPEaseOutBounce(t * 2 - d, 0, c, d) * .5f + c * .5f + b;
}

long double __attribute__((overloadable)) KPEaseInOutBounce(long double t, long double b, long double c, long double d) {
  if (t < d / 2)
    return KPEaseInBounce(t * 2, 0, c, d) * .5f + b;
  else
    return KPEaseOutBounce(t * 2 - d, 0, c, d) * .5f + c * .5f + b;
}

float __attribute__((overloadable)) KPEaseInCirc(float t, float b, float c, float d) {
  t /= d;
  return -c * (sqrt(1 - t * t) - 1) + b;
}

double __attribute__((overloadable)) KPEaseInCirc(double t, double b, double c, double d) {
  t /= d;
  return -c * (sqrt(1 - t * t) - 1) + b;
}

long double __attribute__((overloadable)) KPEaseInCirc(long double t, long double b, long double c, long double d) {
  t /= d;
  return -c * (sqrt(1 - t * t) - 1) + b;
}

float __attribute__((overloadable)) KPEaseOutCirc(float t, float b, float c, float d) {
  t /= d;
  t--;
  return c * sqrt(1 - t * t) + b;
}

double __attribute__((overloadable)) KPEaseOutCirc(double t, double b, double c, double d) {
  t /= d;
  t--;
  return c * sqrt(1 - t * t) + b;
}

long double __attribute__((overloadable)) KPEaseOutCirc(long double t, long double b, long double c, long double d) {
  t /= d;
  t--;
  return c * sqrt(1 - t * t) + b;
}

float __attribute__((overloadable)) KPEaseInOutCirc(float t, float b, float c, float d) {
  t /= d / 2;
  if (t < 1) return -c / 2 * (sqrt(1 - t * t) - 1) + b;
  t -= 2;
  return c / 2 * (sqrt(1 - t * t) + 1) + b;
}

double __attribute__((overloadable)) KPEaseInOutCirc(double t, double b, double c, double d) {
  t /= d / 2;
  if (t < 1) return -c / 2 * (sqrt(1 - t * t) - 1) + b;
  t -= 2;
  return c / 2 * (sqrt(1 - t * t) + 1) + b;
}

long double __attribute__((overloadable)) KPEaseInOutCirc(long double t, long double b, long double c, long double d) {
  t /= d / 2;
  if (t < 1) return -c / 2 * (sqrt(1 - t * t) - 1) + b;
  t -= 2;
  return c / 2 * (sqrt(1 - t * t) + 1) + b;
}

float __attribute__((overloadable)) KPEaseInCubic(float t, float b, float c, float d) {
  t /= d;
  return c * t * t * t + b;
}

double __attribute__((overloadable)) KPEaseInCubic(double t, double b, double c, double d) {
  t /= d;
  return c * t * t * t + b;
}

long double __attribute__((overloadable)) KPEaseInCubic(long double t, long double b, long double c, long double d) {
  t /= d;
  return c * t * t * t + b;
}

float __attribute__((overloadable)) KPEaseOutCubic(float t, float b, float c, float d) {
  t = t / d - 1;
  return c * (t * t * t + 1) + b;
}

double __attribute__((overloadable)) KPEaseOutCubic(double t, double b, double c, double d) {
  t = t / d - 1;
  return c * (t * t * t + 1) + b;
}

long double __attribute__((overloadable)) KPEaseOutCubic(long double t, long double b, long double c, long double d) {
  t = t / d - 1;
  return c * (t * t * t + 1) + b;
}

float __attribute__((overloadable)) KPEaseInOutCubic(float t, float b, float c, float d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t + b;
  t -= 2;
  return c / 2 * (t * t * t + 2) + b;
}

double __attribute__((overloadable)) KPEaseInOutCubic(double t, double b, double c, double d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t + b;
  t -= 2;
  return c / 2 * (t * t * t + 2) + b;
}

long double __attribute__((overloadable)) KPEaseInOutCubic(long double t, long double b, long double c, long double d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t + b;
  t -= 2;
  return c / 2 * (t * t * t + 2) + b;
}

float __attribute__((overloadable)) KPEaseInElastic(float t, float b, float c, float d) {
  if (t == 0) return b;
  if ((t /= d) == 1) return b + c;
  float p = d * 0.3;
  float a = c;
  float s = p / 4;
  float postFix = a * pow(2, 10 *(t -= 1)); // this is a fix, again, with post-increment operators
  return -(postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
}

double __attribute__((overloadable)) KPEaseInElastic(double t, double b, double c, double d) {
  if (t == 0) return b;
  if ((t /= d) == 1) return b + c;
  double p = d * 0.3;
  double a = c;
  double s = p / 4;
  double postFix = a * pow(2, 10 *(t -= 1)); // this is a fix, again, with post-increment operators
  return -(postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
}

long double __attribute__((overloadable)) KPEaseInElastic(long double t, long double b, long double c, long double d) {
  if (t == 0) return b;
  if ((t /= d) == 1) return b + c;
  long double p = d * 0.3;
  long double a = c;
  long double s = p / 4;
  long double postFix = a * pow(2, 10 *(t -= 1)); // this is a fix, again, with post-increment operators
  return -(postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
}

float __attribute__((overloadable)) KPEaseOutElastic(float t, float b, float c, float d) {
  if (t == 0) return b;
  if ((t /= d) == 1) return b + c;
  float p = d * 0.3;
  float a = c;
  float s = p / 4;
  return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / p) + c + b);
}

double __attribute__((overloadable)) KPEaseOutElastic(double t, double b, double c, double d) {
  if (t == 0) return b;
  if ((t /= d) == 1) return b + c;
  double p = d * 0.3;
  double a = c;
  double s = p / 4;
  return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / p) + c + b);
}

long double __attribute__((overloadable)) KPEaseOutElastic(long double t, long double b, long double c, long double d) {
  if (t == 0) return b;
  if ((t /= d) == 1) return b + c;
  long double p = d * 0.3;
  long double a = c;
  long double s = p / 4;
  return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / p) + c + b);
}

float __attribute__((overloadable)) KPEaseInOutElastic(float t, float b, float c, float d) {
  if (t == 0) return b;
  if ((t /= d / 2) == 2) return b + c;
  float p = d * (.3f * 1.5f);
  float a = c;
  float s = p / 4;

  if (t < 1) {
    float postFix = a * pow(2, 10 *(t -= 1)); // postIncrement is evil
    return -.5f * (postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
  }
  float postFix = a * pow(2, -10 *(t -= 1)); // postIncrement is evil
  return postFix * sin((t * d - s) * (2 * M_PI) / p) * .5f + c + b;
}

double __attribute__((overloadable)) KPEaseInOutElastic(double t, double b, double c, double d) {
  if (t == 0) return b;
  if ((t /= d / 2) == 2) return b + c;
  double p = d * (.3f * 1.5f);
  double a = c;
  double s = p / 4;

  if (t < 1) {
    double postFix = a * pow(2, 10 *(t -= 1)); // postIncrement is evil
    return -.5f * (postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
  }
  double postFix = a * pow(2, -10 *(t -= 1)); // postIncrement is evil
  return postFix * sin((t * d - s) * (2 * M_PI) / p) * .5f + c + b;
}

long double __attribute__((overloadable)) KPEaseInOutElastic(long double t, long double b, long double c, long double d) {
  if (t == 0) return b;
  if ((t /= d / 2) == 2) return b + c;
  long double p = d * (.3f * 1.5f);
  long double a = c;
  long double s = p / 4;

  if (t < 1) {
    long double postFix = a * pow(2, 10 *(t -= 1)); // postIncrement is evil
    return -.5f * (postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
  }
  long double postFix = a * pow(2, -10 *(t -= 1)); // postIncrement is evil
  return postFix * sin((t * d - s) * (2 * M_PI) / p) * .5f + c + b;
}

float __attribute__((overloadable)) KPEaseInExpo(float t, float b, float c, float d) { return (t == 0) ? b : c * pow(2, 10 * (t / d - 1)) + b; }

double __attribute__((overloadable)) KPEaseInExpo(double t, double b, double c, double d) { return (t == 0) ? b : c * pow(2, 10 * (t / d - 1)) + b; }

long double __attribute__((overloadable)) KPEaseInExpo(long double t, long double b, long double c, long double d) {
  return (t == 0) ? b : c * pow(2, 10 * (t / d - 1)) + b;
}

float __attribute__((overloadable)) KPEaseOutExpo(float t, float b, float c, float d) { return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b; }

double __attribute__((overloadable)) KPEaseOutExpo(double t, double b, double c, double d) { return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b; }

long double __attribute__((overloadable)) KPEaseOutExpo(long double t, long double b, long double c, long double d) {
  return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b;
}

float __attribute__((overloadable)) KPEaseInOutExpo(float t, float b, float c, float d) {
  if (t == 0) return b;
  if (t == d) return b + c;
  if ((t /= d / 2) < 1) return c / 2 * pow(2, 10 * (t - 1)) + b;
  return c / 2 * (-pow(2, -10 * --t) + 2) + b;
}

double __attribute__((overloadable)) KPEaseInOutExpo(double t, double b, double c, double d) {
  if (t == 0) return b;
  if (t == d) return b + c;
  if ((t /= d / 2) < 1) return c / 2 * pow(2, 10 * (t - 1)) + b;
  return c / 2 * (-pow(2, -10 * --t) + 2) + b;
}

long double __attribute__((overloadable)) KPEaseInOutExpo(long double t, long double b, long double c, long double d) {
  if (t == 0) return b;
  if (t == d) return b + c;
  if ((t /= d / 2) < 1) return c / 2 * pow(2, 10 * (t - 1)) + b;
  return c / 2 * (-pow(2, -10 * --t) + 2) + b;
}

float __attribute__((overloadable)) KPEaseInLinear(float t, float b, float c, float d) { return c * t / d + b; }

double __attribute__((overloadable)) KPEaseInLinear(double t, double b, double c, double d) { return c * t / d + b; }

long double __attribute__((overloadable)) KPEaseInLinear(long double t, long double b, long double c, long double d) { return c * t / d + b; }

float __attribute__((overloadable)) KPEaseOutLinear(float t, float b, float c, float d) { return c * t / d + b; }

double __attribute__((overloadable)) KPEaseOutLinear(double t, double b, double c, double d) { return c * t / d + b; }

long double __attribute__((overloadable)) KPEaseOutLinear(long double t, long double b, long double c, long double d) { return c * t / d + b; }

float __attribute__((overloadable)) KPEaseInOutLinear(float t, float b, float c, float d) { return c * t / d + b; }

double __attribute__((overloadable)) KPEaseInOutLinear(double t, double b, double c, double d) { return c * t / d + b; }

long double __attribute__((overloadable)) KPEaseInOutLinear(long double t, long double b, long double c, long double d) { return c * t / d + b; }

float __attribute__((overloadable)) KPEaseInQuad(float t, float b, float c, float d) {
  t /= d;
  return c * t * t + b;
}

double __attribute__((overloadable)) KPEaseInQuad(double t, double b, double c, double d) {
  t /= d;
  return c * t * t + b;
}

long double __attribute__((overloadable)) KPEaseInQuad(long double t, long double b, long double c, long double d) {
  t /= d;
  return c * t * t + b;
}

float __attribute__((overloadable)) KPEaseOutQuad(float t, float b, float c, float d) {
  t /= d;
  return -c * t * (t - 2) + b;
}

double __attribute__((overloadable)) KPEaseOutQuad(double t, double b, double c, double d) {
  t /= d;
  return -c * t * (t - 2) + b;
}

long double __attribute__((overloadable)) KPEaseOutQuad(long double t, long double b, long double c, long double d) {
  t /= d;
  return -c * t * (t - 2) + b;
}

float __attribute__((overloadable)) KPEaseInOutQuad(float t, float b, float c, float d) {
  t /= d / 2;
  if (t < 1) return ((c / 2) * (t * t)) + b;
  return -c / 2 * (((t - 2) * ((t - 1))) - 1) + b;
  /*
   originally return -c/2 * (((t-2)*(--t)) - 1) + b;

   I've had to swap (--t)*(t-2) due to diffence in behaviour in
   pre-increment operators between java and c++, after hours
   of joy
   */
}

double __attribute__((overloadable)) KPEaseInOutQuad(double t, double b, double c, double d) {
  t /= d / 2;
  if (t < 1) return ((c / 2) * (t * t)) + b;
  return -c / 2 * (((t - 2) * ((t - 1))) - 1) + b;
  /*
   originally return -c/2 * (((t-2)*(--t)) - 1) + b;

   I've had to swap (--t)*(t-2) due to diffence in behaviour in
   pre-increment operators between java and c++, after hours
   of joy
   */
}

long double __attribute__((overloadable)) KPEaseInOutQuad(long double t, long double b, long double c, long double d) {
  t /= d / 2;
  if (t < 1) return ((c / 2) * (t * t)) + b;
  return -c / 2 * (((t - 2) * ((t - 1))) - 1) + b;
  /*
   originally return -c/2 * (((t-2)*(--t)) - 1) + b;

   I've had to swap (--t)*(t-2) due to diffence in behaviour in
   pre-increment operators between java and c++, after hours
   of joy
   */
}

float __attribute__((overloadable)) KPEaseInQuart(float t, float b, float c, float d) {
  t /= d;
  return c * t * t * t * t + b;
}

double __attribute__((overloadable)) KPEaseInQuart(double t, double b, double c, double d) {
  t /= d;
  return c * t * t * t * t + b;
}

long double __attribute__((overloadable)) KPEaseInQuart(long double t, long double b, long double c, long double d) {
  t /= d;
  return c * t * t * t * t + b;
}

float __attribute__((overloadable)) KPEaseOutQuart(float t, float b, float c, float d) {
  t = t / d - 1;
  return -c * (t * t * t * t - 1) + b;
}

double __attribute__((overloadable)) KPEaseOutQuart(double t, double b, double c, double d) {
  t = t / d - 1;
  return -c * (t * t * t * t - 1) + b;
}

long double __attribute__((overloadable)) KPEaseOutQuart(long double t, long double b, long double c, long double d) {
  t = t / d - 1;
  return -c * (t * t * t * t - 1) + b;
}

float __attribute__((overloadable)) KPEaseInOutQuart(float t, float b, float c, float d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t * t + b;
  t -= 2;
  return -c / 2 * (t * t * t * t - 2) + b;
}

double __attribute__((overloadable)) KPEaseInOutQuart(double t, double b, double c, double d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t * t + b;
  t -= 2;
  return -c / 2 * (t * t * t * t - 2) + b;
}

long double __attribute__((overloadable)) KPEaseInOutQuart(long double t, long double b, long double c, long double d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t * t + b;
  t -= 2;
  return -c / 2 * (t * t * t * t - 2) + b;
}

float __attribute__((overloadable)) KPEaseInQuint(float t, float b, float c, float d) {
  t /= d;
  return c * t * t * t * t * t + b;
}

double __attribute__((overloadable)) KPEaseInQuint(double t, double b, double c, double d) {
  t /= d;
  return c * t * t * t * t * t + b;
}

long double __attribute__((overloadable)) KPEaseInQuint(long double t, long double b, long double c, long double d) {
  t /= d;
  return c * t * t * t * t * t + b;
}

float __attribute__((overloadable)) KPEaseOutQuint(float t, float b, float c, float d) {
  t = t / d - 1;
  return c * (t * t * t * t * t + 1) + b;
}

double __attribute__((overloadable)) KPEaseOutQuint(double t, double b, double c, double d) {
  t = t / d - 1;
  return c * (t * t * t * t * t + 1) + b;
}

long double __attribute__((overloadable)) KPEaseOutQuint(long double t, long double b, long double c, long double d) {
  t = t / d - 1;
  return c * (t * t * t * t * t + 1) + b;
}

float __attribute__((overloadable)) KPEaseInOutQuint(float t, float b, float c, float d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t * t * t + b;
  t -= 2;
  return c / 2 * (t * t * t * t * t + 2) + b;
}

double __attribute__((overloadable)) KPEaseInOutQuint(double t, double b, double c, double d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t * t * t + b;
  t -= 2;
  return c / 2 * (t * t * t * t * t + 2) + b;
}

long double __attribute__((overloadable)) KPEaseInOutQuint(long double t, long double b, long double c, long double d) {
  t /= d / 2;
  if (t < 1) return c / 2 * t * t * t * t * t + b;
  t -= 2;
  return c / 2 * (t * t * t * t * t + 2) + b;
}

float __attribute__((overloadable)) KPEaseInSine(float t, float b, float c, float d) { return -c * cos(t / d * (M_PI / 2)) + c + b; }

double __attribute__((overloadable)) KPEaseInSine(double t, double b, double c, double d) { return -c * cos(t / d * (M_PI / 2)) + c + b; }

long double __attribute__((overloadable)) KPEaseInSine(long double t, long double b, long double c, long double d) {
  return -c * cos(t / d * (M_PI / 2)) + c + b;
}

float __attribute__((overloadable)) KPEaseOutSine(float t, float b, float c, float d) { return c * sin(t / d * (M_PI / 2)) + b; }

double __attribute__((overloadable)) KPEaseOutSine(double t, double b, double c, double d) { return c * sin(t / d * (M_PI / 2)) + b; }

long double __attribute__((overloadable)) KPEaseOutSine(long double t, long double b, long double c, long double d) { return c * sin(t / d * (M_PI / 2)) + b; }

float __attribute__((overloadable)) KPEaseInOutSine(float t, float b, float c, float d) { return -c / 2 * (cos(M_PI * t / d) - 1) + b; }

double __attribute__((overloadable)) KPEaseInOutSine(double t, double b, double c, double d) { return -c / 2 * (cos(M_PI * t / d) - 1) + b; }

long double __attribute__((overloadable)) KPEaseInOutSine(long double t, long double b, long double c, long double d) {
  return -c / 2 * (cos(M_PI * t / d) - 1) + b;
}

float __attribute__((overloadable)) KPMapEaseInBack(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInBack(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInBack(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutBack(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutBack(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutBack(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutBack(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutBack(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutBack(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInBounce(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInBounce(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInBounce(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutBounce(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutBounce(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutBounce(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutBounce(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutBounce(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable))
KPMapEaseInOutBounce(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInCirc(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInCirc(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInCirc(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutCirc(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutCirc(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutCirc(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutCirc(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutCirc(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutCirc(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInCubic(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInCubic(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInCubic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutCubic(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutCubic(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutCubic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutCubic(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutCubic(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutCubic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInElastic(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInElastic(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInElastic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutElastic(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutElastic(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutElastic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutElastic(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutElastic(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable))
KPMapEaseInOutElastic(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInExpo(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInExpo(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInExpo(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutExpo(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutExpo(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutExpo(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutExpo(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutExpo(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutExpo(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInLinear(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInLinear(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInLinear(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutLinear(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutLinear(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutLinear(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutLinear(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutLinear(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable))
KPMapEaseInOutLinear(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInQuad(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInQuad(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInQuad(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutQuad(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutQuad(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutQuad(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutQuad(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutQuad(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutQuad(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInQuart(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInQuart(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInQuart(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutQuart(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutQuart(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutQuart(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutQuart(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutQuart(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutQuart(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInQuint(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInQuint(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInQuint(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutQuint(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutQuint(double value, double minIn, double maxIn, double minOut, double maxOut) {

  return KPEaseOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutQuint(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutQuint(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutQuint(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutQuint(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInSine(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInSine(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInSine(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseOutSine(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseOutSine(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseOutSine(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

float __attribute__((overloadable)) KPMapEaseInOutSine(float value, float minIn, float maxIn, float minOut, float maxOut) {
  return KPEaseInOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

double __attribute__((overloadable)) KPMapEaseInOutSine(double value, double minIn, double maxIn, double minOut, double maxOut) {
  return KPEaseInOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

long double __attribute__((overloadable)) KPMapEaseInOutSine(long double value, long double minIn, long double maxIn, long double minOut, long double maxOut) {
  return KPEaseInOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}

CGPoint KPPolarToCartesian(CGFloat theta, CGFloat radius) {
#if CGFLOAT_IS_DOUBLE
  return CGPointMake(radius * cos(theta), radius * sin(theta));
#else
  return CGPointMake(radius * cosf(theta), radius * sinf(theta));
#endif
}

// Hmm... clockwise rotation?
CGFloat KPAngleBetweenCGPoint(CGPoint startPoint, CGPoint endPoint) {
#if CGFLOAT_IS_DOUBLE
  return -atan2(endPoint.x - startPoint.x, endPoint.y - startPoint.y) + M_PI_2;
#else
  return -atan2f(endPoint.x - startPoint.x, endPoint.y - startPoint.y) + M_PI_2;
#endif
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

@end
