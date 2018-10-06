//
//  BNDefines.h
//  Xcode8
//
//  Created by uBerning on 2017/3/14.
//  Copyright © 2017年 BN. All rights reserved.
//

#ifndef BNDefines_h
#define BNDefines_h

//自定义Log
#ifdef DEBUG
#define BNLog(s, ...)  NSLog(@"%@\nps:---[%@@%@:%d(line)]---\n", \
/*打印内容*/[NSString stringWithFormat:(s), ##__VA_ARGS__],\
/*方法名*/NSStringFromSelector(_cmd),\
/*类名*/[@__FILE__ lastPathComponent],\
/*行数*/__LINE__);
#else
#define BNLog(s, ...) do{}while(0)
#endif


#ifdef DEBUG
#define dLog(...) NSLog(__VA_ARGS__)
#else
#define dLog(...)
#endif


//高度
#define kCellHeight         55
#define kTabbarHeight       49
#define kNavBarHeight       44

#define kMainScreenBounds   [[UIScreen mainScreen] bounds]
#define kMainScreenSize     kMainScreenBounds.size

#define kMainScreenWidth    kMainScreenSize.width
#define kMainScreenHeight   kMainScreenSize.height

#define kNavigationBarHeight_Portrait    64
#define kNavigationBarFrame_Portrait     CGRectMake(0, 0, kMainScreenWidth, NavigationBarHeight_Portrait)


#define BNColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//十六进制色值
#define BNColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define BNColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


//字体
#define BNFontOfSize(x)                   [UIFont systemFontOfSize:(x)]
#define BNFontOfSize_B(x)                 [UIFont boldSystemFontOfSize:(x)]
#define BNFontWithNameAndSize(x,y)        [UIFont fontWithName:x size:y]

//iOS SDK兼容
#ifdef __IPHONE_6_1
#define UITextAlignmentCenter NSTextAlignmentCenter
#define UITextAlignmentLeft   NSTextAlignmentLeft
#define UITextAlignmentRight  NSTextAlignmentRight
#endif

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//主线程
#define bn_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define bn_dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

//沙盒路径

#define BNUserDefaults  [NSUserDefaults standardUserDefaults]

#define UserDomain_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

//用户数据保存路径
#define UserRingData_PATH [NSString stringWithFormat:@"%@/ringData" , UserDomain_PATH]

//应用程序对象
#define BNNotificationCenter   [NSNotificationCenter defaultCenter]
#define BNApplication          [UIApplication sharedApplication]
#define BNAppDelegate          [BNApplication delegate]
#define BNRootViewController   BNAppDelegate.window.rootViewController
#define BNGetTabController      ((BNTabBarController *)QHRootViewController)

//字符串判断
#define strIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || ([str isKindOfClass:[NSString class]] && [str length]<1) ? YES : NO )
#define strIsNA(str) (str != nil && [str isKindOfClass:[NSString class]] && [str compare:@"N/A"] == NSOrderedSame)




#endif /* BNDefines_h */
