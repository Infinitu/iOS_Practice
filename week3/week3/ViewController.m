//
//  ViewController.m
//  week3
//
//  Created by 김창규 on 2015. 3. 18..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ViewController.h"
#import "JsonParser.h"
#import "JsonStructure.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

static JsonStructure *movieData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    movieData = [[JsonStructure alloc] initWithString:@"[{\"title\":\"\\uc0c8\\uae001\",\"image\":\"01.jpg\",\"content\":\"\\uc601\\ud654\\ubcf4\\ub7ec\\uac00\\uc790\",\"comments\":[{\"id\":1,\"user\":\"jobs\",\"comment\":\"apple\"},{\"id\":4,\"user\":\"cook\",\"comment\":\"apple\"}]},{\"title\":\"\\ud1a0\\uc774\\uc2a4\\ud1a0\\ub9ac?\",\"image\":\"02.jpg\",\"content\":\"Pixar\",\"comments\":[]},{\"title\":\"ToyStory\",\"image\":\"03.jpg\",\"content\":\"\\uc6b0\\ub514\\uac00\\ucd5c\\uace0\",\"comments\":[{\"id\":2,\"user\":\"bill\",\"comment\":\"Microsoft\"}]},{\"title\":\"\\uadf9\\uc7a5\\uc740\",\"image\":\"04.jpg\",\"content\":\"\\uc5b4\\ub514\\ub85c\",\"comments\":[{\"id\":4,\"user\":\"cook\",\"comment\":\"apple\"}]}]"];
    
    NSLog(@"%@",movieData);
    
}

- (IBAction)randomSelect:(id)sender {
    NSArray *arr = movieData.object;
    NSDictionary *selected;
    selected = [arr objectAtIndex: arc4random_uniform((int)arr.count)];
    
    NSString *title, *image;
    title = [selected objectForKey:@"title"];
    image = [selected objectForKey:@"image"];
    
    self.posterImageView.image = [UIImage imageNamed:image];
    self.titleLabel.text = title;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
