//
//  ImageInfo.m
//  week6
//
//  Created by 김창규 on 2015. 4. 8..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "ImageInfo.h"


int fixedWidth;
@implementation ImageInfo



-(ImageInfo*) initWithImagePath:(NSString*)path withFixedWidth:(int)width{
    
    self = [super init];
    if(self == nil)
        return nil;
    
    CGSize size = [ImageInfo getImageSize:path];
    self.height = size.height/size.width*width;
    fixedWidth = width;
    self.path = [path retain];
    self.cachedUIImage = Nil;
    return self;
}

-(UIImage*) image{
    if([self isCached])
        return _cachedUIImage;
    CGImageRef ref = [self newCGImage];
    self.cachedUIImage= [[UIImage alloc] initWithCGImage:ref];
    CGImageRelease(ref);
    return self.cachedUIImage;
}

-(CGImageRef)newCGImage{
    
    CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((CFDataRef)[NSData dataWithContentsOfFile:self.path]);
    CGImageRef image = CGImageCreateWithJPEGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault); // Or JPEGDataProvider
    
    CGImageRef ref = [ImageInfo newResizedCGImage:image toWidth:fixedWidth andHeight:self.height];
    CGImageRelease(image);
    CGDataProviderRelease(imgDataProvider);
    
    return ref;
}
-(void) cacheRelease{
    if([self isCached]){
        [_cachedUIImage release];
        _cachedUIImage = Nil;
    }
}
-(BOOL) isCached{
    return _cachedUIImage != Nil;
}

+ (CGImageRef)newResizedCGImage:(CGImageRef)image toWidth:(int)width andHeight:(int)height {
    // create context, keeping original image properties
    CGColorSpaceRef colorspace = CGImageGetColorSpace(image);
    NSLog(@"ColorSpaceRet %@", colorspace);
    CGContextRef context = CGBitmapContextCreate(NULL, width, height,
                                                 CGImageGetBitsPerComponent(image),
                                                 CGImageGetBytesPerRow(image),
                                                 colorspace,
                                                 CGImageGetBitmapInfo(image));
    
    
    if(context == NULL)
        return nil;
    
    
    // draw image to context (resizing it)
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    // extract resulting image from context
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    NSLog(@"retain %@", imgRef);
    CGContextRelease(context);
    
    
    return imgRef;
}


+(CGSize)getImageSize:(NSString*)path{
    CGSize ret;
    
    NSURL *imageFileURL = [NSURL fileURLWithPath:path];
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)imageFileURL, NULL);
    if (imageSource == NULL) {
        ret.width = -1;
        ret.height = -1;
        return ret;
    }
    
    CGFloat width = 0.0f, height = 0.0f;
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
    if (imageProperties != NULL) {
        CFNumberRef widthNum  = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
        if (widthNum != NULL) {
            CFNumberGetValue(widthNum, kCFNumberCGFloatType, &width);
        }
        
        CFNumberRef heightNum = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
        if (heightNum != NULL) {
            CFNumberGetValue(heightNum, kCFNumberCGFloatType, &height);
        }
        
        CFRelease(imageProperties);
    }
    CFRelease(imageSource);
    
    
    ret.height = height;
    ret.width = width;
    
    return ret;
    
}

-(void)dealloc{
    [_path release];
    if(_cachedUIImage != Nil)
        [_cachedUIImage release];
    
    [super dealloc];
}

@end
