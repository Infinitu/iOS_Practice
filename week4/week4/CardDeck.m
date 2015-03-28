//
//  CardDeck.m
//  week4
//
//  Created by 김창규 on 2015. 3. 25..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "CardDeck.h"

NSArray *_fulldeck;
NSMutableArray *queue;
NSNotificationCenter *_notiCenter;
static NSString *directory ; //main bundle.
@implementation CardDeck

-(CardDeck*)init{
    if(directory == nil)
        directory = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath], @"card_decks"];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray* arr = [manager contentsOfDirectoryAtPath:directory error:nil];
    NSMutableArray* fulldeck = [NSMutableArray array];
    
    for(NSString* str in arr){
        NSString* newPath = [NSString stringWithFormat:@"%@/%@",directory,str];
        [fulldeck addObject:[self makeCard:newPath]];
        NSLog(@"%@ has been read",newPath);
    }
    
    queue = [NSMutableArray array];
    _fulldeck = fulldeck;
    _notiCenter = [NSNotificationCenter defaultCenter];
    [self shuffle];
    return self;
}

-(void)shuffle{
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_fulldeck];
    [queue removeAllObjects];
    while(temp.count > 0){
        int next = arc4random()%temp.count;
        [queue addObject:[temp objectAtIndex:next]];
        [temp removeObjectAtIndex:next];
    }

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
    if(queue.count ==0)
        return nil;
    Card *next = [queue objectAtIndex:0];
    [queue removeObjectAtIndex:0];
    return next;
}

-(Card*) makeCard:(NSString*)path {
    return [[Card alloc] initWithPath: path];
}



@end
