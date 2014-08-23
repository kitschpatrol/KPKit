#import "UIScrollView+KPKit.h"

@implementation UIScrollView (KPKit)

- (void)setPageOffset:(CGPoint)pageOffset {
  self.contentOffset = CGPointMake(pageOffset.x * self.bounds.size.width, pageOffset.y * self.bounds.size.height);
}

- (CGPoint)pageOffset {
  return CGPointMake(self.contentOffset.x / self.bounds.size.width, self.contentOffset.y / self.bounds.size.height);
}

@end
