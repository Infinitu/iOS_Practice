//
//  ImageBundle.h
//  week6
//
//  Created by 김창규 on 2015. 4. 8..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageInfo.h"

@interface ImageBundle : NSObject
+(NSArray*)imageBundleInPath:(NSString*)path withFixedWidth:(int)width;
@end