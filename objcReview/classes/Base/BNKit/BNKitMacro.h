
//
//  BNKitMacro.h
//  objcDemo
//
//  Created by Berning on 2019/2/1.
//  Copyright © 2019年 Bien. All rights reserved.
//

#ifndef BNKitMacro_h
#define BNKitMacro_h

#define ckPresentDuration 0.35f
#define ckPushDutation 0.25f
#define ckNavigationBarHeight    64
#define ckNavBarHeight       44
#define ckApplicationStatusBarHeight 20


#define ckSreenBounds       [[UIScreen mainScreen] bounds]
#define ckMainScreenSize    ckSreenBounds.size
#define ckMainScreenWidth   ckMainScreenSize.width
#define ckMainScreenHeight  ckMainScreenSize.height

#define BNApplicationWindow [[UIApplication sharedApplication] delegate].window

#define BNNavigationBarColor   [UIColor colorWithRed:245/255.0 green:245/255.0 blue:247/255.0 alpha:1];

#endif /* BNKitMacro_h */
