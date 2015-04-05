//
//  SolitaireGame.m
//  week5
//
//  Created by 김창규 on 2015. 4. 1..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "SolitaireGame.h"

NSNotificationCenter *_notiCenter;

@implementation SolitaireGame

-(instancetype)init{
    self = [super init];
    if(self == nil)
        return nil;
    
    _deck = [[CardDeck alloc] init];
    _gameboard = @[
                   [[NSMutableArray alloc]init],
                   [[NSMutableArray alloc]init],
                   [[NSMutableArray alloc]init],
                   [[NSMutableArray alloc]init],
                   [[NSMutableArray alloc]init],
                   [[NSMutableArray alloc]init],
                   [[NSMutableArray alloc]init]
                   ];
    _notiCenter = [[NSNotificationCenter defaultCenter] retain];
    [_notiCenter retain];
    [_gameboard retain];
    return self;
}

-(void)reset{
    for (NSMutableArray *arr in self.gameboard)
        [arr removeAllObjects];
    [self.deck shuffle];
    
    int i,j;
    for (i=0; i<7; i++) {
        for(j=0;j<=i;j++){
            NSMutableArray *arr = [self.gameboard objectAtIndex:i];
            [arr addObject:[self.deck nextCard]];
        }
    }
    [self notiCardChanged];
}

-(void)notiCardChanged{
    [_notiCenter postNotificationName:@"boardChanged" object:self];
}

-(void)dealloc{
    [_notiCenter release];
    [_deck release];
    for (NSArray *arr in _gameboard)
         [arr release];
    [_gameboard release];
    [super dealloc];
}

@end
