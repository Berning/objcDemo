//
//  AppDelegate.m
//  Xcode8
//
//  Created by uBerning on 2017/3/12.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "AppDelegate.h"
#import "BNVcCycleViewController.h"
#import "ViewController.h"
#import "BNNavigationController.h"

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"application--willFinishLaunchingWithOptions");
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"application--didFinishLaunchingWithOptions");
    
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController=[[BNNavigationController alloc]initWithRootViewController:[ViewController new]];
    
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


@end
