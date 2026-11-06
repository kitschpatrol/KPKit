# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Maintenance

- Update the GitHub Actions used for changelog generation, release creation, and repository metadata synchronization.

## [2.0.0] - 2026-10-20

### Changed

- **Breaking:** Raise the minimum supported iOS version from 7.0 to 12.0.
- **Breaking:** Rename `logAvailabeFontNames` to `logAvailableFontNames`.
- **Breaking:** Rename `KPSqareAroundPoint` to `KPSquareAroundPoint`.

### Fixed

- Fix `KP_COLOR_RGB` to expand through the defined `KP_COLOR_RGBA` macro.
- Normalize random color components to the 0–1 range using `UINT32_MAX`.
- Make `clearCacheDirectory` delete files from the cache directory instead of the temporary directory.
- Fix `KPSwapCGFloat` to exchange both values, restoring `KPWrap` behavior with reversed bounds.
- Use the correct `hypot` variant for `CGFloat` in `KPDistanceBetweenCGPoint`.

### Documentation

- Correct CocoaPods installation instructions to use this Git repository, avoiding the unrelated pod with the same name, and add manual installation guidance.
- Expand the README with API references, usage examples, framework requirements, example-app setup, known limitations, and source attribution; correct draggable-view property documentation.

### Maintenance

- Modernize the example for current Xcode and CocoaPods, update launch-screen setup, resolve library/example compilation warnings, and remove checked-in Pods.
- Add GitHub Actions for link checking, release creation, and repository metadata synchronization, and retire Travis CI.
- Add CodeMeta project metadata.

## [1.0.6] - 2016-08-16

### Added

- Add `UIBezierPath` constructors for donut rings, ring segments, and arrows.
- Add a draggable-view category with pan-gesture support and methods to enable or disable dragging.
- Add `UIScrollView.pageOffset` for reading and setting content offsets in page units.
- Add `KPPokeGestureRecognizer`, which begins on touch down and exposes the touch location.
- Add point arithmetic, normalization, magnitude, translation, rotation, and squared-distance helpers, plus the `KPPointOne` constant.
- Add rectangle construction, midpoint, longest-side, and square-fitting helpers, plus Core Image/UIKit coordinate conversions.
- Add `KPSwapCGFloat` and `KPModKeepSign` math utilities.
- Add recursive subview searches using either class membership or subclass matching.
- Add label-height fitting and font-family/name logging helpers.
- Add `colorFromHexString:` for constructing colors from hexadecimal strings.
- Add `SCNNode.kp_glkPosition` to read and write SceneKit positions as `GLKVector3` values.
- Add string helpers for capitalizing the first letter, splitting with a component limit, and formatting integers as binary.
- Add `UIResponder.kp_currentFirstResponder` to locate the application's current first responder.
- Add `appVersion` and `appBuild` helpers for bundle version information.
- Add `setOptionToValue` for setting or clearing option bits.
- Add `KP_UNUSED_PARAMETER`, `KP_WATCH`, `KP_WATCH_OBJECT`, and `KP_DDLOGDEBUG_FUNCTION` macros.

### Changed

- **Breaking:** Replace `KPWrap`'s numeric overloads with a single `CGFloat` function using modulo-based wrapping.
- Import `KPMath.h` and `KPEase.h` through `KPKit.h` so one import exposes the math and easing APIs.
- Include the current thread's number and name in `KP_LOG_FUNCTION` output.

### Fixed

- Handle zero bounds in `randomInt:` and avoid negative results on 32-bit targets and integer truncation on 64-bit targets.
- Normalize `KPAngleBetweenCGPoint` results to the range from −π to π.
- Release the Core Text line after drawing text on a path.
- Restore a valid CocoaPods source declaration pointing to the Git repository and matching version tag.

### Documentation

- Extend the example app to demonstrate donut paths and text drawn around rings.
- Refresh README installation text and maintainer contact information.

## [1.0.5] - 2014-07-16

### Added

