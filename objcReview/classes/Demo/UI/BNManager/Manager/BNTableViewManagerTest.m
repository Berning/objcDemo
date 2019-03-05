//
//  BNTableViewManagerTest.m
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNTableViewManagerTest.h"
#import "BNTableViewCellTest.h"
#import "BNListView.h"

#import "BNViewManagerTest.h"

@interface BNTableViewManagerTest()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,weak)BNListView *listView;

@property(nonatomic,strong)NSMutableArray *datas;

@end

@implementation BNTableViewManagerTest

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas=[NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *one=@[@"00",@"01",@"02"];
    NSArray *two=@[@"10",@"11",@"12",@"13"];
    NSArray *three=@[@"20",@"21",@"22",@"23",@"24"];
    [self.datas addObject:one];
    [self.datas addObject:two];
    [self.datas addObject:three];
    
    [self addSubviews];
}

- (void)addSubviews
{
    [self.navigationManager.navigationBar.rightBarItem addTarget:self action:@selector(showList)];

    //tableView
    UITableView *tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    self.tableView=tableView;
    [self.view addSubview:tableView];
    
    //listView
    NSArray *data=@[@"发起群聊",@"添加朋友",@"扫一扫",@"收付款"];
    BNListView *listView=[BNListView listWithData:data];
    [self.view addSubview:listView];
    self.listView=listView;
}

- (void)showList
{
    self.listView.hidden=!self.listView.isHidden;
}


#pragma mark -tableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas[section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BNTableViewCellTest *cell=[BNTableViewCellTest cellWithtableView:tableView];
    cell.textLabel.text=self.datas[indexPath.section][indexPath.row];
    
    return cell;
}


#pragma mark -tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [self presentViewManager:[[BNNavigationManager alloc]initWithRootViewManager:[BNViewMangerTest new]] Animated:YES completion:nil];
    [self.navigationManager pushViewManager:[BNViewMangerTest new] animated:YES];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *header=[UIView new];
//    return header;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return -1;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footer=[UIView new];
//    return footer;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return -1;
//}



#pragma  mark -scrollViewDelegate


//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.view layoutIfNeeded];
//
//}
//
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    [self.view layoutIfNeeded];
//
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [self.view layoutIfNeeded];
//
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self.view layoutIfNeeded];
//}


//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    [self.view layoutIfNeeded];
//
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self.view layoutIfNeeded];
//}

@end
