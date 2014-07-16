#import <tgmath.h> // Type generic math to handle CGFloat

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
