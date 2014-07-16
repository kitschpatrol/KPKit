//
//  KPTextOnPathTestView.m
//  KPKit
//
//  Created by Eric Mika on 7/16/14.
//  Copyright (c) 2014 kitschpatrol. All rights reserved.
//

#import "KPTextOnPathTestView.h"
#import "KPKit.h"

@implementation KPTextOnPathTestView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  // Path
  UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.bounds.size.width * 0.2 startAngle:-2 endAngle:1 clockwise:YES];
  [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(150, 0)];
  [path addQuadCurveToPoint:CGPointMake(00, 100) controlPoint:CGPointMake(250, 350)];
  [path addQuadCurveToPoint:CGPointMake(300, 100) controlPoint:CGPointMake(0, 0)];
  [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(320, 0)];
  [[UIColor cyanColor] setStroke];
  [path stroke];

  // Get the core text line
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"abcdefghijklm" attributes:@{}];
  //[attributedString addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:20.0] range:NSMakeRange(5, [attributedString length] - 5)];

  // Set up context
  CGContextRef context = UIGraphicsGetCurrentContext();

  [KPKit drawText:attributedString onPath:path];
  [KPKit drawText:attributedString onPath:path inContext:context withAlignment:NSTextAlignmentCenter clockwiseBaseline:NO];
}

@end
