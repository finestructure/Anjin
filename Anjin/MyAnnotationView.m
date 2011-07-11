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
    frame.size = CGSizeMake(10.0, 20.0);
    self.frame = frame;
    self.backgroundColor = [UIColor clearColor];
    self.centerOffset = CGPointMake(0, -10.0);
  }
  return self;
}



- (void)drawRect:(CGRect)rect {
  CGPoint tip = CGPointMake(CGRectGetMidX(rect), rect.size.height);
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(0, 0)];
  [path addLineToPoint:CGPointMake(rect.size.width, 0)];
  [path addLineToPoint:CGPointMake(tip.x, tip.y)];
  [path closePath];
  [path fill];
}


- (void)setAnnotation:(id <MKAnnotation>)annotation {
  [super setAnnotation:annotation];
  [self setNeedsDisplay];
}


@end
