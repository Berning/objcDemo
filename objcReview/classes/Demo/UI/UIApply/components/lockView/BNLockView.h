//
//  BNLockView.h
//  UI
//
//  Created by Berning on 2018/12/19.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNLockView;

@protocol BNLockViewDelegate <NSObject>

@optional
- (void)lockView:(BNLockView *)lockView didFinishPath:(NSString *)path;

@end

@interface BNLockView : UIView
@property (nonatomic, weak) IBOutlet id<BNLockViewDelegate> delegate;
@end
