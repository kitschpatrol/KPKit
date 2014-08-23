#pragma mark - Math (overloads generated via template_generator.py)

#import "KPMath.h"
#import <tgmath.h> // Type generic math to handle CGFloat

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

float __attribute__((overloadable)) KPDistanceSquared(float x1, float y1, float x2, float y2) { return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2); }

double __attribute__((overloadable)) KPDistanceSquared(double x1, double y1, double x2, double y2) { return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2); }

long double __attribute__((overloadable)) KPDistanceSquared(long double x1, long double y1, long double x2, long double y2) {
  return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
}

float __attribute__((overloadable)) KPDistance(float x1, float y1, float x2, float y2) { return sqrt(KPDistanceSquared(x1, y1, x2, y2)); }

double __attribute__((overloadable)) KPDistance(double x1, double y1, double x2, double y2) { return sqrt(KPDistanceSquared(x1, y1, x2, y2)); }

long double __attribute__((overloadable)) KPDistance(long double x1, long double y1, long double x2, long double y2) {
  return sqrt(KPDistanceSquared(x1, y1, x2, y2));
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

void KPSwapCGFloat(CGFloat *a, CGFloat *b) {
  CGFloat swapTemp = *a;
  *b = *a;
  *a = swapTemp;
}

CGFloat KPWrap(CGFloat value, CGFloat from, CGFloat to) {
  if (from > to) {
    KPSwapCGFloat(&from, &to);
  }

  return KPModKeepSign(value - from, to - from) + from;
}

float __attribute__((overloadable)) KPWrapRadians(float angle) { return KPWrap(angle, (float)-M_PI, (float)M_PI); }

double __attribute__((overloadable)) KPWrapRadians(double angle) { return KPWrap(angle, (double)-M_PI, (double)M_PI); }

long double __attribute__((overloadable)) KPWrapRadians(long double angle) { return KPWrap(angle, (long double)-M_PI, (long double)M_PI); }

float __attribute__((overloadable)) KPWrapDegrees(float angle) { return KPWrap(angle, (float)-180, (float)180); }

double __attribute__((overloadable)) KPWrapDegrees(double angle) { return KPWrap(angle, (double)-180, (double)180); }

long double __attribute__((overloadable)) KPWrapDegrees(long double angle) { return KPWrap(angle, (long double)-180, (long double)180); }

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

// Floating-point modulo
// The result (the remainder) has same sign as the divisor.
// Similar to matlab's mod(); Not similar to fmod() -   Mod(-3,4)= 1   fmod(-3,4)= -3
CGFloat KPModKeepSign(CGFloat x, CGFloat y) {
  if (y == 0) {
    return x;
  }

  // ??? need double here for precision?
  double m = x - y * floor(x / y);

  // handle boundary cases resulted from floating-point cut off:

  if (y > 0) {    // modulo range: [0..y)
    if (m >= y) { // Mod(-1e-16             , 360.    ): m= 360.
      return 0;
    }

    if (m < 0) {
      if (y + m == y) {
        return 0; // just in case...
      } else {
        return y + m; // Mod(106.81415022205296 , _TWO_PI ): m= -1.421e-14
      }
    }
  } else // modulo range: (y..0]
  {
    if (m <= y) { // Mod(1e-16              , -360.   ): m= -360.
      return 0;
    }
    if (m > 0) {
      if (y + m == y) {
        return 0; // just in case...
      } else {
        return y + m; // Mod(-106.81415022205296, -_TWO_PI): m= 1.421e-14
      }
    }
  }

  return m;
}




