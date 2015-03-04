//
//  NXPerson.m
//  week1
//
//  Created by 김창규 on 2015. 3. 4..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "NXPerson.h"

@implementation NXPerson

-(NXPerson*)initWithName:(NSString*)name
                    age : (int)age{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    [self setAge:age];
    [self setName:name];
    return self;
}

-(void)setAge:(int)age {
    _age = age;
}

-(int)age {
    return _age;
}

-(void)setName:(NSString*)name{
    _name = [[NSString alloc] initWithString:name];
}

-(NSString*)name{
    return _name;
}

-(void)display{
    NSLog(@"Name = %@ Age=%d",_name,_age);
}

-(NSString*)description{
    return [NSString stringWithFormat:@"Name = %@ Age=%d",_name,_age];
}

@end
