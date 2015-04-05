//
//  CardDeck.m
//  week4
//
//  Created by 김창규 on 2015. 3. 25..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "CardDeck.h"

NSArray *_fulldeck;
NSNotificationCenter *_notiCenter;
static NSString *directory ; //main bundle.
@implementation CardDeck

-(CardDeck*)init{
    if(directory == nil)
        directory = [[NSString alloc] initWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath], @"card_decks"];
    
    NSFileManager* manager = [[NSFileManager defaultManager] retain];
    NSArray* arr = [manager contentsOfDirectoryAtPath:directory error:nil];
    NSMutableArray* fulldeck = [[NSMutableArray alloc] init];
    
    for(NSString* str in arr){
        NSString* newPath = [[NSString alloc] initWithFormat:@"%@/%@",directory,str];
        [fulldeck addObject:[self makeCard:newPath]];
        NSLog(@"%@ has been read",newPath);
    }
    
    _queue = [[NSMutableArray alloc] init];
    _fulldeck = fulldeck;
    _notiCenter = [[NSNotificationCenter defaultCenter] retain];
    [self shuffle];
    [manager release];
    [arr release];
    return self;
}

-(void)shuffle{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:_fulldeck];
    [self.queue removeAllObjects];
    while(temp.count > 0){
        int next = arc4random()%temp.count;
        [self.queue addObject:[temp objectAtIndex:next]];
        [temp removeObjectAtIndex:next];
    }
    [temp release];

}

-(void)pickTop{
    Card *next = [self nextCard];
    if(next == nil){
        //no card anymore
        [_notiCenter postNotificationName:@"pickError" object:self];
    }
    else{
        //yes card yet
        [_notiCenter postNotificationName:@"pickCard" object:self userInfo:@{@"card":next}];
    }
}

-(Card*) nextCard{
    if(self.queue.count ==0)
        return nil;
    Card *next = [self.queue objectAtIndex:0];
    [self.queue removeObjectAtIndex:0];
    return next;
}

-(Card*) makeCard:(NSString*)path {
    return [[Card alloc] initWithPath: path];
}

-(void) dealloc{
    for(Card* card in _fulldeck)
        [card release];
    [_queue release];
    [_fulldeck release];
    [_notiCenter release];
    [super dealloc];
}


@end
