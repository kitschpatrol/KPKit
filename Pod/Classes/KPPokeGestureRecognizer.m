//
//  KPPokeGestureRecognizer.m
//  Pods
//
//  Created by Eric Mika on 7/30/14.
//  After
//  https://github.com/vellum/DuellingTableViews/blob/8a9db1d51c2d96fabd8c836e3219650fc07e4b87/DuellingTableViews/DuellingTableViews/VLMTouchBeganRecognizer.m
//

#import "KPPokeGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation KPPokeGestureRecognizer

- (void)reset {
  [super reset];
  self.touchPoint = CGPointZero;
  [self setState:UIGestureRecognizerStatePossible];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if ([touches count] > 1) return;
  self.touchPoint = [[touches anyObject] locationInView:self.view];
  [super touchesBegan:touches withEvent:event];
  [self setState:UIGestureRecognizerStateBegan];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
  //[self setState:UIGestureRecognizerStateFailed];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self setState:UIGestureRecognizerStateRecognized];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  [self setState:UIGestureRecognizerStateFailed];
}

@end
