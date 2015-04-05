//
//  SolitaireGame.h
//  week5
//
//  Created by 김창규 on 2015. 4. 1..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardDeck.h"

@interface SolitaireGame : NSObject

@property(nonatomic, strong, readonly) CardDeck *deck;
@property(nonatomic, strong, readonly) NSArray *gameboard;
-(void)reset;
@end
