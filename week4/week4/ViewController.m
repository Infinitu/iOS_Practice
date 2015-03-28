//
//  ViewController.m
//  week4
//
//  Created by 김창규 on 2015. 3. 25..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ViewController.h"
#import "CardDeck.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property CardDeck *deck;
@end

@implementation ViewController

- (IBAction)nextCard:(id)sender {
    [self.deck pickTop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.deck = [[CardDeck alloc]init];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pickError:) name:@"pickError" object:self.deck];
    [center addObserver:self selector:@selector(pickCard:) name:@"pickCard" object:self.deck];
    [center addObserver:self selector:@selector(shuffleCard:) name:@"shuffle" object:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pickError:(NSNotification*)noti{
    self.statusLabel.textColor = [UIColor redColor];
    self.statusLabel.text = @"No More Card!!";
    self.cardImage.image = nil;
    
}

-(void)pickCard:(NSNotification*)noti{
    Card *card = [[noti userInfo]objectForKey:@"card"];
    self.statusLabel.textColor = [UIColor blackColor];
    self.statusLabel.text = [NSString stringWithFormat:@"shape:%@ name:%@",card.shape,card.name];
    self.cardImage.image = card.image;
}

-(void)shuffleCard:(NSNotification*)noti{
    [self.deck shuffle];
    self.statusLabel.textColor = [UIColor blueColor];
    self.statusLabel.text = @"New Deck is Ready";
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        // User was shaking the device. Post a notification named "shake."
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shuffle" object:self];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

@end
