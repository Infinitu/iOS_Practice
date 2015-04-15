//
//  CKUITableViewController.m
//  midterm
//
//  Created by 김창규 on 2015. 4. 15..
//  Copyright (c) 2015년 김창규. All rights reserved.
//

#import "CKUITableViewController.h"
#import "CKJsonParser.h"
#import "CKItemModel.h"
#import "CKDetailViewController.h"
#define itemID @"default1"

@implementation CKUITableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    NSString *sampleDataJsonStr = @"[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},"\
                                    "{\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},"\
                                    "{\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},"\
                                    "{\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},"\
                                    "{\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},"\
                                    "{\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},"\
                                    "{\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},"\
                                    "{\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},"\
                                    "{\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
    self.models = [NSMutableArray array];
    NSArray *sampleData = [CKJsonParser parseJson:sampleDataJsonStr];
    int idx=0;
    for(NSDictionary *dic in sampleData){
        [self.models addObject:[[CKItemModel alloc] initWithDictionary:dic withIdx:idx++]];
    }
    
    [self.tableView reloadData];
}


//UITableViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section!=0)
        return 0;
    return self.models.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itemID];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemID];
    
    CKItemModel *model = [self.models objectAtIndex:indexPath.row];
    UIImageView *imageView =(UIImageView*)[cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:model.imageFileName];
    UILabel *label = (UILabel*)[cell viewWithTag:101];
    label.text = model.date;
    label = (UILabel*)[cell viewWithTag:102];
    label.text = model.imageTitle;

    
    return cell;
}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CKDetailViewController *dview = [CKDetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle];
//    [self.navigationController pushViewController:dview animated:YES];
//    dview.cur
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [self.models objectAtIndex: indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
@end
