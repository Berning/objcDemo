//
//  BNUploaderPOSTTest.h
//  objcReview
//
//  Created by aBerning on 2019/10/7.
//  Copyright © 2019 Bien. All rights reserved.
//
//POST上传表单

#import "BNBaseTest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNUploadPOSTTest : BNBaseTest

- (void)upload:(NSString *)urlString  file:(NSString *)fileString;

@end

NS_ASSUME_NONNULL_END
