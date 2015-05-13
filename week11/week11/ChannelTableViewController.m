//
//  ChannelTableViewController.m
//  week11
//
//  Created by 김창규 on 2015. 5. 13..
//  Copyright (c) 2015년 org.next. All rights reserved.
//

#import "ChannelTableViewController.h"
#import "Channel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ChannelTableViewController ()
@property NSMutableArray *objects;
@end

@implementation ChannelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    RLMRealm *realm = [RLMRealm realmWithPath:[[NSBundle mainBundle] pathForResource:@"ktv" ofType:@"realm"]readOnly:YES error:nil];
    RLMResults *res = [Channel allObjectsInRealm:realm];
    self.objects = [NSMutableArray array];
    for(Channel *channel in res)
        [self.objects addObject:channel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a" forIndexPath:indexPath];
    
    cell.textLabel.text = ((Channel*)self.objects[indexPath.row]).title;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MPMoviePlayerViewController *player =
    [[MPMoviePlayerViewController alloc] initWithContentURL: [NSURL URLWithString:[self channelURLWithIndex:indexPath.row]]];
    [self presentMoviePlayerViewControllerAnimated:player];
    
}

-(NSString*)channelURLWithIndex:(NSInteger)index {
    NSInteger serverInteger = (12 + arc4random_uniform(15 - 12 + 1));
    NSString *temp1 = @"http://121.156.46.";
    NSString *temp2 = [(Channel *)[self.objects objectAtIndex:index]
                       channelNum];
    NSString *temp3 = [(Channel *)[self.objects objectAtIndex:index]
                       quality];
    NSString *url = [NSString stringWithFormat:@"%@%ld/live/1%@%@.m3u8?sid=", temp1, serverInteger, temp2, temp3];
                     return url;
}

@end
