//
//  ViewController.m
//  w4_sample
//
//  Created by 김창규 on 2015. 3. 23..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *idNumberInput;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation ViewController
- (IBAction)submit:(id)sender {
    self.status.text = @"invalidated";
    self.status.textColor = [UIColor redColor];
}
- (IBAction)edited:(id)sender {
    self.status.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
