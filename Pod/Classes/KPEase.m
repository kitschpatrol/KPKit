#import "KPMath.h"
#import "KPEase.h"

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
