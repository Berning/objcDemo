//
//  AppDelegate.m
//  Xcode8
//
//  Created by uBerning on 2017/3/12.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "AppDelegate.h"
#import "BNTabBarController.h"
#import "BNTableViewManagerTest.h"

#import <UserNotifications/UserNotifications.h>
//推送
//1.原生推送
//2.JPush
//3.UPush
//4.百度推送

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"application--willFinishLaunchingWithOptions");
    return YES;
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"application--didFinishLaunchingWithOptions");
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=[BNTabBarController new];
    [self.window makeKeyAndVisible];
//    self.window.rootViewManager=[[BNNavigationManager alloc] initWithRootViewManager:[BNTableViewManagerTest new]];
//    [self.window makeMainAndVisible];
    
    //push
    [self applicationPushRegister:application];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    NSLog(@"application--applicationWillResignActive");

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"application--applicationDidEnterBackground");

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"application--applicationWillEnterForeground");

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSString *str=[NSString string];
    for (int i=0; i<127; i++) {
        str= [str stringByAppendingString:@"-"];

    }
    NSLog(@"application--applicationDidBecomeActive\n\n%@\n",str);

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"application--applicationWillTerminate");

}

#pragma mark - push

- (void)applicationPushRegister:(UIApplication *)application
{
     
    if (@available(iOS 10.0, *))
    {
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center setDelegate:self];
        
        UNAuthorizationOptions type =   UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert;
        
        [center requestAuthorizationWithOptions:type completionHandler:^(BOOL granted, NSError *     _Nullable error) {
            
            if (granted) {
                NSLog(@"注册成功");
            }else{
                NSLog(@"注册失败");
            }
        }];
    
    }else if(@available(iOS 8.0,*))
    {
     
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
     
        UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
     
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
     
        [application registerUserNotificationSettings:settings];
     
    }else{//ios8以下 app最低部署iOS8.0，所以不适合
     
//        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
//
//        UIRemoteNotificationTypeSound |
//
//        UIRemoteNotificationTypeAlert;
//
//        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:notificationTypes];
//
    }
     
    // 注册获得device Token
     
    [application registerForRemoteNotifications];
}


@end
