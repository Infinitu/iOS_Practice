//
//  NXPerson.h
//  week1
//
//  Created by 김창규 on 2015. 3. 4..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPerson : NSObject
{
    int _age; //Objective-C Convention 맴버 변수에는 _로 시작하고 소문자로 씀.
    NSString* _name;
    
}

-(void)setAge:(int)age;             //Objective-C Convention  setter는 set을 붙임.
-(int)age;                          //Objective-C Convention  getter는 get을 붙이지 않고 맴버변수 접근 하는 것 처럼 사용.
-(void)setName:(NSString*)name;
-(NSString*)name;
-(NXPerson*)initWithName:(NSString*)name age : (int)age;
-(void)display;
@end
