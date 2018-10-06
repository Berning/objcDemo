
//
//  BNBaseTableView.m
//  Xcode8
//
//  Created by Berning on 2018/9/5.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNBaseTableView.h"
#import "BNTableDelegate.h"

@interface BNBaseTableView()

@property(nonatomic,strong)NSMutableArray *dataList;

@property(nonatomic,strong)BNTableDelegate *tableDelegate;


@end

@implementation BNBaseTableView

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList=[[NSMutableArray alloc] init];
        for (int i=0; i<100; i++) {
            [_dataList addObject:@"王柏宁"];
        }
    }
    return _dataList;
}


+(void)addInView:(UIView *)view
{
    
    BNBaseTableView *tableview=[[self alloc] initWithFrame:view.frame style:UITableViewStylePlain];
    [view addSubview:tableview];
    
    tableview.tableDelegate = [BNTableDelegate createTableViewDelegateWithDataList:tableview.dataList
                                                                  selectBlock:^(NSIndexPath *indexPath) {
                                                                      NSLog(@"点击了%ld行cell", (long)indexPath.row);
                                                                  }];
    tableview.delegate = tableview.tableDelegate;
    tableview.dataSource = tableview.tableDelegate;

}


@end
