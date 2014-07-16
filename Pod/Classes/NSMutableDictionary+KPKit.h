#import <Foundation/Foundation.h>

@interface NSMutableDictionary (KPKit)

- (BOOL)kp_setKey:(id<NSCopying>)aKey toNonNilObject:(id)anObject;

@end
