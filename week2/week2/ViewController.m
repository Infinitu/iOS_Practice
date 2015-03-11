//
//  ViewController.m
//  week2
//
//  Created by 김창규 on 2015. 3. 11..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ViewController.h"
#import "NXPersonModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NXPersonModel *model = [[NXPersonModel alloc] initWithFile:@"persons"];
    NSLog(@"%@",[model sortedByTeam]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
