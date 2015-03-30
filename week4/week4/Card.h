//
//  Card.h
//  week4
//
//  Created by 김창규 on 2015. 3. 25..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSRegularExpression *filenamePattern;

@interface Card : NSObject

@property NSString* shape;
@property NSString* name;
@property NSString* path;

-(Card*)initWithPath:(NSString*)path;
-(UIImage*)image;
@end
