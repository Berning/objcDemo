//
//  BNQuestionsTableViewController.h
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BNQuestionsTableViewControllerDelegate <NSObject>


@optional

-(void)questionsTableViewCellLoadString:(NSString *)string;

@end

@interface BNQuestionsTableViewController : UITableViewController

@property(nonatomic,weak)id<BNQuestionsTableViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
