//
//  BNMenu.h
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum: NSUInteger{
    BNSuperViewTypeOnTitleView,
    BNSuperViewTypeOnView
    
}BNSuperViewType;

NS_ASSUME_NONNULL_BEGIN

@interface BNMenu : UIView

+ (void)controllersSwitchOnController:(UIViewController *)controller superViewType:(BNSuperViewType)superViewType;

@end

NS_ASSUME_NONNULL_END
