//
//  JsonStructure.m
//  week3
//
//  Created by 김창규 on 2015. 3. 19..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "JsonStructure.h"
#import "JsonParser.h"

@implementation JsonStructure

- (JsonStructure *)initWithString:(NSString *)str{
    self = [super init];
    if(self == nil)
        return nil;
    _object = [JsonParser parseJson: str];
    return self;
}


- (NSString *)description; {
    return [self serializeObject:self.object];
    
}

- (NSString *)serializeObject:(id)obj{

    if([obj isKindOfClass:[NSArray class]]){
        NSMutableString *str = [NSMutableString string];
        [str appendString: @"["];
        NSString *format = @"%@";
        for(id k in (NSArray*)obj){
            [str appendFormat:format,[self serializeObject:k]];
            format = @",%@";
        }
        [str appendString: @"]"];
        return str;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]){
        NSMutableString *str = [NSMutableString string];
        NSDictionary *dic = (NSDictionary*)obj;
        [str appendString: @"{"];
        NSString *format = @"%@:%@";
        for(NSString* k in dic){
            [str appendFormat:format,[self serializeObject:k],[self serializeObject:[dic objectForKey:k]]];
            format = @",%@:%@";
        }
        [str appendString: @"}"];
        return str;
    }
    
    if([obj isKindOfClass:[NSString class]]){
        return [NSString stringWithFormat:@"\"%@\"",(NSString*)obj];
    }
    
    if([obj isKindOfClass:[NSNumber class]]){
        return [obj description];
    }
    
    return nil;
}

@end
