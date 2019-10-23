//
//  NSString+BN.m
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "NSString+BN.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (BN)


+(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


static NSString *const keyKeychainKey = @"com.sobeycloud.cdAnalysis";

#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CommonCrypto/CommonDigest.h>
#import <sys/sysctl.h>

//#import <SystemConfiguration/SystemConfiguration.h>
//#import <CoreBluetooth/CoreBluetooth.h>
//#import <objc/runtime.h>
#import <sys/utsname.h>

@implementation NSString (Device)

+ (NSString *)stringWithDeviceModelDetail
{
//type1
//    struct utsname systemInfo;
//
//    uname(&systemInfo);
//    NSString *platform =[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    

//type2
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
#pragma mark -iPhone
    //07/1/9
    if([platform isEqualToString:@"iPhone1,1"])return @"iPhone (A1203)";
    //08/6/9
    if([platform isEqualToString:@"iPhone1,2"])return @"iPhone 3G (A1241/A1324)";
    //09/6/8
    if([platform isEqualToString:@"iPhone2,1"])return @"iPhone 3GS (A1303/A1325)";
    //10/6/7
    if([platform isEqualToString:@"iPhone3,1"])return @"iPhone 4 (A1332)";
    if([platform isEqualToString:@"iPhone3,2"])return @"iPhone 4 (A1332)";
    if([platform isEqualToString:@"iPhone3,3"])return @"iPhone 4 (A1349)";
    //11/10/4
    if([platform isEqualToString:@"iPhone4,1"])return @"iPhone 4S (A1387/A1431)";
    //12/12/12
    if([platform isEqualToString:@"iPhone5,1"])return @"iPhone 5 (A1428)";
    if([platform isEqualToString:@"iPhone5,2"])return @"iPhone 5 (A1429/A1442)";
    //13/9/10
    if([platform isEqualToString:@"iPhone5,3"])return @"iPhone 5c (A1456/A1532)";
    if([platform isEqualToString:@"iPhone5,4"])return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    //13/9/10
    if([platform isEqualToString:@"iPhone6,1"])return @"iPhone 5s (A1453/A1533)";
    if([platform isEqualToString:@"iPhone6,2"])return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    
    //14/9/9
    if([platform isEqualToString:@"iPhone7,1"])return @"iPhone 6 Plus (A1522/A1524/A1593)";
    if([platform isEqualToString:@"iPhone7,2"])return @"iPhone 6 (A1549/A1586/A1589)";
    //15/9/9
    if([platform isEqualToString:@"iPhone8,1"])return @"iPhone 6s (A1633/A1688/A1691/A1700)";
    if([platform isEqualToString:@"iPhone8,2"])return @"iPhone 6s Plus (A1634/A1687/A1690/A1699)";
    //16/3/21
    if([platform isEqualToString:@"iPhone8,4"])return @"iPhone SE (A1662/A1723/A1724)";
    //16/9/7
    if([platform isEqualToString:@"iPhone9,1"])return @"iPhone 7 (A1660/A1779/A1780)";
    if([platform isEqualToString:@"iPhone9,2"])return @"iPhone 7 Plus (A1661/A1785/A1786)";
    if([platform isEqualToString:@"iPhone9,3"])return @"iPhone 7 (A1778)";
    if([platform isEqualToString:@"iPhone9,4"])return @"iPhone 7 Plus (A1784)";
    //17/9/12
    if([platform isEqualToString:@"iPhone10,1"])return @"iPhone 8 (A1863/A1906/A1907)";
    if([platform isEqualToString:@"iPhone10,2"])return @"iPhone 8 Plus (A1864/A1898/A1899)";
    if([platform isEqualToString:@"iPhone10,3"])return @"iPhone X (A1865/A1902)";
    if([platform isEqualToString:@"iPhone10,4"])return @"iPhone 8 (A1905)";
    if([platform isEqualToString:@"iPhone10,5"])return @"iPhone 8 Plus (A1897)";
    if([platform isEqualToString:@"iPhone10,6"])return @"iPhone X (A1901)";
    //18/9/12
    if([platform isEqualToString:@"iPhone11,2"])return @"iPhone XS (A1920/A2097/A2098/A2100)";
    if([platform isEqualToString:@"iPhone11,4"])return @"iPhone XS Max";
    if([platform isEqualToString:@"iPhone11,6"])return @"iPhone XS Max (A1921/A2101/A2102/A2104)";
    if([platform isEqualToString:@"iPhone11,8"])return @"iPhone XR (A1984/A2105/A2106/A2108)";
    
#pragma mark -iPod
    //8 and 16 GB: 07/9/5
    //32 GB: 08/2/27
    if([platform isEqualToString:@"iPod1,1"])return @"iPod Touch 1G (A1213)";
    //8, 16, and 32 GB: 08/9/9
    //8 GB (MC model):  09/9/9
    if([platform isEqualToString:@"iPod2,1"])return @"iPod Touch 2G (A1288/A1319)";
    //09/9/9
    if([platform isEqualToString:@"iPod3,1"])return @"iPod Touch 3G (A1318)";
    //Black (8, 32, and 64 GB): 10/9/1
    //White (8, 32, and 64 GB): 11/10/12
    //Black and white (16 GB): 12/9/12
    if([platform isEqualToString:@"iPod4,1"])return @"iPod Touch 4G (A1367)";
    //13/5/30 (iOS6.1.3)
    //32 and 64 GB: 12/10/11 (ios6.0)
    //16 GB: 14/6/26 (ios6.0)
    if([platform isEqualToString:@"iPod5,1"])return @"iPod Touch 5G (A1421/A1509)";
    //15/7/15
    if([platform isEqualToString:@"iPod7,1"])return @"iPod touch 6G (A1574)";
    
#pragma mark -iPad
    //10/1/27
    if([platform isEqualToString:@"iPad1,1"])return @"iPad 1 (A1219/A1337)";
    //11/3/2
    if([platform isEqualToString:@"iPad2,1"])return @"iPad 2 (A1395)";
    if([platform isEqualToString:@"iPad2,2"])return @"iPad 2 (A1396)";
    if([platform isEqualToString:@"iPad2,3"])return @"iPad 2 (A1397)";
    if([platform isEqualToString:@"iPad2,4"])return @"iPad 2 (A1395+New Chip)";
    //12/10/23
    if([platform isEqualToString:@"iPad2,5"])return @"iPad Mini (A1432)";
    if([platform isEqualToString:@"iPad2,6"])return @"iPad Mini (A1454)";
    if([platform isEqualToString:@"iPad2,7"])return @"iPad Mini (A1455)";
    //12/3/7
    if([platform isEqualToString:@"iPad3,1"])return @"iPad 3 (A1416)";
    if([platform isEqualToString:@"iPad3,2"])return @"iPad 3 (A1403)";
    if([platform isEqualToString:@"iPad3,3"])return @"iPad 3 (A1430)";
    //12/10/23
    if([platform isEqualToString:@"iPad3,4"])return @"iPad 4 (A1458)";
    if([platform isEqualToString:@"iPad3,5"])return @"iPad 4 (A1459)";
    if([platform isEqualToString:@"iPad3,6"])return @"iPad 4 (A1460)";
    
    //13/10/22
    if([platform isEqualToString:@"iPad4,1"])return @"iPad Air (A1474)";
    if([platform isEqualToString:@"iPad4,2"])return @"iPad Air (A1475)";
    if([platform isEqualToString:@"iPad4,3"])return @"iPad Air (A1476)";
    //13/10/22
    if([platform isEqualToString:@"iPad4,4"])return @"iPad Mini 2 (A1489)";
    if([platform isEqualToString:@"iPad4,5"])return @"iPad Mini 2 (A1490)";
    if([platform isEqualToString:@"iPad4,6"])return @"iPad Mini 2 (A1491)";
    
    //14/10/16
    if([platform isEqualToString:@"iPad5,3"])return @"iPad Air 2 (A1566)";
    if([platform isEqualToString:@"iPad5,4"])return @"iPad Air 2 (A1567)";
    //14/10/16
    if([platform isEqualToString:@"iPad4,7"])return @"iPad Mini 3 (A1599)";
    if([platform isEqualToString:@"iPad4,8"])return @"iPad Mini 3 (A1600)";
    if([platform isEqualToString:@"iPad4,9"])return @"iPad Mini 3 (A1601)";
   
    //15/9/9
    if([platform isEqualToString:@"iPad5,1"])return @"iPad Mini 4 (A1538)";
    if([platform isEqualToString:@"iPad5,2"])return @"iPad Mini 4 (A1550)";
    //15/9/9
    if([platform isEqualToString:@"iPad6,7"])return @"iPad Pro (12.9-inch,A1584)";
    if([platform isEqualToString:@"iPad6,8"])return @"iPad Pro (12.9-inch,A1652)";
    
    //16/3/21
    if([platform isEqualToString:@"iPad6,3"])return @"iPad Pro (9.7-inch,A1673)";
    if([platform isEqualToString:@"iPad6,4"])return @"iPad Pro (9.7-inch,A1674/A1675)";

    //17/3/21
    if([platform isEqualToString:@"iPad6,11"])return @"iPad 5 (A1822)";
    if([platform isEqualToString:@"iPad6,12"])return @"iPad 5 (A1823)";
    //17/6/5
    if([platform isEqualToString:@"iPad7,1"])return @"iPad Pro 2 (12.9-inch,A1670)";
    if([platform isEqualToString:@"iPad7,2"])return @"iPad Pro 2 (12.9-inch,A1671/A1821)";
    //17/6/5
    if([platform isEqualToString:@"iPad7,3"])return @"iPad Pro (10.5-inch,A1701)";
    if([platform isEqualToString:@"iPad7,4"])return @"iPad Pro (10.5-inch,A1709)";
    //18/3/27
    if([platform isEqualToString:@"iPad7,5"])return @"iPad 6 (A1893)";
    if([platform isEqualToString:@"iPad7,6"])return @"iPad 6 (A1954)";
    
    //18/10/30
    if([platform isEqualToString:@"iPad8,1"])return @"iPad Pro (11-inch,A1980)";
    if([platform isEqualToString:@"iPad8,2"])return @"iPad Pro (11-inch,A1980)";
    if([platform isEqualToString:@"iPad8,3"])return @"iPad Pro (11-inch,A1934/A1979/A2013)";
    if([platform isEqualToString:@"iPad8,4"])return @"iPad Pro (11-inch,A1934/A1979/A2013)";
    if([platform isEqualToString:@"iPad8,5"])return @"iPad Pro 3 (12.9-inch,A1876)";
    if([platform isEqualToString:@"iPad8,6"])return @"iPad Pro 3 (12.9-inch,A1876)";
    if([platform isEqualToString:@"iPad8,7"])return @"iPad Pro 3 (12.9-inch,A1895/A1983/A2014)";
    if([platform isEqualToString:@"iPad8,8"])return @"iPad Pro 3 (12.9-inch,A1895/A1983/A2014)";
    
#pragma mark -iWatch
    if([platform isEqualToString:@"Watch1,1"]) return @"Apple Watch (A1553)";
    if([platform isEqualToString:@"Watch1,2"]) return @"Apple Watch (A1554/A1638)";
    if([platform isEqualToString:@"Watch2,6"]) return @"Apple Watch Series 1 (A1802)";
    if([platform isEqualToString:@"Watch2,7"]) return @"Apple Watch Series 1 (A1803)";
    if([platform isEqualToString:@"Watch2,3"]) return @"Apple Watch Series 2 (A1757/A1816)";
    if([platform isEqualToString:@"Watch2,4"]) return @"Apple Watch Series 2 (A1758/A1817)";
    if([platform isEqualToString:@"Watch3,1"]) return @"Apple Watch Series 3 (A1860/A1889/A1890)";
    if([platform isEqualToString:@"Watch3,2"]) return @"Apple Watch Series 3 (A1861/A1891/A1892)";
    if([platform isEqualToString:@"Watch3,3"]) return @"Apple Watch Series 3 (A1858)";
    if([platform isEqualToString:@"Watch3,4"]) return @"Apple Watch Series 3 (A1859)";
    if([platform isEqualToString:@"Watch4,1"]) return @"Apple Watch Series 4 (A1977)";
    if([platform isEqualToString:@"Watch4,2"]) return @"Apple Watch Series 4 (A1978)";
    if([platform isEqualToString:@"Watch4,3"]) return @"Apple Watch Series 4 (A1975/A2007)";
    if([platform isEqualToString:@"Watch4,4"]) return @"Apple Watch Series 4 (A1976/A2008)";
    
    //Simulator
    if([platform isEqualToString:@"i386"])return @"iPhone Simulator";
    if([platform isEqualToString:@"x86_64"])return @"iPhone Simulator";
    
    return platform;
}

#pragma mark -bundle
/** 获取app名字 */
+ (NSString *)stringWithBundleName
{
    
    NSString *displayName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (displayName.length < 1) {
        displayName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    
    return displayName;
}

/** 获取app版本号 */
+ (NSString *)stringWithBundleVersion
{
    
    NSString *shortString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    return shortString;
}

/** 获取app版本编译号 */
+ (NSString *)stringWithBundleBuild
{
    
    NSString *buildString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    return buildString;
}

/** 获取应用程序ID */
+ (NSString *)stringWithBundleIdentifier
{
    
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    
    return bundleId;
}

#pragma mark -device

/** 获取设备ID */
+ (NSString *)stringWithDeviceUDID
{
    return [OpenUDID value];
}

/** 获取设备与应用结合ID */
+ (NSString *)stringWithDeviceVDID
{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}

+ (NSString*)stringWithUUIDNew
{
    return [[NSUUID UUID] UUIDString];
}

+ (NSString*)stringWithUUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (__bridge  NSString *)CFStringCreateCopy( NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


/** 获取操作系统 */
+ (NSString *)stringWithDeviceOS
{
    
    NSString *system = [[UIDevice currentDevice] systemName];

    return system;
}

/** 获取操作系统版本号 */
+ (NSString *)stringWithDeviceSystemVersion
{
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    return version;
}


/** 获取系统设备名字 */
+ (NSString *)stringWithDeviceName
{
   return [[UIDevice currentDevice] name];
    
}

+ (NSString *)stringWithDeviceModel
{
    return [[UIDevice currentDevice] model];
}

/** 获取系统语言 */
+ (NSString *)stringWithDeviceSystemLanguage
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    return currentLanguage;
}

#pragma mark -screen
/** 获取屏幕分辨率 */
+ (NSString *)stringWithScreenDisplay {
    
    CGFloat scale=[UIScreen mainScreen].scale;
    CGFloat displayWidth =scale*kScreenWidth;
    CGFloat displayHeight =scale *kScreenHeight;    
    return [NSString stringWithFormat:@"%.fx%.f",displayWidth,displayHeight];
}

/** 获取屏幕密度 */
+ (NSString *)stringWithScreenDensity {
    
    return [NSString stringWithFormat:@"%.f",[UIScreen mainScreen].scale];
}

/** 获取wifi物理地址 */
+ (NSString *)stringWithWiFiMac {
    
    NSString *ssid = @"Not Found";
    NSString *macIp = @"";
    CFArrayRef myArray =CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray,0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            ssid = [dict valueForKey:@"SSID"];           //WiFi名称
            macIp = [dict valueForKey:@"BSSID"];     //Mac地址
        }
    }
    
    return macIp;
}

