//
//  BNDefines.h
//  Xcode8
//
//  Created by uBerning on 2017/3/14.
//  Copyright © 2017年 BN. All rights reserved.
//

#ifndef BNDefines_h
#define BNDefines_h

#pragma mark -log

//自定义Log
#ifdef DEBUG
#define dLog(s, ...)  NSLog(@"%@\nps:---[%@@%@:%d(line)]---\n", \
/*打印内容*/[NSString stringWithFormat:(s), ##__VA_ARGS__],\
/*方法名*/NSStringFromSelector(_cmd),\
/*类名*/[@__FILE__ lastPathComponent],\
/*行数*/__LINE__);
#else
#define dLog(s, ...) do{}while(0)
#endif


#ifdef DEBUG
#define BNLog(...) NSLog(__VA_ARGS__)
#else
#define BNLog(...)
#endif


#pragma mark -screen frame

#define kApplictionStatusBarHeight BNApplication.statusBarFrame.size.height
#define kCellHeight         55
#define kNavBarHeight       44
#define kNavigationBarHeight_Portrait    64
#define kTabBarHeight_Portrait    49

#define kMainScreenBounds   [[UIScreen mainScreen] bounds]
#define kMainScreenSize     kMainScreenBounds.size
#define kMainScreenWidth    kMainScreenSize.width
#define kMainScreenHeight   kMainScreenSize.height

#define kNavigationBarFrame_Portrait     CGRectMake(0, 0, kMainScreenWidth, NavigationBarHeight_Portrait)



#pragma mark -颜色
//十进制色
#define BNColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define BNColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


//十六进制色值
#define BNColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BNColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//随机色
#define BNRandomColor BNColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#pragma mark -字体
//字体
#define BNFontOfSize(x)                   [UIFont systemFontOfSize:(x)]
#define BNFontOfSize_B(x)                 [UIFont boldSystemFontOfSize:(x)]
#define BNFontWithNameAndSize(x,y)        [UIFont fontWithName:x size:y]

#pragma mark -iOS SDK兼容
#ifdef __IPHONE_6_1
#define UITextAlignmentCenter NSTextAlignmentCenter
#define UITextAlignmentLeft   NSTextAlignmentLeft
#define UITextAlignmentRight  NSTextAlignmentRight
#endif

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#pragma mark -主线程
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

#pragma mark -沙盒路径（Document）

#define BNUserDefaults  [NSUserDefaults standardUserDefaults]

#define UserDomain_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]



#pragma mark -应用程序对象
#define BNApplication          [UIApplication sharedApplication]
#define BNAppDelegate          [BNApplication delegate]
#define BNRootViewController   BNAppDelegate.window.rootViewController
#define BNGetTabController      ((BNTabBarController *)QHRootViewController)

#pragma mark -字符串判断
#define strIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || ([str isKindOfClass:[NSString class]] && [str length]<1) ? YES : NO )
#define strIsNA(str) (str != nil && [str isKindOfClass:[NSString class]] && [str compare:@"N/A"] == NSOrderedSame)

#pragma mark -通知中心
#define BNNotificationCenter   [NSNotificationCenter defaultCenter]



#endif /* BNDefines_h */
