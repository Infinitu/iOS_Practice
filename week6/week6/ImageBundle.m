//
//  ImageBundle.m
//  week6
//
//  Created by 김창규 on 2015. 4. 8..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ImageBundle.h"

@implementation ImageBundle
+(NSArray*)imageBundleInPath:(NSString*)path withFixedWidth:(int)width{
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arr = [manager contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *imgBundle = [[NSMutableArray alloc] init];
    
    for(NSString* str in arr){
        NSString* newPath = [[NSString alloc] initWithFormat:@"%@/%@",path,str];
        ImageInfo *info = [[ImageInfo alloc] initWithImagePath:newPath withFixedWidth:width];
        if(imgBundle.count == 0)
            info.top = 0;
        else{
            ImageInfo *last = imgBundle.lastObject;
            info.top = last.top + last.height;
        }
        [imgBundle addObject:info];
        NSLog(@"%@ has been read",newPath);
    }
    
    return imgBundle;
}
@end
