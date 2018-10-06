//
//  BNHttpURL.h
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#ifndef BNHttpURL_h
#define BNHttpURL_h


#define kBaseUrl @"http://dev.band.360.cn/indexv1/"

//获取用户模式
#define kUserModeUrl  [NSString stringWithFormat:@"%@getMode" , kBaseUrl]

//修改用户模式
#define kUpdateUserModeUrl [NSString stringWithFormat:@"%@updateUsermode" , kBaseUrl]

//获取手环信息
#define kGetBandInfo [NSString stringWithFormat:@"%@getBandinfo" , kBaseUrl]

//添加用户手环信息
#define kAddBandInfo [NSString stringWithFormat:@"%@addBandinfo" , kBaseUrl]

//获取统计信息 //getstaticinfo
#define kStaticinfo [NSString stringWithFormat:@"%@getstaticinfo" , kBaseUrl]

//版本更新 --getversion
#define kUpdateVersion [NSString stringWithFormat:@"%@getversion" , kBaseUrl]

//问题反馈
#define kFeedBack @"http://dev.band.360.cn/static/userfeedback"

//健康总结弹窗 getpopstatic
#define kPopStatic  [NSString stringWithFormat:@"%@getpopstatic" , kBaseUrl]

//APNs推送的Token上传http://dev.band.360.cn/indexv1/addwid?q=1&t=1
#define kAPNsTokenUpload [NSString stringWithFormat:@"%@addwid", kBaseUrl]


#endif /* BNHttpURL_h */
