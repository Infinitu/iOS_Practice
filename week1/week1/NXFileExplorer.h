//
//  NXFileExplorer.h
//  week1
//
//  Created by 김창규 on 2015. 3. 4..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXFileExplorer : NSObject

+(void)displayAllFilesAtPath_recursive:(NSString*)path;
+(void)displayAllFilesAtPath:(NSString*)path;

@end
