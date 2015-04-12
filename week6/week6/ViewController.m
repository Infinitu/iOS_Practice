//
//  ViewController.m
//  week6
//
//  Created by 김창규 on 2015. 4. 8..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
NSArray *arr;
NSMutableArray *viewArr;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int maxWidth = [[UIScreen mainScreen] applicationFrame].size.width;
    arr = [ImageBundle imageBundleInPath:
           [[NSString alloc] initWithFormat:@"%@/%@",
            [[NSBundle mainBundle] bundlePath], @"DemoImages"]
           withFixedWidth:maxWidth];
    viewArr = [NSMutableArray array];
    int max = 0;
    for(ImageInfo *info in arr){
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, info.top, maxWidth, info.height)];
        max += info.height;
        [self.scrollView addSubview: view];
        [viewArr addObject:view];
    }
    self.scrollView.contentSize = CGSizeMake(maxWidth, max);
    [self scrollViewDidScroll:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    @autoreleasepool {
        
    //NSLog(@"scroll %f",scrollView.contentOffset.y);
    int height = scrollView.window.frame.size.height;
    height = height<100?[[UIScreen mainScreen] applicationFrame].size.height:height;
    int x_st = scrollView.contentOffset.y;
    int x_en = x_st + height;
    
    int target_st=-1, target_en=-1;
    int i;
    for(i=0;i<arr.count;i++){
        ImageInfo *info = [arr objectAtIndex:i];
        if(info.top <= x_st)
            target_st=i;
        if(target_en<0&&(info.top+info.height)>=x_en)
            target_en = i;
    }
    
    target_st = target_st<=0?0:target_st-1;
    target_en = target_en>=arr.count-1?target_en:target_en+1;
    if(target_en<0)
        target_en = (int)arr.count - 1;
        
    NSLog(@"visible %d to %d",target_st,target_en);
    for(i=0;i<arr.count;i++){
        UIImageView *view = [viewArr objectAtIndex:i];
        ImageInfo *info = [arr objectAtIndex:i];
        if(target_st<=i && i<=target_en){
            view.image = info.image;
        }
        else{
            view.image = nil;
            if(info.isCached)
                [info cacheRelease];
        }
    }
    
    
    }
}

@end
