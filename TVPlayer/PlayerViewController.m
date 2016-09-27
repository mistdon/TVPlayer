//
//  PlayerViewController.m
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "PlayerViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PlayerService.h"
#import "PlayerViewModel.h"
#import "PlayerTableViewCell.h"
#import "PlayViewController.h"


@interface PlayerViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"❤️ 👠 ❤️";
    PlayerViewModel *viewModel = [[PlayerViewModel alloc] init];
    [[viewModel getPlayerList] subscribeNext:^(NSArray *x) {
        self.datasource = [NSMutableArray arrayWithArray:x];
        [self.tableView reloadData];
    }error:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - UITableView datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerTableViewCellIdentifier"];
    cell.player = self.datasource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.width;
}
#pragma mark - SB reference
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showPlayIdentifier"]) {
        PlayViewController *play = segue.destinationViewController;
        if ([sender isKindOfClass:[PlayerTableViewCell class]]) {
            NSIndexPath *indexPath  = [self.tableView indexPathForCell:sender];
            play.player = self.datasource[indexPath.row];
        }
    }
}
@end
