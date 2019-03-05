//
//  BNBack.h
//  Questions
//
//  Created by Berning on 2018/12/27.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNBack : UIView

@property(nonatomic,copy)NSString *title;

- (void)addTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
