//
//  Card.m
//  week4
//
//  Created by 김창규 on 2015. 3. 25..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "Card.h"
#define CARD_WIDTH 130
#define CARD_HEIGHT 150

@implementation Card

-(Card*)initWithPath:(NSString*)path{
    self = [super init];
    if(self == nil)
        return nil;

        filenamePattern = [[NSRegularExpression alloc]
                           initWithPattern:@"([scdh]?)([^/\\.]+)\\.(?:png|jpg|jpeg|gif)$"
                           options:0 error:NULL];
    
    self.path = path;
    
    NSTextCheckingResult *match = [filenamePattern firstMatchInString:path options:0 range:NSMakeRange(0, [path length])];
    self.shape = [path substringWithRange:[match rangeAtIndex:1]];
    self.name = [path substringWithRange:[match rangeAtIndex:2]];
    
    CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((CFDataRef)[NSData dataWithContentsOfFile:path]);
    CGImageRef image = CGImageCreateWithPNGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault); // Or JPEGDataProvider

    self.imageRef = [Card resizeCGImage:image toWidth:CARD_WIDTH andHeight:CARD_HEIGHT];
    
    CGImageRelease(image);
    CGDataProviderRelease(imgDataProvider);
    
    _image = [[UIImage alloc]initWithCGImage:self.imageRef];
    
    return self;
}

-(void) dealloc{
    [self.shape release];
    [self.name release];
    CGImageRelease(self.imageRef);
    [self.image release];
    [self.path release];
    [self.image release];
    [super dealloc];
}

+ (CGImageRef)resizeCGImage:(CGImageRef)image toWidth:(int)width andHeight:(int)height {
    // create context, keeping original image properties
    CGColorSpaceRef colorspace = CGImageGetColorSpace(image);
    CGContextRef context = CGBitmapContextCreate(NULL, width, height,
                                                 CGImageGetBitsPerComponent(image),
                                                 CGImageGetBytesPerRow(image),
                                                 colorspace,
                                                 CGImageGetBitmapInfo(image));
    CGColorSpaceRelease(colorspace);
    
    
    if(context == NULL)
        return nil;
    
    
    // draw image to context (resizing it)
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    // extract resulting image from context
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    
    return imgRef;
}

@end
