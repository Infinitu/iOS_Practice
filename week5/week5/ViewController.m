//
//  ViewController.m
//  week5
//
//  Created by 김창규 on 2015. 4. 1..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ViewController.h"
#define CARD_WIDTH 130
#define CARD_HEIGHT 150

NSMutableArray *_deckViews;
NSMutableArray *_gameColumn;
UIButton *btn;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    _deckViews = [[NSMutableArray alloc]init];
    _gameColumn = [[NSMutableArray alloc]init];
    int i,j;
    for(i = 0; i<24 ; i++){
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(25+(24*i), 500, CARD_WIDTH, CARD_HEIGHT)];
        [self.view addSubview: imgView];
        [_deckViews addObject:imgView];
        imgView.backgroundColor = [[UIColor blueColor]retain];
    }
    
    for(i=0;i<7;i++){
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [_gameColumn addObject: arr];
        for(j=0;j<=i;j++){
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(25+((CARD_WIDTH+10)*i), 100+(40*j), CARD_WIDTH, CARD_HEIGHT)];
            imgView.backgroundColor = [[UIColor blackColor] retain];
            [self.view addSubview: imgView];
            [arr addObject:imgView];
        }
    }
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.game = [[SolitaireGame alloc] init];
    NSNotificationCenter *center = [[NSNotificationCenter defaultCenter] retain];
    [center addObserver:self selector:@selector(boardChanged:) name:@"boardChanged" object:NULL];
    
    [self.game reset];
    [center release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonClicked:(id)sender {
    [self.game reset];
}

-(void)boardChanged:(NSNotification*)noti{
    int i,j;
    for(i = 0 ; i< self.game.gameboard.count ; i++){
        NSArray *arr = [self.game.gameboard objectAtIndex:i];
        for(j = 0 ; j<arr.count ; j++){
            Card *card = [arr objectAtIndex:j];
            UIImageView *iv = [[_gameColumn objectAtIndex:i]objectAtIndex:j];
            iv.image = card.image;
        }
    }
    for(j = 0 ; j<self.game.deck.queue.count ; j++){
        Card *card = [self.game.deck.queue objectAtIndex:j];
        UIImageView *iv = [_deckViews objectAtIndex:j];
        iv.image = card.image;
    }
}

-(void) dealloc{
    [self.game release];
    [btn release];
    int i,j;
    for(i = 0; i<24 ; i++){
        [[_deckViews objectAtIndex:i] release];
    }
    
    for(i=0;i<7;i++){
        NSArray *arr = [_gameColumn objectAtIndex:i];
        for(j=0;j<=i;j++){
            [[arr objectAtIndex:j] release];
        }
        
        [arr release];
    }

    
    [_deckViews release];
    [_gameColumn release];
    
    [super dealloc];
}

@end
