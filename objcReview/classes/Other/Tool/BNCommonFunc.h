//
//  BNCommonFunc.h
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNCommonFunc : NSObject

//返回除数，判断范围  93 -->0.093
+(NSString *) getFormatNumStr:(float) num;


//给定分钟，返回小时 ---93mins==1.55h
+(NSString *) getFormatTimeStr:(float) min;


//给定分钟，返回小时分钟 ----93mins==1小时33分钟
+(NSString *) getFormatTimeHourMinStr:(float) min;


@end
