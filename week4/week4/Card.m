//
//  Card.m
//  week4
//
//  Created by 김창규 on 2015. 3. 25..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "Card.h"

@implementation Card

-(Card*)initWithPath:(NSString*)path{
    self = [super init];
    if(self == nil)
        return nil;
    
    if(filenamePattern == nil)
        filenamePattern = [NSRegularExpression
                           regularExpressionWithPattern:@"([scdh]?)([^/\\.]+)\\.(?:png|jpg|jpeg|gif)$"
                           options:0 error:NULL];
    
    self.image = [UIImage imageWithContentsOfFile:path];
    
    NSTextCheckingResult *match = [filenamePattern firstMatchInString:path options:0 range:NSMakeRange(0, [path length])];
    
    self.shape = [path substringWithRange:[match rangeAtIndex:1]];
    self.name = [path substringWithRange:[match rangeAtIndex:2]];
    
    return self;
}

@end
