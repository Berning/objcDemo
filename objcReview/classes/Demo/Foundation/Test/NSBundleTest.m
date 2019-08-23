//
//  NSBundleTest.m
//  objcReview
//
//  Created by Berning on 2019/1/23.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "NSBundleTest.h"

@implementation NSBundleTest

+(void)test
{
    [self bundleTest];
}

+ (void)bundleTest
{
    BNLog(@"------%s------",__func__);
    NSBundle *bundle=[NSBundle mainBundle];
    NSDictionary *infoDict=[bundle infoDictionary];
    BNLog(@"bundleInfo:%@",infoDict);
    
    BNLog(@"BundleName:%@",[NSString stringWithBundleName]);
    BNLog(@"BundleID:%@",[NSString stringWithBundleIdentifier]);
    BNLog(@"BundleVersion:%@",[NSString stringWithBundleVersion]);
    BNLog(@"BundleBuildVersion:%@",[NSString stringWithBundleBuild]);
}


@end

@implementation UIApplicationTest

+ (void)test
{
    [self appTest];
}

+ (void)appTest
{
    BNLog(@"------%s------",__func__);
    
    UIApplication *app=[UIApplication sharedApplication];
    BNLog(@"app:%@",app);
}

@end



@implementation UIScreenTest

+ (void)test
{
    [self screenTest];
}
+ (void)screenTest
{
    BNLog(@"------%s------",__func__);
    
    BNLog(@"screens:%@",[UIScreen screens]);
    UIScreen *screen=[UIScreen mainScreen];
    BNLog(@"bounds:%@",NSStringFromCGRect([screen bounds]));
    BNLog(@"currentMode:%@",[screen currentMode]);
    BNLog(@"scale:%f",[screen scale]);
    BNLog(@"nativeBounds:%@",NSStringFromCGRect([screen nativeBounds]));
    BNLog(@"nativeScale:%f",[screen nativeScale]);
    BNLog(@"availableModes:%@",[screen availableModes]);
    BNLog(@"preferredMode:%@",[screen preferredMode]);
    BNLog(@"overscanCompensation:%ld",[screen overscanCompensation]);
    BNLog(@"overscanCompensationInsets:%@",NSStringFromUIEdgeInsets([screen overscanCompensationInsets]));
    BNLog(@"mirroredScreen:%@",[screen mirroredScreen]);
    BNLog(@"isCaptured:%d",[screen isCaptured]);
    BNLog(@"brightness:%f",[screen brightness]);
    BNLog(@"wantsSoftwareDimming:%d",[screen wantsSoftwareDimming]);
    
    BNLog(@"coordinateSpace:%@",screen.coordinateSpace);
    BNLog(@"fixedCoordinateSpace:%@",screen.fixedCoordinateSpace);
    BNLog(@"maximumFramesPerSecond:%ld",[screen maximumFramesPerSecond]);
    BNLog(@"focusedItem:%@",screen.focusedItem);
    BNLog(@"supportsFocus:%d",[screen supportsFocus]);
//    BNLog(@"applicationFrame:%@",NSStringFromCGRect(screen.applicationFrame));
    CADisplayLink *link=[screen displayLinkWithTarget:self selector:@selector(linkAction)];
    BNLog(@"%f",link.timestamp);
    BNLog(@"%f",link.duration);

    UIScreenMode *mode=[screen currentMode];
    BNLog(@"size:%@",NSStringFromCGSize([mode size]));
    BNLog(@"pixelAspectRatio:%f",[mode pixelAspectRatio]);
    
    //NSString+BN
    BNLog(@"ScreenDensity:%@",[NSString stringWithScreenDensity]);
    BNLog(@"ScreenDisplay:%@",[NSString stringWithScreenDisplay]);
    
}

- (void)linkAction
{
    BNLog(@"dkddkk");
}

@end

@implementation UIDeivceTest

+ (void)test
{
    [self deviceTest];
}

+ (void)deviceTest
{
    BNLog(@"------%s------",__func__);
    
    UIDevice *device=[UIDevice currentDevice];
    device.batteryMonitoringEnabled=YES;
    device.proximityMonitoringEnabled=YES;
    BNLog(@"name-%@",device.name);
    BNLog(@"model--%@",[device model]);
    BNLog(@"localizedModel-%@",device.localizedModel);
    BNLog(@"systemName-%@",device.systemName);
    BNLog(@"systemVersion-%@",device.systemVersion);
    BNLog(@"orientation-%ld",device.orientation);
    BNLog(@"identifierForVendor-%@",device.identifierForVendor);
    BNLog(@"generatesDevice-%d",device.generatesDeviceOrientationNotifications);
    BNLog(@"batteryMonitoringEnabled-%d",device.batteryMonitoringEnabled);
    BNLog(@"batteryState-%ld",device.batteryState);
    BNLog(@"batteryLevel-%f",device.batteryLevel);
    BNLog(@"proximityState-%d",device.proximityState);
    BNLog(@"proximityMonitoringEnabled-%d",device.proximityMonitoringEnabled);
    BNLog(@"multitaskingSupported-%d",device.multitaskingSupported);
    BNLog(@"userInterfaceIdiom-%ld",device.userInterfaceIdiom);
    
    //NSString+BN
    BNLog(@"DeviceModel:%@",[NSString stringWithDeviceModel]);
    BNLog(@"DeviceModel:%@",[NSString stringWithDeviceModelDetail]);
    BNLog(@"BundleBuildVersion:%@",[NSString stringWithDeviceSystemLanguage]);
    BNLog(@"DeviceSystemVersion:%@",[NSString stringWithDeviceSystemVersion]);
    BNLog(@"DeviceOS:%@",[NSString stringWithDeviceOS]);
    BNLog(@"DeviceVDID:%@",[NSString stringWithDeviceVDID]);
    BNLog(@"DeviceUDID:%@",[NSString stringWithDeviceUDID]);
    BNLog(@"DeviceName:%@",[NSString stringWithDeviceName]);
    
    
    BNLog(@"NetWorkType:%@",[NSString stringWithNetWorkType]);
    BNLog(@"Carrier:%@",[NSString stringWithCarrier]);
    BNLog(@"WiFiMac:%@",[NSString stringWithWiFiMac]);
    
    BNLog(@"isWiFiAvailible:%d",[NSString isWiFiAvailible]);
    BNLog(@"isBlueToothAvailible:%d",[NSString isBlueToothAvailible]);
    BNLog(@"isGravityAvailible:%d",[NSString isGravityAvailible]);
    BNLog(@"MCC_MNC:%@",[NSString stringWithMCC_MNC]);
    
}

@end


