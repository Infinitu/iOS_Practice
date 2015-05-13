//
//  ViewController.m
//  week11
//
//  Created by 김창규 on 2015. 5. 11..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()
@property NSMutableArray *array;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.array = [NSMutableArray array];
    sqlite3 *db;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"top25" ofType:@"db"];
    sqlite3_open([path cStringUsingEncoding:NSUTF8StringEncoding], &db);
    
    NSString *sql = @"SELECT * FROM tbl_songs;";
    const char *last;
    sqlite3_stmt *stmt;
    int result;
    result = sqlite3_prepare(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], (int)sql.length, &stmt, &last);
    
    if(result!=SQLITE_OK){
        NSLog(@"error on prepare");
        return;
    }
    
    for(result = sqlite3_step(stmt);result == SQLITE_ROW;result = sqlite3_step(stmt)){
        NSDictionary *dic = @{
                              @"title":[NSString stringWithCString:sqlite3_column_text(stmt, 1)
                                                           encoding:NSUTF8StringEncoding],
                              @"genre":[NSString stringWithCString:sqlite3_column_text(stmt, 2)
                                                           encoding:NSUTF8StringEncoding],
                              @"url":[NSString stringWithCString:sqlite3_column_text(stmt, 3)
                                                         encoding:NSUTF8StringEncoding],
                              };
        [self.array addObject:dic];
    }
    
    NSLog(@"%@",self.array);
    
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.array[indexPath.row];
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.array[indexPath.row];
    NSURL *url = [NSURL URLWithString:dic[@"url"]];
    [[UIApplication sharedApplication] openURL:url];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
