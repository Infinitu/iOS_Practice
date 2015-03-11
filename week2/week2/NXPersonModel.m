//
//  NXPersonModel.m
//  week2
//
//  Created by 김창규 on 2015. 3. 11..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "NXPersonModel.h"

static NSString *kNAME =  @"name";
static NSString *kNUMBER =  @"number";
static NSString *kTEAM =  @"team";

@implementation NXPersonModel

-(NXPersonModel*) initWithFile:(NSString *)name{
    self = [super init];
    if(self == nil)
        return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    NSString *wholeContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    _people = [self makePersonArrayWithString:wholeContents];
    return self;
}

-(NSArray*) makePersonArrayWithString:(NSString*)wholeString{
    NSArray *rows = [wholeString componentsSeparatedByString:@"\n"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:rows.count];
    for (NSString *row in rows) {
        NSArray *cols = [row componentsSeparatedByString:@","];
        [arr addObject: [self makePersonWithArray:cols]];
    }
    return arr;
}

-(NSDictionary*) makePersonWithArray:(NSArray*)arr{
    return [NSDictionary dictionaryWithObjects:arr forKeys:@[kNAME,kNUMBER,kTEAM]];
}

-(NSString*)personNameAtIndex:(int)index{
    return [[_people objectAtIndex:index] objectForKey: kNAME];
}
-(NSNumber*)personNumberAtIndex:(int)index{
    return [[_people objectAtIndex:index] objectForKey: kNUMBER];
}
-(NSNumber*)personTeamAtIndex:(int)index{
    return [[_people objectAtIndex:index] objectForKey: kTEAM];
}
-(NSDictionary*)getPersonObjectAtIndex:(int)index{
    return [_people objectAtIndex:index];
}

- (NSString*) findPersonNameByNumber:(NSNumber*)number{
    for (NSDictionary *person in _people) {
        if([[person objectForKey:kNUMBER] isEqualToNumber: number])
            return [person objectForKey:kNAME];
    }
    return nil;
}
- (NSNumber*) findPersonNumberByName:(NSString*)name{
    for (NSDictionary *person in _people) {
        if([[person objectForKey:kNAME] isEqualToString: name])
            return [person objectForKey:kNUMBER];
    }
    return nil;
}

- (NSArray*) sortedByName{
    return [self sortedByKey:kNAME];
}
- (NSArray*) sortedByNumber{
    return [self sortedByKey:kNUMBER];
}
- (NSArray*) sortedByTeam{
    return [self sortedByKey:kTEAM];
}

- (NSArray*) sortedByKey:(NSString*)key{
    return [_people sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [[(NSDictionary*)obj1 objectForKey: key]
                compare: [(NSDictionary*)obj2 objectForKey: key]];
    }];
}

-(NSString *)description{
    return _people.description;
}

@end
