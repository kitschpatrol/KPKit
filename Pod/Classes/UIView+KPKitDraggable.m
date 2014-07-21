//
//  UIView+draggable.m
//  UIView+draggable
//
//  Created by Andrea on 13/03/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+KPKitDraggable.h"
#import <objc/runtime.h>

@implementation UIView (KPKitDraggable)

- (void)setKp_panGesture:(UIPanGestureRecognizer *)panGesture {
  objc_setAssociatedObject(self, @selector(kp_panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer *)kp_panGesture {
  return objc_getAssociatedObject(self, @selector(kp_panGesture));
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
  //[self adjustAnchorPointForGestureRecognizer:sender];

  CGPoint translation = [sender translationInView:[self superview]];
  [self setCenter:CGPointMake([self center].x + translation.x, [self center].y + translation.y)];

  [sender setTranslation:(CGPoint) { 0, 0 } inView:[self superview]];
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
    UIView *piece = self;
    CGPoint locationInView = [gestureRecognizer locationInView:piece];
    CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];

    piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
    piece.center = locationInSuperview;
  }
}

- (void)kp_setDraggable:(BOOL)draggable {
  [self.kp_panGesture setEnabled:draggable];
}

- (void)kp_enableDragging {
  self.kp_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
  [self.kp_panGesture setMaximumNumberOfTouches:1];
  [self.kp_panGesture setMinimumNumberOfTouches:1];
  [self.kp_panGesture setCancelsTouchesInView:NO];
  [self addGestureRecognizer:self.kp_panGesture];
}

@end
