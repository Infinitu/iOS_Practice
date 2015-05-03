//
//  ViewController.m
//  week9
//
//  Created by 김창규 on 2015. 4. 27..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "ViewController.h"
#import "BarGraphView.h"
#import "CKJsonParser.h"
#import "PieGraphView.h"

@interface ViewController ()
@property IBOutlet PieGraphView *pie;
@property (strong, nonatomic) IBOutlet BarGraphView *view1;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property long vheight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* data = @"[{\"title\":\"April\", \"value\":5},{\"title\":\"May\", \"value\":12},{\"title\":\"June\", \"value\":18},{\"title\":\"July\", \"value\":11},{\"title\":\"August\", \"value\":15},{\"title\":\"September\", \"value\":9},{\"title\":\"October\", \"value\":17},{\"title\":\"November\", \"value\":25},{\"title\":\"December\", \"value\":31}]";
    NSArray *parsedData = [CKJsonParser parseJson:data];
    CGRect bound = [[UIScreen mainScreen] bounds];
    
    [self.view1 setFrame:[[UIScreen mainScreen] bounds]];
    [self.scroll setContentOffset:CGPointMake(0, 0)];
    [self.scroll setContentInset:UIEdgeInsetsZero];
    _vheight = [self.view1 setData:parsedData];
    [self.pie setData:parsedData];
    [self.pie setFrame:CGRectMake(0, _vheight, bound.size.width, bound.size.width)];
    [self.scroll setContentSize:CGSizeMake(bound.size.width,bound.size.width + _vheight)];
    [self.view1 setNeedsDisplay];
    [self.pie setNeedsDisplay];
    
//    NSLog(@"%f %f %f %f",self.view1.frame.origin.x,self.view1.frame.origin.y, self.view1.frame.size.width,self.view1.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.view1 setFrame:CGRectMake(0, 0, size.width, _vheight)];
    [self.pie setFrame:CGRectMake(0, _vheight,size.width, size.width)];
    [self.scroll setContentSize:CGSizeMake(size.width,size.width + _vheight)];
    [self.view1 setNeedsDisplay];
    [self.pie setNeedsDisplay];
    
    NSLog(@"%f %f %f %f",self.pie.frame.origin.x,self.pie.frame.origin.y,self.pie.frame.size.width,self.pie.frame.size.height);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view1 setNeedsDisplay];
}

@end
