//
//  UIBezierPath+KPArrow.h
//  Pods
//
//  Created by Eric Mika on 7/20/14.
//
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (KPArrow)

// https://gist.github.com/mayoff/4146780
// http://stackoverflow.com/a/13559449/2437832
+ (UIBezierPath *)kp_bezierPathWithArrowFromPoint:(CGPoint)startPoint
                                          toPoint:(CGPoint)endPoint
                                        tailWidth:(CGFloat)tailWidth
                                        headWidth:(CGFloat)headWidth
                                       headLength:(CGFloat)headLength;

@end
