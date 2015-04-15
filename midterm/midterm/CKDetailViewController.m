//
//  CKDetailViewController.m
//  midterm
//
//  Created by 김창규 on 2015. 4. 15..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "CKDetailViewController.h"

@implementation CKDetailViewController

-(void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        NSLog(@"%@",newDetailItem);
        // Update the view.
        [self configureView];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void) configureView{
    if(_detailItem == nil)
        return;
    self.titleLabel.text = self.detailItem.imageTitle;
    self.imageView.image = [UIImage imageNamed:self.detailItem.imageFileName];
    self.dateLabel.text = self.detailItem.date;
}

@end
