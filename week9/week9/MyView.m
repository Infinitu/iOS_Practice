//
//  MyView.m
//  week9
//
//  Created by 김창규 on 2015. 4. 27..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "MyView.h"
#define ARC4RANDOM_MAX      0x100000000

@implementation MyView

-(CGGradientRef) gradient{
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    NSArray *arr = @[(id)[[UIColor colorWithRed:[self random_float] green:[self random_float] blue:[self random_float] alpha:1.0] CGColor],(id)[[UIColor colorWithRed:[self random_float] green:[self random_float] blue:[self random_float] alpha:1.0] CGColor]];
    CGFloat loc[2] = {0.0,1.0};
    CGGradientRef result = CGGradientCreateWithColors(spaceRef,(__bridge CFArrayRef)arr,loc);
    
    return result;
}
-(CGFloat)random_float{
    return ((double)arc4random()/ARC4RANDOM_MAX);
}
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self gradient];
    CGPoint startPoint
    = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint
    = CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    
    int i;
    for(i=0;i<10;i++)
        [self drawRandLine];
    for(i=0;i<10;i++)
        [self drawRandArc:context];
}

-(void)drawRandLine{
    CGSize fsize = self.frame.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(arc4random()%(int)fsize.width, arc4random()%(int)fsize.height);

    [path moveToPoint:startPoint];
    CGPoint nextPoint = CGPointMake(arc4random()%(int)fsize.width, arc4random()%(int)fsize.height);
    [path addLineToPoint:nextPoint];
    [path setLineWidth:1.0];
    [path stroke];
}

-(void)drawRandArc:(CGContextRef)context{
    CGSize fsize = self.frame.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(arc4random()%(int)fsize.width, arc4random()%(int)fsize.height);
    CGFloat r = arc4random()%(int)fsize.width/2;
    CGFloat st = [self random_float]*2*M_PI;
    CGFloat en = [self random_float]*2*M_PI;
    [path addArcWithCenter:center
                    radius:r
                startAngle:st
                  endAngle:en
                 clockwise:arc4random()%2];
    [path addLineToPoint:center];
    [path setLineWidth:1.0];
    CGFloat comp[4] = {[self random_float], [self random_float],[self random_float],[self random_float]};
    CGContextSetFillColor(context,comp);
    [path fill];
}
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}
@end