- Add normalization, distance and squared-distance calculations, wrapping, angle interpolation, and cosine, cubic, Catmull-Rom, and Hermite interpolation functions.
- Add `randomBetweenA:andB:` for floating-point random values between two bounds.
- Add helpers for changing color alpha and brightness, including randomized brightness.
- Add `clearTempDirectory` and `clearCacheDirectory` cleanup APIs.
- Add point distance, angle, interpolation, and polar-coordinate helpers, plus vector magnitude and equality functions.
- Add cached `UIBezierPath` points, angles, and estimated length, with configurable sampling resolution and lookups by percentage or distance.
- Add attributed-text drawing along a `UIBezierPath`, with left, center, and right alignment and baseline-direction controls.
- Add `NSNumber`/`CGFloat` conversions and a nil-safe mutable-dictionary setter that reports whether an object was inserted.
- Add `UIImageView.imageScale` to calculate image scaling for aspect-fit, aspect-fill, and scale-to-fill content modes.

### Changed

- **Breaking:** Replace math and mapped-easing class methods with `KP`-prefixed C functions overloaded for `float`, `double`, and `long double`, declared in `KPMath.h` and `KPEase.h`.
- **Breaking:** Rename the unprefixed easing functions to `KPEase...` and provide `float`, `double`, and `long double` overloads.
- **Breaking:** Set the minimum iOS deployment target to 7.0.

### Documentation

- Add CocoaPods installation and example setup instructions, together with an example app demonstrating text drawn along a curved path.

### Maintenance

- Adopt the CocoaPods library-template layout and add an Xcode test target with Specta/Expecta placeholder specs and Travis CI.
- Add a Python generator for math and easing function overloads.

## [1.0.4] - 2014-01-14

### Changed

- **Breaking:** Rename the public `KPUtilities` class to `KPKit` and update its implementation import to `KPKit.h`.

### Fixed

- Correct the CocoaPods source URL to point to the renamed KPKit repository.

## [1.0.3] - 2014-01-14

### Added

- Add URL helpers for the documents, temporary, and cache directories.
- Add `firstSuperviewOfView:thatIsKindOfClass:` to find the nearest ancestor matching a class.

### Changed

- **Breaking:** Rename the CocoaPod and source files from `KPUtilities` to `KPKit`, changing the Podfile name and header import.

### Fixed

- Recognize iPhone and iPad simulator model names in the device-detection macros.

## [1.0.2] - 2013-12-02

### Added

- Add macros for detecting device families, interface idioms, widescreen and Retina displays, and multitasking support.
- Add RGB, RGBA, and hexadecimal color-construction macros.
- Add `KP_LOG_FUNCTION` for logging the current function, filename, and line number.

## [1.0.1] - 2013-10-14

### Changed

- **Breaking:** Rename the public `KPUtil` class to `KPUtilities` and correct its implementation's header import.

## [1.0.0] - 2013-10-14

### Added

- Introduce `KPUtil` math helpers for range mapping, clamping, interpolation, random integers, and degree/radian conversion.
- Provide In, Out, and InOut easing functions across eleven curve families, with corresponding range-mapping methods.
- Add array helpers for random selection, mean, and population standard deviation.
- Add random colors with configurable alpha and one-pixel images generated from solid colors.

### Maintenance

- Set up MIT-licensed CocoaPods distribution as `KPUtilities` for iOS, requiring ARC and UIKit.

[Unreleased]: https://github.com/kitschpatrol/KPKit/compare/2.0.0...HEAD
[1.0.0]: https://github.com/kitschpatrol/KPKit/releases/tag/1.0.0
[1.0.1]: https://github.com/kitschpatrol/KPKit/compare/1.0.0...1.0.1
[1.0.2]: https://github.com/kitschpatrol/KPKit/compare/1.0.1...1.0.2
[1.0.3]: https://github.com/kitschpatrol/KPKit/compare/1.0.2...1.0.3
[1.0.4]: https://github.com/kitschpatrol/KPKit/compare/1.0.3...1.0.4
[1.0.5]: https://github.com/kitschpatrol/KPKit/compare/1.0.4...1.0.5
[1.0.6]: https://github.com/kitschpatrol/KPKit/compare/1.0.5...1.0.6
[2.0.0]: https://github.com/kitschpatrol/KPKit/compare/1.0.6...2.0.0
