//
//  BNQuestion.h
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNQuestion : NSObject

@property(nonatomic,copy)NSString *question;
@property(nonatomic,copy)NSString *date;

@property(nonatomic,assign)NSUInteger ID;

@property(nonatomic,assign)CGRect questionF;

@property(nonatomic,assign)CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
