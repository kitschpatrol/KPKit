#import "NSMutableDictionary+KPKit.h"

@implementation NSMutableDictionary (KPKit)

- (BOOL)kp_setKey:(id<NSCopying>)aKey toNonNilObject:(id)anObject {
  if (anObject != nil) {
    [self setObject:anObject forKey:aKey];
    return YES;
  }
  return NO;
}

@end
