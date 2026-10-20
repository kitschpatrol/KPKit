<!-- title -->

# KPKit

<!-- /title -->

<!-- badges -->

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/license/mit)

<!-- /badges -->

<!-- short-description -->

**Library of utility methods bringing handy functions from openFrameworks and Processing to Cocoa.**

<!-- /short-description -->

## Overview

KPKit is a bundle of Objective-C functions, macros, and categories for iOS, packaged as a [CocoaPods](https://cocoapods.org) pod. It's roughly centered around bringing some of the handy shortcuts from the [openFrameworks](https://openframeworks.cc) and [Processing](https://processing.org) projects to Cocoa. Mostly a mess.

It includes counterparts to openFrameworks math functions like `ofMap()`, `ofClamp()`, and `ofLerp()`; Robert Penner's easing equations; `CGPoint` and `CGRect` geometry; random numbers and colors; drawing text along a `UIBezierPath`; and a handful of UIKit, Foundation, and SceneKit categories.

## Getting started

### Dependencies

KPKit needs iOS 12.0 or newer (the oldest deployment target current Xcode supports) and ARC. It uses Apple's UIKit, Core Graphics, Core Text, SceneKit, and GLKit frameworks, and has no third-party dependencies. The pod includes an adapted copy of [UIView+draggable](https://github.com/andreamazz/UIView-draggable) as `UIView+KPKitDraggable`.

Most of the code was written between October 2013 and April 2015, with small fixes until February 2016, and version 1.0.6 was tagged in August 2016. The example project was set up with Xcode 5.1 and CocoaPods 0.33.1. It now targets iOS 12, and builds with Xcode 26.3 and CocoaPods 1.14.3.

### Installation

KPKit isn't available through the CocoaPods trunk, and an unrelated pod has since taken the `KPKit` name there, so `pod "KPKit"` on its own installs the wrong library. Point your `Podfile` at this repository instead:

```ruby
pod "KPKit", :git => "https://github.com/kitschpatrol/KPKit.git"
```

Then run `pod install`.

To skip CocoaPods, add the files in [`Pod/Classes`](Pod/Classes) to your Xcode project and build them with ARC.

## Usage

`KPKit.h` imports `KPMath.h` and `KPEase.h`. Import the category headers you need separately.

```objc
#import "KPKit.h"
#import "UIBezierPath+KPKit.h"
#import "UIView+KPKitDraggable.h"

// In a UIView subclass
CGPoint center = KPRectGetMidPoint(self.bounds);
CGFloat x = KPMap(touchPoint.x, 0.0, self.bounds.size.width, -1.0, 1.0);
CGFloat y = KPEaseInOutQuad(elapsed, 0.0, 100.0, 2.0);
CGFloat distance = KPDistanceBetweenCGPoint(touchPoint, center);
CGPoint rotated = KPRotatePointAroundPoint(touchPoint, center, KPDegreesToRadians(45.0));

self.backgroundColor = [KPKit randomColor];
[self kp_enableDragging];

// In drawRect:
UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 20.0, 20.0)];
[KPKit drawText:[[NSAttributedString alloc] initWithString:@"Text on a path"] onPath:path];
CGPoint halfway = [path kp_pointAtPercent:0.5];
```

The math and easing functions are C functions overloaded for `float`, `double`, and `long double`, so they take `CGFloat` values directly. The easing functions take Penner's `(time, begin, change, duration)` arguments. The `KPMapEase...()` versions take the same arguments as `KPMap()` and apply the easing curve to the mapping.

`UIBezierPath+KPKit` samples a path once and caches the points. Call `kp_setNeedsPathPointsUpdate` after changing the path.

What's in each header:

| Header                           | Contents                                                                                                                                                                                                                                                                                                                                       |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `KPKit.h`                        | `KPKit` class methods for random numbers and colors, `colorFromHexString:`, app directories, view hierarchy searches, array statistics, and `drawText:onPath:`; `CGPoint`, `CGRect`, and `CGVector` functions like `KPPointAdd()` and `KPRectAroundPoint()`; and `KP_IS_IPAD`, `KP_COLOR_HEX`, `KP_LOG_FUNCTION`, `KP_WATCH`, and other macros |
| `KPMath.h`                       | `KPMap()`, `KPMapAndClamp()`, `KPClamp()`, `KPNormalize()`, `KPLerp()`, `KPDistance()`, angle conversion, wrapping, and interpolation, and cosine, cubic, Catmull-Rom, and Hermite interpolation                                                                                                                                               |
| `KPEase.h`                       | In, Out, and InOut versions of the Back, Bounce, Circ, Cubic, Elastic, Expo, Linear, Quad, Quart, Quint, and Sine easing equations (`KPEaseInOutQuad()` and so on), plus a `KPMapEase...()` version of each                                                                                                                                    |
| `KPPokeGestureRecognizer.h`      | `KPPokeGestureRecognizer`: a single-touch gesture recognizer that begins on touch down and stores the `touchPoint`                                                                                                                                                                                                                             |
| `UIBezierPath+KPKit.h`           | `kp_length`, `kp_pointAtPercent:`, `kp_angleAtPercent:`, `kp_pointAtLength:`, and `kp_angleAtLength:` for sampling along a path; `kp_bezierPathWithDonut:...` for ring and ring segment shapes                                                                                                                                                 |
| `UIBezierPath+KPArrow.h`         | `kp_bezierPathWithArrowFromPoint:toPoint:tailWidth:headWidth:headLength:`                                                                                                                                                                                                                                                                      |
| `UIView+KPKitDraggable.h`        | `kp_enableDragging` and `kp_setDraggable:` for dragging a view with a pan gesture                                                                                                                                                                                                                                                              |
| `UIScrollView+KPKit.h`           | `pageOffset`: the content offset measured in pages                                                                                                                                                                                                                                                                                             |
| `UIImageView+KPKit.h`            | `imageScale`: the scale the image is drawn at for the view's content mode                                                                                                                                                                                                                                                                      |
| `UIResponder+KPFirstResponder.h` | `kp_currentFirstResponder`                                                                                                                                                                                                                                                                                                                     |
| `NSString+KPKit.h`               | `kp_stringWithCapitalizedFirstLetter`, `kp_componentsSeparatedByString:limit:`, `kp_stringWithBinaryInteger:`                                                                                                                                                                                                                                  |
| `NSNumber+KPKit.h`               | `kp_numberWithCGFloat:`, `kp_CGFloatValue`                                                                                                                                                                                                                                                                                                     |
| `NSMutableDictionary+KPKit.h`    | `kp_setKey:toNonNilObject:`                                                                                                                                                                                                                                                                                                                    |
| `KPKit+SCNNode.h`                | `kp_glkPosition`: an `SCNNode`'s position as a `GLKVector3`                                                                                                                                                                                                                                                                                    |

## Examples

### Example app

To run the example project, clone the repo, and run `pod install` from the Example directory first. Then open `Example/KPKit.xcworkspace`.

The main view in the iPhone storyboard is a `KPTextOnPathTestView`, which strokes a curved path and fills a donut shape, then draws attributed text along both with `drawText:onPath:`.

## Background

### Implementation notes

The math and easing overloads were generated with [`template_generator.py`](template_generator.py), which prints declarations and implementations for `float`, `double`, and `long double` from a list of function templates. It's a Python 2 script, and it isn't part of the build. The sources have drifted a little from it: `KPMath.m` has a single `CGFloat` version of `KPWrap()`, and it defines `KPInRange()` without declaring it in `KPMath.h`.

`drawText:onPath:` lays out the string as a Core Text line, then draws each glyph at the point and angle on the path that matches the glyph's position in the line. `UIBezierPath+KPKit` finds those points by dashing the path with `CGPathCreateCopyByDashingPath()` every `kp_pointResolution` points (1 by default), and estimates `kp_length` from the number of samples.

Some of the code is adapted from other sources:

- The easing functions come via Futil and Jesús Gollonet's openFrameworks port of [Robert Penner's easing equations](https://robertpenner.com/easing/).
- The cosine, cubic, and Catmull-Rom interpolation functions and the Hermite function with tension and bias are from Paul Bourke's [Interpolation methods](https://paulbourke.net/miscellaneous/interpolation/). The four-point Hermite function without them is from [musicdsp.org](https://www.musicdsp.org/).
- `UIBezierPath+KPArrow` is based on [Rob Mayoff's arrow category](https://gist.github.com/mayoff/4146780).
- `UIView+KPKitDraggable` is adapted from Andrea Mazzini's [UIView+draggable](https://github.com/andreamazz/UIView-draggable).
- `KPPokeGestureRecognizer` is based on `VLMTouchBeganRecognizer` from [DuellingTableViews](https://github.com/vellum/DuellingTableViews).

### Other projects

- [Cinder-Kit](https://github.com/kitschpatrol/Cinder-Kit): a similar grab bag of helpers for [Cinder](https://libcinder.org).

### Known issues

- `KPKit` is a pretty major mess... its methods and functions should (maybe) be moved into discrete classes and / or categories eventually.
- The random and color helpers are still class methods on `KPKit`. They should be converted to overloadable functions like the ones in `KPMath.h`.
- `KPKit+SCNNode` uses SceneKit, which is deprecated as of iOS 26.
- The example's `Tests` target only has the placeholder specs from the CocoaPods library template, and its "these will fail" group fails on purpose.
- What about the "last" point? Path sampling in `UIBezierPath+KPKit` can miss the end of a path. Tried several things without success (dash phase, `bezierPathByReversingPath`).
- `tempDirectory` builds its URL with `URLWithString:`, so the URL it returns has no `file` scheme.
- `appVersion` returns the second underscore-separated part of `CFBundleVersion`, and throws an `NSRangeException` if there's no underscore.
- `KP_LOG_FUNCTION` and `KP_DDLOGDEBUG_FUNCTION` read the thread number from `NSThread`'s private `private.seqNum` key path.

## Maintainers

[kitschpatrol](https://github.com/kitschpatrol)

<!-- contributing -->

## Contributing

[Issues](https://github.com/kitschpatrol/KPKit/issues) are welcome and appreciated.

Please open an issue to discuss changes before submitting a pull request. Unsolicited PRs (especially AI-generated ones) are unlikely to be merged.

This repository uses [MDAT](https://github.com/kitschpatrol/mdat) for readme placeholder expansion.

<!-- /contributing -->

<!-- license -->

## License

[MIT](license.txt) © [Eric Mika](https://ericmika.com)

<!-- /license -->

`UIView+KPKitDraggable` is adapted from Andrea Mazzini's MIT-licensed [UIView+draggable](https://github.com/andreamazz/UIView-draggable) and keeps its Copyright (c) 2014 Fancy Pixel notice.

The easing functions in `KPEase` are ports of Robert Penner's easing equations, Copyright (c) 2001 Robert Penner, which are available under the [MIT and 3-Clause BSD licenses](https://robertpenner.com/easing_terms_of_use.html).
