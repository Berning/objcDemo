//
//  BNChoiceList.h
//  objcReview
//
//  Created by Berning on 2019/1/25.
//  Copyright © 2019年 Bien. All rights reserved.
//
#define cellHeight 50

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNChoiceList : UITableView<UITableViewDelegate,UITableViewDataSource>

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
