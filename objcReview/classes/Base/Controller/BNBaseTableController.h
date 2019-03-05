//
//  BNBaseTableController.h
//  objcReview
//
//  Created by Berning on 2019/1/7.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNBaseTableController : BNBaseController<UITableViewDelegate,UITableViewDataSource>

- (id)initWithStyle:(UITableViewStyle)style;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, assign) UITableViewStyle style;
@property (nonatomic, strong, nullable) UIRefreshControl *refreshControl;

@end

NS_ASSUME_NONNULL_END
