//
//  FirstViewController.m
//  w3_sample
//
//  Created by 김창규 on 2015. 3. 16..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleLabel.text = @"View Loaded Called";
}
- (IBAction)clicked:(id)sender {
    self.titleLabel.text = @"Button Clicked";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
