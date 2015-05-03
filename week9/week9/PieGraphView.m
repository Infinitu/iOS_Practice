//
//  PieGraphView.m
//  week9
//
//  Created by 김창규 on 2015. 4. 29..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "PieGraphView.h"

@interface PieGraphView ()
@property NSArray *list;
@property int sum;
@end

@implementation PieGraphView

int value_(NSDictionary *dict){
    return [((NSNumber*)[dict objectForKey:@"value"]) intValue];
}
NSString* title_(NSDictionary *dict){
    return (NSString*)[dict objectForKey:@"title"];
}


-(void)setData:(NSArray*)arr{
    self.list = arr;
    int sum=0;
    for(NSDictionary* dic in arr)
        sum+=value_(dic);
    _sum=sum;
    
//    [self setFrame:CGRectMake(0, 435, 375, 375)];
}

-(void)drawRect:(CGRect)rect{
    NSLog(@"internal %f %f %f %f",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    
    int i;
    UIFont *font = [UIFont systemFontOfSize:32];
    
//    for(i=0;i<self.list.count;i++)
//    {
//        NSDictionary *dic = [self.list objectAtIndex:i];
//        NSString* titleStr = title(dic);
//        UIFont *nfont = font;
//        CGSize size = [titleStr sizeWithAttributes:@{NSFontAttributeName:nfont}];
//        if(size.width>110){
//            nfont = sfont;
//            size = [titleStr sizeWithAttributes:@{NSFontAttributeName:nfont}];
//        }
//        
//        [titleStr drawAtPoint:CGPointMake(120-size.width,10+i*rowsize + (rowsize-size.height)/2) withAttributes:@{NSFontAttributeName:nfont}];
//    }
    
    [self drawpie];
    
}

-(void)drawpie{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef list[] = {[[UIColor redColor] CGColor],[[UIColor blueColor] CGColor],[[UIColor brownColor] CGColor],[[UIColor cyanColor] CGColor],[[UIColor magentaColor] CGColor],[[UIColor purpleColor] CGColor]};
    
    CGPoint cent = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    CGFloat r = (self.frame.size.height>self.frame.size.width)?self.frame.size.height:self.frame.size.width;
    r = r/2 - 20;
    
    int i;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    int cnt = 0;
    CGFloat st = 0;
    CGFloat en = 0;
    for(i=0;i<self.list.count;i++)
    {
        int val = value_([self.list objectAtIndex:i]);
        st = en;
        en = st + M_PI*2/_sum*val;

        [path addArcWithCenter:cent
                        radius:r
                    startAngle:st
                      endAngle:en
                     clockwise:true];
        
        [path addLineToPoint:cent];
        CGContextSetFillColorWithColor(context,list[i%6]);
        [path fill];
        [path removeAllPoints];
        [self drawTitle:title_([self.list objectAtIndex:i]) st:st en:en r:r/3*2 center:cent];
    }
}

-(void) drawTitle:(NSString*) str st:(CGFloat) st en:(CGFloat) en r:(CGFloat) r center:(CGPoint) center{
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGFloat x = center.x + cos((st+en)/2)*r;
    CGFloat y = center.y + sin((st+en)/2)*r;
    CGSize size = [str sizeWithAttributes:attr];
    [str drawAtPoint:CGPointMake(x-size.width/2, y-size.height/2) withAttributes:attr];
    
    
}



@end

