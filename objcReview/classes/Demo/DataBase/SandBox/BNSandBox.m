//
//  BNSandBox.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNSandBox.h"

@implementation BNSandBox

+(void)test
{
    [self pathForDirectoryInDomains];
}

+(void)pathForDirectoryInDomains
{
    
    NSLog(@"output1\n:username:%@\n fullname:%@\n homeForUser:%@\n openStep:%@",
          NSUserName(),
          NSFullUserName(),
          NSHomeDirectoryForUser(NSUserName()),
          NSOpenStepRootDirectory());
    // test on mobile
    //    output1:
    //    username:mobile
    //    fullname:mobile user
    //    homeForUser:/var/mobile/Containers/Data/Application/3221ED78-55FA-4DDF-9552-3539AAD0E352
    //    openStep:/
    
    
    NSLog(@"output2:%@",NSHomeDirectory());
    
    //    output2:/Users/berning/Library/Developer/CoreSimulator/Devices/07EE0F1E-7FA2-4D5D-BEB9-358714A3A43F/data/Containers/Data/Application/685C819A-713B-4639-A799-4BDFC28D9CB6
    // on mobile
    //output2:/var/mobile/Containers/Data/Application/3221ED78-55FA-4DDF-9552-3539AAD0E352
    
    NSArray *arr=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO);
    NSLog(@"output3:%@,%ld",arr,arr.count);
    
    //    output3:(
    //         "/Users/berning/Library/Developer/CoreSimulator/Devices/07EE0F1E-7FA2-4D5D-BEB9-358714A3A43F/data/Containers/Data/Application/685C819A-713B-4639-A799-4BDFC28D9CB6/Documents"
    //         ),1
    
    // on mobile
    //output3:("/var/mobile/Containers/Data/Application/3221ED78-55FA-4DDF-9552-3539AAD0E352/Documents"
    //),1
    
    
    NSLog(@"output4:%@",NSTemporaryDirectory());
    //    output4:/Users/berning/Library/Developer/CoreSimulator/Devices/07EE0F1E-7FA2-4D5D-BEB9-358714A3A43F/data/Containers/Data/Application/685C819A-713B-4639-A799-4BDFC28D9CB6/tmp/
    
    
}

-(void)searchPathMethodParagrams
{
    
    NSArray<NSString *>*NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory,NSSearchPathDomainMask mask,BOOL expandTilde);
#pragma  mark --directory
    //home=     /Users/berning/Library/Developer/CoreSimulator/Devices/07EE0F1E-7FA2-4D5D-BEB9-358714A3A43F/data/Containers/Data/Application/1ED9A10C-5AA8-47C3-8ECC-95B75A7EA761
    
    //NSApplicationDirectory=1             home/Applications
    //NSDemoApplicationDirectory=2         home/Applications/Demos
    //NSDeveloperApplicationDirectory=3    home/Developer/Applications
    //NSAdminApplicationDirectory=4        home/Applications/Utilities
    //NSLibraryDirectory=5                 home/library
    
    //NSDeveloperDirectory=6               home/Developer
    //NSUserDirectory=7                    nil  count==0
    //NSDocumentationDirectory=8           home/Library/Documentation
    //NSDocumentDirectory =9               home/Documents
    //NSCoreServiceDirectory=10            nil  count==0
    
    //NSAutosavedInformationDirectory=11   home/Library/Autosave Information
    //NSDesktopDirectory=12                home/Desktop
    //NSCachesDirectory=13                 home/Library/Caches
    //NSApplicationSupportDirectory=14      home/Library/Application Support
    //NSDownloadsDirectory=15               home/Downloads
    
    //NSInputMethodsDirectory=16            home/Library/Input Methods
    //NSMoviesDirectory=17                  home/Movies
    //NSMusicDirectory=18                   home/Music
    //NSPicturesDirectory=19                home/Pictures
    //NSPrinterDescriptionDirectory=20      nil  count==0
    
    //NSSharedPublicDirectory=21            home/Public
    //NSPreferencePanesDirectory=22         home/Library/PreferencePanes
    //NSApplicationScriptsDirectory=23         //only on OSX_10.8 above
    //NSItemReplacementDirectory=99         nil  count==0
    /*    NSAllApplicationsDirectory=100      home/Applications
                                             home/Applications/Utilities
                                             home/Developer/Applications
                                             home/Applications/Demos
     
         NSAllLibrariesDirectory=101           home/Library
                                               home/Developer
     
     */
    //NSTrashDirectory                      NS_ENUM_AVAILABLE(10_8, NA) = 102
    
    
#pragma  mark --domainMask
    
    //一般只用第一个
    //    NSUserDomainMask = 1,       // user's home directory --- place to install user's personal items (~)
    //    NSLocalDomainMask = 2,      // local to the current machine --- place to install items available to everyone on this machine (/Library)
    //    NSNetworkDomainMask = 4,    // publically available location in the local area network --- place to install items available on the network (/Network)
    //    NSSystemDomainMask = 8,     // provided by Apple, unmodifiable (/System)
    //    NSAllDomainsMask = 0x0ffff  // all domains: all of the above and future items
    
    
}

@end
