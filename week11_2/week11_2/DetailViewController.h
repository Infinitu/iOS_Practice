//
//  DetailViewController.h
//  week11_2
//
//  Created by 김창규 on 2015. 5. 11..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