/** 当前网络类型（wifi、wlan、其他） */
+ (NSString *)stringWithNetWorkType {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

/** 运营商类型（移动、电信、联通） */
+ (NSString *)stringWithCarrier
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
   
    NSLog(@"serviceSubscriberCellularProviders:%@",networkInfo.serviceSubscriberCellularProviders);

    
    NSLog(@"carrierName:%@",carrier.carrierName);
    NSLog(@"mobileCountryCode:%@",carrier.mobileCountryCode);
    NSLog(@"mobileNetworkCode:%@",carrier.mobileNetworkCode);
    NSLog(@"isoCountryCode:%@",carrier.isoCountryCode);
    NSLog(@"allowsVOIP:%d",carrier.allowsVOIP);

    return carrier.carrierName;
}

//+ (NSString *)stringWithCarrierDeprecated
//{
//
//    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
//
//    //serviceSubscriberCellularProviders null ???
//    NSLog(@"serviceSubscriberCellularProviders:%@",[networkInfo.serviceSubscriberCellularProviders allKeys]);
//
//    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
//    NSString *carrier_name = @"未知"; //网络运营商的名字
//
//    NSLog(@"carrierName:%@",carrier.carrierName);
//    NSString *code = [carrier mobileNetworkCode];
//
//    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
//        //移动 CMCC
//        carrier_name = @"中国移动";
//    }
//
//    if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"]||[code isEqualToString:@"11"]) {
//        // ret = @"电信"; CTCC
//        carrier_name = @"中国电信";
//    }
//
//    if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"]) {
//        // ret = @"联通"; CUCC
//        carrier_name = @"中国联通";
//    }
//
//    if ([code isEqualToString:@"20"]) {
//        // ret = @"联通"; CUCC
//        carrier_name = @"中国铁通";
//    }
//
//    return carrier_name;
//}

