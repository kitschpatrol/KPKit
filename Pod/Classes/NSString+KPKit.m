//
//  NSString+KPKit.m
//  Pods
//
//  Created by Eric Mika on 1/14/15.
//
//

#import "NSString+KPKit.h"

@implementation NSString (KPKit)

- (NSString *)kp_stringWithCapitalizedFirstLetter
{
  NSString *retVal = self;
  if (!self || self.length == 0) {
    // do nothing
  }
  else if (self.length == 1) {
    retVal = self.capitalizedString;
  }
  else {
    retVal = [NSString stringWithFormat:@"%@%@", [[self substringToIndex:1] uppercaseString], [self substringFromIndex:1]];
  }
  return retVal;
}

- (NSArray *)kp_componentsSeparatedByString:(NSString *)separator limit:(NSUInteger)limit
{
  NSParameterAssert(separator);

  // https://gist.github.com/Shilo/6397570

  if (limit == 0) {
    return [self componentsSeparatedByString:separator];
  }
  else {
    NSArray *allComponents = [self componentsSeparatedByString:separator];
    NSMutableArray *components = [NSMutableArray arrayWithCapacity:MIN(limit, allComponents.count)];

    NSUInteger i = 0;
    for (NSString *component in allComponents) {
      if (i >= limit - 1) {
        [components addObject:[[allComponents subarrayWithRange:NSMakeRange(i, allComponents.count - i)] componentsJoinedByString:separator]];
        break;
      }
      [components addObject:component];
      i++;
    }


    
    return components;
  }
}

// Original author Adam Rosenfield... SO Question 655792
+ (NSString *)kp_stringWithBinaryInteger:(NSInteger)number {
NSMutableString *str = [NSMutableString string];
  for(NSInteger numberCopy = number; numberCopy > 0; numberCopy >>= 1) {
  // Prepend "0" or "1", depending on the bit
    

    
  [str insertString:((numberCopy & 1) ? @"1" : @"0") atIndex:0];
}
  
  // Zero pad
  while (str.length < sizeof(NSInteger)) {
    [str insertString:@"0" atIndex:0];
  }
  
  
  
  return str;
}
@end
