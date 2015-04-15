//
//  CKItemModel.m
//  midterm
//
//  Created by 김창규 on 2015. 4. 15..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "CKItemModel.h"

@implementation CKItemModel


//{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"}
-(CKItemModel *)initWithDictionary:(NSDictionary *)dictionary withIdx:(NSInteger)idx{
    self = [super init];
    if(self == nil)
        return nil;
    
    _imageTitle = [dictionary objectForKey:@"title"];
    _imageFileName = [dictionary objectForKey:@"image"];
    _date = [dictionary objectForKey:@"date"];
    return self;
}

@end
