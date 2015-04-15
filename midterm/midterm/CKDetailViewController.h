//
//  CKDetailViewController.h
//  midterm
//
//  Created by 김창규 on 2015. 4. 15..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKItemModel.h"

@interface CKDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(readonly) CKItemModel *detailItem;
-(void)setDetailItem:(id)newDetailItem;
@end
