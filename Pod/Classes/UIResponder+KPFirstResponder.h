
#import <UIKit/UIKit.h>

@interface UIResponder (KPFirstResponder)

// http: // stackoverflow.com/a/21330810
+ (id)kp_currentFirstResponder;

@end