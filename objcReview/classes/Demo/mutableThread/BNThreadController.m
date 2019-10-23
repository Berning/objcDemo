//
//  BNThreadController.m
//  objcReview
//
//  Created by Berning on 2018/12/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNThreadController.h"
#import "BNThread.h"
#import "BNGCD.h"
#import "BNOpration.h"
#import "BNPthread.h"

@interface BNThreadController ()

@property(nonatomic,strong)NSMutableArray *threads;

@end

@implementation BNThreadController

- (NSMutableArray *)threads
{
    if (!_threads) {
        _threads=[NSMutableArray array];
    }
    return _threads;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.refreshControl=[[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
//    self.refreshControl.attributedTitle=[[NSAttributedString alloc] initWithString:@"下拉刷新数据..."];
//    self.refreshControl.tintColor=[UIColor redColor];
    [self.threads addObject:NSStringFromClass([BNPthread class])];
    [self.threads addObject:NSStringFromClass([BNThread class])];
    [self.threads addObject:NSStringFromClass([BNGCD class])];
    [self.threads addObject:NSStringFromClass([BNOpration class])];
    [self.threads addObject:NSStringFromClass([BNBlock class])];

}

//- (void)handleRefresh
//{
//    [self.threads addObject:NSStringFromClass([BNPthread class])];
//    [self.threads addObject:NSStringFromClass([BNThread class])];
//    [self.threads addObject:NSStringFromClass([BNGCD class])];
//    [self.threads addObject:NSStringFromClass([BNOpration class])];
//    [self.tableView reloadData];
//
//    [self.refreshControl endRefreshing];
//
//}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.threads.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"thread";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSUInteger len=[self.threads[indexPath.row] rangeOfString:@"BN"].length;
    NSUInteger strLen=[self.threads[indexPath.row] length];
    cell.textLabel.text=[self.threads[indexPath.row] substringWithRange:NSMakeRange(len, strLen-len)];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    Class class=NSClassFromString(self.threads[indexPath.row]);
    [class test];
}
@end
