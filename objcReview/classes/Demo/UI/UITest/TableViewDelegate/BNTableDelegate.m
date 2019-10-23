//
//  BNTableDelegate.m
//  Xcode8
//
//  Created by Berning on 2018/9/5.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNTableDelegate.h"

@interface BNTableDelegate()

@property (nonatomic, strong) NSArray   *dataList;
@property (nonatomic, copy)   selectCell selectBlock;

@end

@implementation BNTableDelegate

+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList
selectBlock:(selectCell)selectBlock {
    return [[[self class] alloc] initTableViewDelegateWithDataList:dataList
                                                       selectBlock:selectBlock];
}

- (instancetype)initTableViewDelegateWithDataList:(NSArray *)dataList selectBlock:(selectCell)selectBlock {
    self = [super init];
    if (self) {
        self.dataList = dataList;
        self.selectBlock = selectBlock;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"%@-%li", self.dataList[indexPath.row],indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 将点击事件通过block的方式传递出去
    self.selectBlock(indexPath);
}


@end
