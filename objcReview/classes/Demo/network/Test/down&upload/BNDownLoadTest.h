//
//  BNDownLoadTest.h
//  objcReview
//
//  Created by aBerning on 2019/9/30.
//  Copyright © 2019 Bien. All rights reserved.
//
//分段下载
#import "BNBaseTest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNDownLoadTest : BNBaseTest

+ (void)downloadFileWithUrl:(NSString *)urlString completion:(void (^)(NSString * urlString))completion;

- (void)downloadFileWithUrl:(NSString *)urlString completion:(void (^)(NSString * urlString))completion;

@end

NS_ASSUME_NONNULL_END
