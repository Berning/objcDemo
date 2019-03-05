//
//  performMethod.h
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#ifndef performMethod_h
#define performMethod_h



//NSObject (NSThreadPerformAdditions)

[self performSelectorInBackground:nil withObject:nil];

[self performSelector:nil onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES modes:@[@"b",@"c" ]];
[self performSelector:nil onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES ];

[self performSelectorOnMainThread:nil withObject:nil waitUntilDone:YES modes:@[@"b",@"c" ]];
[self performSelectorOnMainThread:nil withObject:nil waitUntilDone:YES];

//NSObject (NSDelayedPerforming)

[self performSelector:nil withObject:nil afterDelay:1];
[self performSelector:nil withObject:nil afterDelay:1 inModes:nil];

//object代理方法
[self performSelector:nil];
[self performSelector:nil withObject:nil];
[self performSelector:nil withObject:nil withObject:nil];

//viewController方法
[self performSegueWithIdentifier:<#(nonnull NSString *)#> sender:<#(nullable id)#>]




#endif /* performMethod_h */
