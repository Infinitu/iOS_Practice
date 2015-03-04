//
//  main.m
//  week1
//
//  Created by 김창규 on 2015. 3. 4..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPerson.h"
#import "NXFileExplorer.h"

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        
//        NXPerson* aPerson = [[NXPerson alloc] initWithName:@"CK.Kim" age: 22];
//        
//        [aPerson setAge:22];
//        
//        
////        NSLog(@"Name = %@ Age=%d",[aPerson name],[aPerson age]);
////        [aPerson display];
//        NSLog(@"%@",aPerson);
//    }
//    return 0;
//}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        [NXFileExplorer displayAllFilesAtPath:@"/Users/infinitu/Documents"];
    }
    return 0;
}