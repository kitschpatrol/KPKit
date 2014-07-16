#import "UIImageView+KPKit.h"

@implementation UIImageView (KPKit)

- (CGSize)imageScale {
  CGFloat sx = self.frame.size.width / self.image.size.width;
  CGFloat sy = self.frame.size.height / self.image.size.height;
  CGFloat s = 1.0;
  switch (self.contentMode) {
    case UIViewContentModeScaleAspectFit:
      s = fminf(sx, sy);
      return CGSizeMake(s, s);
      break;

    case UIViewContentModeScaleAspectFill:
      s = fmaxf(sx, sy);
      return CGSizeMake(s, s);
      break;

    case UIViewContentModeScaleToFill:
      return CGSizeMake(sx, sy);

    default:
      return CGSizeMake(s, s);
  }
}

@end
