#import "UIResponder+KPFirstResponder.h"

static __weak id currentFirstResponder;

@implementation UIResponder (KPFirstResponder)

+ (id)kp_currentFirstResponder
{
  currentFirstResponder = nil;
  [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
  return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender
{
  currentFirstResponder = self;
}

@end