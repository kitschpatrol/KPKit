the_types = ["float", "double", "long double"]

function_templates = [
"""
<T> KPClamp(<T> value, <T> min, <T> max) {
	return value < min ? min : value > max ? max : value;
}
""",
"""
<T> KPMap(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
  <T> rangeLength1 = maxIn - minIn;
  <T> rangeLength2 = maxOut - minOut;
  <T> multiplier = (value - minIn) / rangeLength1;
  return multiplier * rangeLength2 + minOut;
}
""",
"""
<T> KPMapAndClamp(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
  return KPClamp(KPMap(value, minIn, maxIn, minOut, maxOut), minOut, maxOut);
}
""",
"""
<T> KPNormalize(<T> value, <T> min, <T> max) {
	return KPClamp((value - min) / (max - min), 0, 1);
}
""",
"""
<T> KPDistance(<T> x1, <T> y1, <T> x2, <T> y2) {
	return sqrt(KPDistanceSquared(x1, y1, x2, y2));
}
""",
"""
<T> KPDistanceSquared(<T> x1, <T> y1, <T> x2, <T> y2) {
	return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
}
""",
"""
<T> KPLerp(<T> start, <T> end, <T> amount) {
    <T> range = end - start;
    return start + range * amount;
}

BOOL KPInRange(<T> t, <T> min, <T> max) {
	return t >= min && t <= max;
}
""",
"""
<T> KPRadiansToDegrees(<T> radians) {
	return radians * (180.0 / M_PI);
}
""",
"""
<T> KPDegreesToRadians(<T> degrees) {
    return degrees * (M_PI / 180.0);
}
""",
"""
<T> KPAngleDifferenceDegrees(<T> currentAngle, <T> targetAngle) {
	return KPWrapDegrees(targetAngle - currentAngle);
}
""",
"""
<T> KPAngleDifferenceRadians(<T> currentAngle, <T> targetAngle) {
	return KPWrapRadians(targetAngle - currentAngle);
}
""",
"""
<T> KPWrap(<T> value, <T> from, <T> to) {
	// algorithm from http://stackoverflow.com/a/5852628/599884
	if (from > to) {
		<T> swapTemp = from;
		from = to;
		to = swapTemp;
	}
	<T> cycle = to - from;
	if (cycle == 0) {
		return to;
	}
	return value - cycle * floor((value - from) / cycle);
}
""",
"""
<T> KPWrapRadians(<T> angle) {
	return KPWrap(angle, (<T>)-M_PI, (<T>)M_PI);
}
""",
"""
<T> KPWrapDegrees(<T> angle) {
	return KPWrap(angle, (<T>)-180, (<T>)180);
}
""",
"""
<T> KPLerpDegrees(<T> currentAngle, <T> targetAngle, <T> pct) {
    return currentAngle + KPAngleDifferenceDegrees(currentAngle, targetAngle) * pct;
}
""",
"""
<T> KPLerpRadians(<T> currentAngle, <T> targetAngle, <T> pct) {
	return currentAngle + KPAngleDifferenceRadians(currentAngle, targetAngle) * pct;
}
""",
"""
<T> KPInterpolateCosine(<T> y1, <T> y2, float pct) {
	// from http://paulbourke.net/miscellaneous/interpolation/
	float pct2;
	pct2 = (1-cos(pct*M_PI))/2;
	return(y1*(1-pct2)+y2*pct2);
}
""",
"""
<T> KPInterpolateCubic(<T> y0, <T> y1, <T> y2, <T> y3, <T> pct) {
	// from http://paulbourke.net/miscellaneous/interpolation/
	<T> a0,a1,a2,a3;
	float pct2;

	pct2 = pct*pct;
	a0 = y3 - y2 - y0 + y1;
	a1 = y0 - y1 - a0;
	a2 = y2 - y0;
	a3 = y1;

	return(a0*pct*pct2+a1*pct2+a2*pct+a3);
}
""",
"""
<T> KPInterpolateCatmullRom(<T> y0, <T> y1, <T> y2, <T> y3, <T> pct) {
	// from http://paulbourke.net/miscellaneous/interpolation/
	<T> a0,a1,a2,a3;
	float pct2 = pct*pct;
	a0 = -0.5*y0 + 1.5*y1 - 1.5*y2 + 0.5*y3;
	a1 = y0 - 2.5*y1 + 2*y2 - 0.5*y3;
	a2 = -0.5*y0 + 0.5*y2;
	a3 = y1;
	return(a0*pct*pct2 + a1*pct2 + a2*pct +a3);
}
""",
"""
<T> KPInterpolateHermite(<T> y0, <T> y1, <T> y2, <T> y3, <T> pct) {
	// from http://musicdsp.org/showArchiveComment.php?ArchiveID=93
	// laurent de soras
	const <T> c = (y2 - y0) * 0.5f;
	const <T> v = y1 - y2;
	const <T> w = c + v;
	const <T> a = w + v + (y3 - y1) * 0.5f;
	const <T> b_neg = w + a;

	return ((((a * pct) - b_neg) * pct + c) * pct + y1);
}
""",
"""
<T> KPInterpolateHermite(<T> y0, <T> y1, <T> y2, <T> y3, <T> pct, <T> tension, <T> bias) {
	// from http://paulbourke.net/miscellaneous/interpolation/
	float pct2,pct3;
	<T> m0,m1;
	<T> a0,a1,a2,a3;

	pct2 = pct * pct;
	pct3 = pct2 * pct;
	m0  = (y1-y0)*(1+bias)*(1-tension)/2;
	m0 += (y2-y1)*(1-bias)*(1-tension)/2;
	m1  = (y2-y1)*(1+bias)*(1-tension)/2;
	m1 += (y3-y2)*(1-bias)*(1-tension)/2;
	a0 =  (<T>)(2*pct3 - 3*pct2 + 1);
	a1 =  (<T>)(pct3 - 2*pct2 + pct);
	a2 =  (<T>)(pct3 -   pct2);
	a3 =  (<T>)(-2*pct3 + 3*pct2);

   return(a0*y1+a1*m0+a2*m1+a3*y2);
}
""",
"""
<T> KPEaseInBack(<T> t, <T> b, <T> c, <T> d) {
    <T> s = 1.70158;
    <T> postFix = t /= d;
    return c * (postFix) * t * ((s + 1) * t - s) + b;
}
""",
"""
<T> KPEaseOutBack(<T> t, <T> b, <T> c, <T> d) {
    <T> s = 1.70158;
    t = t / d - 1;
    return c * (t * t * ((s + 1) * t + s) + 1) + b;
}
""",
"""
<T> KPEaseInOutBack(<T> t, <T> b, <T> c, <T> d) {
    <T> s = 1.70158;
    
    if ((t /= d / 2) < 1) {
        s *= 1.525f;
        return c / 2 * (t * t * ((s + 1) * t - s)) + b;
    } else {
        <T> postFix = t -= 2;
        s *= 1.525f;
        return c / 2 * ((postFix) * t * ((s + 1) * t + s) + 2) + b;
    }
}
""",
"""
<T> KPEaseInBounce(<T> t, <T> b, <T> c, <T> d) {
    return c - KPEaseOutBounce(d - t, 0, c, d) + b;
}
""",
"""
<T> KPEaseOutBounce(<T> t, <T> b, <T> c, <T> d) {
    if ((t /= d) < (1 / 2.75f)) {
        return c * (7.5625f * t * t) + b;
    } else if (t < (2 / 2.75f)) {
        <T> postFix = t -= (1.5f / 2.75f);
        return c * (7.5625f * (postFix) * t + .75f) + b;
    } else if (t < (2.5 / 2.75)) {
        <T> postFix = t -= (2.25f / 2.75f);
        return c * (7.5625f * (postFix) * t + .9375f) + b;
    } else {
        <T> postFix = t -= (2.625f / 2.75f);
        return c * (7.5625f * (postFix) * t + .984375f) + b;
    }
}
""",
"""
<T> KPEaseInOutBounce(<T> t, <T> b, <T> c, <T> d) {
    if (t < d / 2)
        return KPEaseInBounce(t * 2, 0, c, d) * .5f + b;
    else
        return KPEaseOutBounce(t * 2 - d, 0, c, d) * .5f + c * .5f + b;
}
""",
"""
<T> KPEaseInCirc(<T> t, <T> b, <T> c, <T> d) {
    t /= d;
    return -c * (sqrt(1 - t * t) - 1) + b;
}
""",
"""
<T> KPEaseOutCirc(<T> t, <T> b, <T> c, <T> d) {
    t /= d;
    t--;
    return c * sqrt(1 - t * t) + b;
}
""",
"""
<T> KPEaseInOutCirc(<T> t, <T> b, <T> c, <T> d) {
    t /= d / 2;
    if (t < 1)
        return -c / 2 * (sqrt(1 - t * t) - 1) + b;
    t -= 2;
    return c / 2 * (sqrt(1 - t * t) + 1) + b;
}
""",
"""
<T> KPEaseInCubic(<T> t, <T> b, <T> c, <T> d) {
    t /= d;
    return c * t * t * t + b;
}
""",
"""
<T> KPEaseOutCubic(<T> t, <T> b, <T> c, <T> d) {
    t = t / d - 1;
    return c * (t * t * t + 1) + b;
}
""",
"""
<T> KPEaseInOutCubic(<T> t, <T> b, <T> c, <T> d) {
    t /= d / 2;
    if (t < 1)
        return c / 2 * t * t * t + b;
    t -= 2;
    return c / 2 * (t * t * t + 2) + b;
}
""",
"""
<T> KPEaseInElastic(<T> t, <T> b, <T> c, <T> d) {
    if (t == 0)
        return b;
    if ((t /= d) == 1)
        return b + c;
    <T> p = d * 0.3;
    <T> a = c;
    <T> s = p / 4;
    <T> postFix =
    a *
    pow(2,
        10 *(t -= 1)); // this is a fix, again, with post-increment operators
    return -(postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
}
""",
"""
<T> KPEaseOutElastic(<T> t, <T> b, <T> c, <T> d) {
    if (t == 0)
        return b;
    if ((t /= d) == 1)
        return b + c;
    <T> p = d * 0.3;
    <T> a = c;
    <T> s = p / 4;
    return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / p) + c + b);
}
""",
"""
<T> KPEaseInOutElastic(<T> t, <T> b, <T> c, <T> d) {
    if (t == 0)
        return b;
    if ((t /= d / 2) == 2)
        return b + c;
    <T> p = d * (.3f * 1.5f);
    <T> a = c;
    <T> s = p / 4;
    
    if (t < 1) {
        <T> postFix = a * pow(2, 10 *(t -= 1)); // postIncrement is evil
        return -.5f * (postFix * sin((t * d - s) * (2 * M_PI) / p)) + b;
    }
    <T> postFix = a * pow(2, -10 *(t -= 1)); // postIncrement is evil
    return postFix * sin((t * d - s) * (2 * M_PI) / p) * .5f + c + b;
}
""",
"""
<T> KPEaseInExpo(<T> t, <T> b, <T> c, <T> d) {
    return (t == 0) ? b : c * pow(2, 10 * (t / d - 1)) + b;
}
""",
"""
<T> KPEaseOutExpo(<T> t, <T> b, <T> c, <T> d) {
    return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b;
}
""",
"""
<T> KPEaseInOutExpo(<T> t, <T> b, <T> c, <T> d) {
    if (t == 0)
        return b;
    if (t == d)
        return b + c;
    if ((t /= d / 2) < 1)
        return c / 2 * pow(2, 10 * (t - 1)) + b;
    return c / 2 * (-pow(2, -10 * --t) + 2) + b;
}
""",
"""
<T> KPEaseInLinear(<T> t, <T> b, <T> c, <T> d) {
    return c * t / d + b;
}
""",
"""
<T> KPEaseOutLinear(<T> t, <T> b, <T> c, <T> d) {
    return c * t / d + b;
}
""",
"""
<T> KPEaseInOutLinear(<T> t, <T> b, <T> c, <T> d) {
    return c * t / d + b;
}
""",
"""
<T> KPEaseInQuad(<T> t, <T> b, <T> c, <T> d) {
    t /= d;
    return c * t * t + b;
}
""",
"""
<T> KPEaseOutQuad(<T> t, <T> b, <T> c, <T> d) {
    t /= d;
    return -c * t * (t - 2) + b;
}
""",
"""
<T> KPEaseInOutQuad(<T> t, <T> b, <T> c, <T> d) {
    t /= d / 2;
    if (t < 1)
        return ((c / 2) * (t * t)) + b;
    return -c / 2 * (((t - 2) * ((t - 1))) - 1) + b;
    /*
     originally return -c/2 * (((t-2)*(--t)) - 1) + b;
     
     I've had to swap (--t)*(t-2) due to diffence in behaviour in
     pre-increment operators between java and c++, after hours
     of joy
     */
}
""",
"""
<T> KPEaseInQuart(<T> t, <T> b, <T> c, <T> d) {
    t /= d;
    return c * t * t * t * t + b;
}
""",
"""
<T> KPEaseOutQuart(<T> t, <T> b, <T> c, <T> d) {
    t = t / d - 1;
    return -c * (t * t * t * t - 1) + b;
}
""",
"""
<T> KPEaseInOutQuart(<T> t, <T> b, <T> c, <T> d) {
    t /= d / 2;
    if (t < 1)
        return c / 2 * t * t * t * t + b;
    t -= 2;
    return -c / 2 * (t * t * t * t - 2) + b;
}
""",
"""
<T> KPEaseInQuint(<T> t, <T> b, <T> c, <T> d) {
    t /= d;
    return c * t * t * t * t * t + b;
}
""",
"""
<T> KPEaseOutQuint(<T> t, <T> b, <T> c, <T> d) {
    t = t / d - 1;
    return c * (t * t * t * t * t + 1) + b;
}
""",
"""
<T> KPEaseInOutQuint(<T> t, <T> b, <T> c, <T> d) {
    t /= d / 2;
    if (t < 1)
        return c / 2 * t * t * t * t * t + b;
    t -= 2;
    return c / 2 * (t * t * t * t * t + 2) + b;
}
""",
"""
<T> KPEaseInSine(<T> t, <T> b, <T> c, <T> d) {
    return -c * cos(t / d * (M_PI / 2)) + c + b;
}
""",
"""
<T> KPEaseOutSine(<T> t, <T> b, <T> c, <T> d) {
    return c * sin(t / d * (M_PI / 2)) + b;
}
""",
"""
<T> KPEaseInOutSine(<T> t, <T> b, <T> c, <T> d) {
    return -c / 2 * (cos(M_PI * t / d) - 1) + b;
}
""",
"""
<T> KPMapEaseInBack(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutBack(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutBack(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutBack(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInBounce(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutBounce(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutBounce(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutBounce(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInCirc(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutCirc(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutCirc(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutCirc(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInCubic(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutCubic(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutCubic(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutCubic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInElastic(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutElastic(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutElastic(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutElastic(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInExpo(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutExpo(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutExpo(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutExpo(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInLinear(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutLinear(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutLinear(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutLinear(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInQuad(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutQuad(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutQuad(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutQuad(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInQuart(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutQuart(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutQuart(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutQuart(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInQuint(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutQuint(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutQuint(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutQuint(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInSine(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseOutSine(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
""",
"""
<T> KPMapEaseInOutSine(<T> value, <T> minIn, <T> maxIn, <T> minOut, <T> maxOut) {
    return KPEaseInOutSine(value - minIn, minOut, maxOut - minOut, maxIn - minIn);
}
"""
]

def template_to_function(function_template, the_type):
	# First one gets __attribute__ flag
	output = function_template.strip()
	output = output.replace("BOOL", the_type + " __attribute__((overloadable))", 1)
	output = output.replace("<T>", the_type + " __attribute__((overloadable))", 1)
	output = output.replace("<T>", the_type)
	output = output.strip() + "\n"
	return output
	
def function_to_header(function_template, the_type):
	output = template_to_function(function_template, the_type).splitlines()[0]
	output = output.replace(" {", ";")
	return output

#print "---- HEADERS ----"
for function_template in function_templates:
	for the_type in the_types:
		print function_to_header(function_template, the_type)
	print ""
		
#print "---- IMPLEMENTATION ----"
for function_template in function_templates:
	for the_type in the_types:
		print template_to_function(function_template, the_type)
	print ""		


