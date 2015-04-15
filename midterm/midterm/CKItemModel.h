//
//  CKItemModel.h
//  midterm
//
//  Created by 김창규 on 2015. 4. 15..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKItemModel : UITableViewController
//{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"}

@property(readonly) NSString *imageTitle;
@property(readonly) NSString *imageFileName;
@property(readonly) NSString *date;
-(CKItemModel*)initWithDictionary:(NSDictionary*)dictionary withIdx:(NSInteger)idx;

@end
