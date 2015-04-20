//
//  NSString+KPKit.h
//  Pods
//
//  Created by Eric Mika on 1/14/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (KPKit)

- (NSString *)kp_stringWithCapitalizedFirstLetter;
- (NSArray *)kp_componentsSeparatedByString:(NSString *)separator limit:(NSUInteger)limit;


+ (NSString *)kp_stringWithBinaryInteger:(NSInteger)number;

@end
