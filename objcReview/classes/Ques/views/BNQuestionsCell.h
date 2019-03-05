//
//  BNQuestionsCell.h
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNQuestion;
NS_ASSUME_NONNULL_BEGIN

@interface BNQuestionsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property(nonatomic,strong)BNQuestion *question;


@end

NS_ASSUME_NONNULL_END
