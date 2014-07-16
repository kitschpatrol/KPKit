//
//  KPTextOnPathTestView.m
//  KPKit
//
//  Created by Eric Mika on 7/16/14.
//  Copyright (c) 2014 kitschpatrol. All rights reserved.
//

#import "KPTextOnPathTestView.h"
#import "KPKit.h"
#import "UIBezierPath+KPKit.h"

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
  CGContextSaveGState(context);

  [KPKit drawText:attributedString onPath:path];
  [KPKit drawText:attributedString onPath:path inContext:context withAlignment:NSTextAlignmentCenter clockwiseBaseline:NO];
  CGContextRestoreGState(context);

  //  UIBezierPath *donut = [KPTextOnPathTestView kp_bezierPathWithDonut:self.center innerRadius:50.0 outerRadius:100.0 startAngle:0 endAngle:0 clockwise:NO];

  UIBezierPath *donut = [UIBezierPath kp_bezierPathWithDonut:self.center innerRadius:50.0 outerRadius:100.0];
  [[UIColor lightGrayColor] setStroke];
  [[UIColor brownColor] setFill];
  [[UIColor blackColor] setStroke];

  [donut fill];
  [donut stroke];

  NSMutableAttributedString *attributedString2 =
      [[NSMutableAttributedString alloc] initWithString:@"abcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghijklmabcdefghijklmabcdefghijkl"
                                                        @"mabcdefghijklmabcdefghijklmabcdefghijklmabcdefg"
                                             attributes:@{}];
  [KPKit drawText:attributedString2 onPath:donut];

  // Draw an arc...
}

void drawCircleAtPoint(CGPoint point, UIColor *color) {
  CGFloat r, g, b, a;
  [color getRed:&r green:&g blue:&b alpha:&a];

  CGContextSetFillColor(UIGraphicsGetCurrentContext(), (float[]) {r, g, b, a});
  CGContextFillEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake(point.x - 2, point.y - 2, 4, 4));
}

@end
