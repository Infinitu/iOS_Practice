//
//  BarGraphView.m
//  week9
//
//  Created by 김창규 on 2015. 4. 29..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "BarGraphView.h"

@interface BarGraphView ()
@property NSArray *list;
@property int max_level;

@end

@implementation BarGraphView

const int rowsize = 45;

NSString* title(NSDictionary *dict){
    return (NSString*)[dict objectForKey:@"title"];
}

int value(NSDictionary *dict){
    return [((NSNumber*)[dict objectForKey:@"value"]) intValue];
}

-(long)setData:(NSArray*)arr{
    self.list = arr;
    _max_level = 0;
    for(NSDictionary *dic in arr)
    {
        int val = value(dic);
        int maxcan = val/10+1;
        if(maxcan > self.max_level)
            self.max_level = maxcan;
    }
    [self setFrame:CGRectMake(0, 0, self.frame.size.width, arr.count*rowsize+30)];
    [self setNeedsDisplay];
    return arr.count*rowsize+30;
}

-(void)drawRect:(CGRect)rect{
    
    int i;
    UIFont *font = [UIFont systemFontOfSize:32];
    UIFont *sfont = [UIFont systemFontOfSize:24];
    
    for(i=0;i<self.list.count;i++)
    {
        NSDictionary *dic = [self.list objectAtIndex:i];
        NSString* titleStr = title(dic);
        UIFont *nfont = font;
        CGSize size = [titleStr sizeWithAttributes:@{NSFontAttributeName:nfont}];
        if(size.width>110){
            nfont = sfont;
            size = [titleStr sizeWithAttributes:@{NSFontAttributeName:nfont}];
        }
        
        [titleStr drawAtPoint:CGPointMake(120-size.width,10+i*rowsize + (rowsize-size.height)/2) withAttributes:@{NSFontAttributeName:nfont}];
    }
    
    [self drawBackground];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShadow(context, CGSizeMake(5, 5), 5);
    CGContextSetFillColorWithColor(context, [[UIColor blueColor] CGColor]);
    [self drawBars:context];
    
}

-(void)drawBackground{
    CGFloat wid = self.frame.size.width;
    CGFloat hei = self.frame.size.height;
    CGFloat ybound_top = self.bounds.origin.y;
    CGFloat ybound_bot = self.bounds.origin.y + self.bounds.size.height;
    CGFloat st = 130;
    CGFloat en = wid - 10;
    
    if(self.max_level==0)
        self.max_level = 1;
    CGFloat colWid = (en-st) / self.max_level;
    
    int i;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    UIFont *font = [UIFont systemFontOfSize:12];
    
    for(i=0;i<=self.max_level;i++){
        CGFloat x = st + i*colWid;
        CGPoint startPoint = CGPointMake(x,ybound_top+10);
        CGPoint nextPoint = CGPointMake(x,ybound_bot-20);
        [path moveToPoint:startPoint];
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        [path stroke];
        [path removeAllPoints];
        NSString* levelStr = [NSString stringWithFormat:@"%d",i*10];
        CGSize strsize = [levelStr sizeWithAttributes:@{NSFontAttributeName:font}];
        [levelStr drawAtPoint:CGPointMake(x-strsize.width/2, ybound_bot-10-strsize.height/2) withAttributes:@{NSFontAttributeName:font}];
    }
}

-(void)drawBars:(CGContextRef)context{
    CGFloat wid = self.frame.size.width;
    CGFloat hei = self.frame.size.height;
    CGFloat ybound_top = self.bounds.origin.y;
    CGFloat ybound_bot = self.bounds.origin.y + self.bounds.size.height;
    CGFloat st = 130;
    CGFloat en = wid - 10;
    
    if(self.max_level==0)
        self.max_level = 1;
    CGFloat colWid = (en-st) / self.max_level / 10;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    UIFont *font = [UIFont systemFontOfSize:12];
    
    int i;
    for(i=0;i<self.list.count;i++){
        int val = value([self.list objectAtIndex:i]);
        CGFloat y = 10+ rowsize*i;
        CGPoint startPoint = CGPointMake(st,y+5);
        CGPoint nextPoint = CGPointMake(st + colWid*val,y+5);
        CGPoint nextPoint2 = CGPointMake(st + colWid*val,y+rowsize-5);
        CGPoint endPoint = CGPointMake(st,y+rowsize-5);
        [path moveToPoint:startPoint];
        [path addLineToPoint:nextPoint];
        [path addLineToPoint:nextPoint2];
        [path addLineToPoint:endPoint];
        [path setLineWidth:1.0];
        [path fill];
        [path removeAllPoints];
    }
    
}




@end