/** wifi是否可用 */
+ (BOOL)isWiFiAvailible {
    
    return YES;
}

/** 蓝牙是否可用 */
+ (BOOL)isBlueToothAvailible {
    
    return YES;
}

/** 重力感应是否可用 */
+ (BOOL)isGravityAvailible {
    
    return YES;
}


#pragma mark ---

+ (long)getTimeLong {
    
    long time = (long)([[NSDate date] timeIntervalSince1970] * 1000);
    return time;
}

//移动设备国家代码（Mobile Country Code，MCC）
//移动设备网络代码（英语：Mobile Network Code，MNC）
+ (NSString *)stringWithMCC_MNC
{
    
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    
    NSString *carrier_country_code = carrier.isoCountryCode;
    
    if (carrier_country_code == nil) {
        
        carrier_country_code = @"";
    }
    
    //国家编号
    
    NSString *CountryCode = carrier.mobileCountryCode;
    
    if (CountryCode == nil) {
        
        CountryCode = @"";
        
    }
    
    //网络供应商编码
    NSString *NetworkCode = carrier.mobileNetworkCode;

    if (NetworkCode == nil)

    {
        NetworkCode = @"";

    }

    NSString *mobile_country_code = [NSString stringWithFormat:@"%@%@",CountryCode,NetworkCode];

    if (mobile_country_code == nil)

    {
        mobile_country_code = @"";

    }
    
    return mobile_country_code;
    
}

@end

@implementation NSString (runtime)

NSString *NSStringFromObject(id object)
{
    return [NSString stringWithFormat:@"%@",object];
}

@end
