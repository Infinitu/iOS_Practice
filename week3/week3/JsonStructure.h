//
//  JsonStructure.h
//  week3
//
//  Created by 김창규 on 2015. 3. 19..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonStructure : NSObject

@property(readonly) id object;

- (JsonStructure *)initWithString:(NSString *)str;

@end
