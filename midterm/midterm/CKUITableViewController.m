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

NSInteger status;

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        status = 1;
        [self.tableView reloadData];
    } 
}

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
    
    self.sorted = [NSMutableArray array];

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(sortByDate:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    status = 1;
    
    [self.tableView reloadData];
}

-(IBAction)sortByDate:(id)sender{
    if(status == 2)
        return;
    status = 2;
    [self.sorted removeAllObjects];
    NSArray *newArr = [self.models sortedArrayUsingComparator:^(id a, id b) {
        NSString *first = [(CKItemModel*)a date];
        NSString *second = [(CKItemModel*)b date];
        return [first compare:second];
    }];
    int last = 0;
    for(CKItemModel *item in newArr){
        int year = [[item.date substringWithRange:NSMakeRange(0, 4)]intValue];
        NSMutableArray *subArr;
        if(year==last)
            subArr = [self.sorted lastObject];
        else{
            subArr = [NSMutableArray array];
            [self.sorted addObject:subArr];
            last = year;
        }
        
        [subArr addObject:item];
    }
    [self.tableView reloadData];
}



//UITableViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(status == 1){
        if(section!=0)
            return 0;
        return self.models.count;
    }
    
    return ((NSArray*)[self.sorted objectAtIndex:section]).count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(status==1)
        return 1;
    return self.sorted.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itemID];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemID];
    
    CKItemModel *model;
    if(status == 1){
        model = [self.models objectAtIndex:indexPath.row];
    }
    else{
        model = [((NSArray*)[self.sorted objectAtIndex:indexPath.section])objectAtIndex:indexPath.row];
    }
    
    UIImageView *imageView =(UIImageView*)[cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:model.imageFileName];
    UILabel *label = (UILabel*)[cell viewWithTag:101];
    label.text = model.date;
    label = (UILabel*)[cell viewWithTag:102];
    label.text = model.imageTitle;

    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(status==1)
        return nil;
    NSArray *a = [self.sorted objectAtIndex:section];
    CKItemModel *model = [a firstObject];
    return [model.date substringWithRange:NSMakeRange(0, 4)];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CKDetailViewController *dview = [[CKDetailViewController alloc] initWithNibName:@"Main" bundle:[NSBundle mainBundle]];
//    NSDictionary *object = [self.models objectAtIndex: indexPath.row];
//    [dview setDetailItem:object];
//    [self.navigationController pushViewController:dview animated:YES];
//    self.tableView selectRowAtIndexPath:<#(NSIndexPath *)#> animated:<#(BOOL)#> scrollPosition:<#(UITableViewScrollPosition)#>
    [self performSegueWithIdentifier:@"goDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue");
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CKItemModel *model;
    if(status == 1){
        model = [self.models objectAtIndex:indexPath.row];
    }
    else{
        model = [((NSArray*)[self.sorted objectAtIndex:indexPath.section])objectAtIndex:indexPath.row];
    }

    [[segue destinationViewController] setDetailItem:model];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CKItemModel *model;
        if(status == 1){
            model = [self.models objectAtIndex:indexPath.row];
            [self.models removeObject:model];
            for(NSMutableArray *arr in self.sorted)
                [arr removeObject:model];
        }
        else{
            model = [((NSArray*)[self.sorted objectAtIndex:indexPath.section])objectAtIndex:indexPath.row];
            [((NSMutableArray*)[self.sorted objectAtIndex:indexPath.section]) removeObject: model];
            [self.models removeObject:model];
        }

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
