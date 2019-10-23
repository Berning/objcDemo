//
//  NSString+BN.h
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BN)

//blankString
+ (BOOL)isBlankString:(NSString *)string;

//filename
+(NSString *)documentsPath:(NSString *)fileName;


@end



@interface NSString (Device)

/** 设备型号 */
+ (NSString *)stringWithDeviceModelDetail;

#pragma mark -bundle

/** 获取app名字 */
+ (NSString *)stringWithBundleName;

/** 获取app版本号 */
+ (NSString *)stringWithBundleVersion;

/** 获取app版本编译号 */
+ (NSString *)stringWithBundleBuild;

/** 获取应用程序ID */
+ (NSString *)stringWithBundleIdentifier;

#pragma mark -device
/** 获取设备ID (base on [openUDID class])*/
+ (NSString *)stringWithDeviceUDID;

/** 获取设备与应用结合ID (aka .vendor identifer)*/
+ (NSString *)stringWithDeviceVDID ;

+ (NSString*)stringWithUUIDNew;

+ (NSString*)stringWithUUID;


/** 获取操作系统 */
+ (NSString *)stringWithDeviceOS;

/** 获取操作系统版本号 */
+ (NSString *)stringWithDeviceSystemVersion;

/** 获取系统设备名字 */
+ (NSString *)stringWithDeviceName;


+ (NSString *)stringWithDeviceModel;


/** 获取系统语言 */
+ (NSString *)stringWithDeviceSystemLanguage;

#pragma mark -screen
/** 获取屏幕分辨率 */
+ (NSString *)stringWithScreenDisplay;

/** 获取屏幕密度 */
+ (NSString *)stringWithScreenDensity;


/** 获取wifi物理地址 */
+ (NSString *)stringWithWiFiMac;

/** 当前网络类型（wifi、wlan、其他） */
+ (NSString *)stringWithNetWorkType;

/** 运营商类型（移动、电信、联通） */
+ (NSString *)stringWithCarrier;

/** wifi是否可用 */
+ (BOOL)isWiFiAvailible;

/** 蓝牙是否可用 */
+ (BOOL)isBlueToothAvailible;

/** 重力感应是否可用 */
+ (BOOL)isGravityAvailible;


+ (NSString *)stringWithMCC_MNC;

@end


@interface NSString (runtime)

NSString *NSStringFromObject(id object);


@end
