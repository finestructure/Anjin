//
//  MyMapView.m
//  Anjin
//
//  Created by Sven A. Schmidt on 11.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "MyAnnotationView.h"

@implementation MyAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
  if (self != nil) {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(16.0, 22.0); // content size: 10x20
    self.frame = frame;
    self.backgroundColor = [UIColor clearColor];
    self.centerOffset = CGPointMake(-3, 9);
  }
  return self;
}



- (void)drawRect:(CGRect)rect {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGSize offset = CGSizeMake(2, 1);
  CGFloat blur = 2;
  CGContextSetShadowWithColor(ctx, offset, blur, [[UIColor darkGrayColor] CGColor]);
  
  [[UIColor redColor] setFill];
  
  CGPoint tip = CGPointMake(5, 20);
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(0, 0)];
  [path addLineToPoint:CGPointMake(10, 0)];
  [path addLineToPoint:CGPointMake(tip.x, tip.y)];
  [path closePath];
  [path fill];
}


- (void)setAnnotation:(id <MKAnnotation>)annotation {
  [super setAnnotation:annotation];
  [self setNeedsDisplay];
}


@end
