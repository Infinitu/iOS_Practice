//
//  NXFileExplorer.m
//  week1
//
//  Created by 김창규 on 2015. 3. 4..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "NXFileExplorer.h"

@implementation NXFileExplorer
+(void)displayAllFilesAtPath_recursive:(NSString*)path{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray* arr = [manager contentsOfDirectoryAtPath:path error:nil];
    if(arr == nil)
        return;
    
    for(NSString* str in arr){
        NSString* newPath = [NSString stringWithFormat:@"%@/%@",path,str];
        NSLog(@"%@",newPath);
        [self displayAllFilesAtPath_recursive:newPath];
    }
}

+(void)displayAllFilesAtPath:(NSString*)path {
    NSFileManager* manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator* enumerator = [manager enumeratorAtPath:path];
    
    if(enumerator == nil) return;
    
    for(NSString* str in enumerator)
        NSLog(@"%@",str);
}
@end
