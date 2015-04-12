//
//  ImageInfo.h
//  week6
//
//  Created by 김창규 on 2015. 4. 8..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface ImageInfo : NSObject
@property NSString *path;
@property UIImage *cachedUIImage;
@property int height;
@property int top;
-(ImageInfo*) initWithImagePath:(NSString*)path withFixedWidth:(int)width;
-(UIImage*) image;
-(void) cacheRelease;
-(BOOL) isCached;
@end
