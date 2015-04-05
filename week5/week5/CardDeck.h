//
//  CardDeck.h
//  week4
//
//  Created by 김창규 on 2015. 3. 25..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardDeck : NSObject

@property(readonly) Card* nextcard;
@property(readonly) NSMutableArray *queue;

-(void)shuffle;
-(void)pickTop;
-(Card*) nextCard;

@end
