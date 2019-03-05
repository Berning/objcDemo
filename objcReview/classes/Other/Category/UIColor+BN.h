//
//  UIColor+BN.h
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (BN)

+ (UIColor *)navigationBarColor;

//UIColor
//+ (UIColor *)blackColor;      // 0.0 white
//+ (UIColor *)darkGrayColor;   // 0.333 white
//+ (UIColor *)lightGrayColor;  // 0.667 white
//+ (UIColor *)whiteColor;      // 1.0 white
//+ (UIColor *)grayColor;       // 0.5 white
//+ (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
//+ (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
//+ (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
//+ (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
//+ (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
//+ (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
//+ (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
//+ (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
//+ (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
//+ (UIColor *)clearColor;      // 0.0 white, 0.0 alpha

//UIInterface

//+ (UIColor *)lightTextColor __TVOS_PROHIBITED;                // for a dark background
//+ (UIColor *)darkTextColor __TVOS_PROHIBITED;                 // for a light background
//+ (UIColor *)groupTableViewBackgroundColor __TVOS_PROHIBITED;
//+ (UIColor *)viewFlipsideBackgroundColor NS_DEPRECATED_IOS(2_0, 7_0) __TVOS_PROHIBITED;
//+ (UIColor *)scrollViewTexturedBackgroundColor NS_DEPRECATED_IOS(3_2, 7_0) __TVOS_PROHIBITED;
//+ (UIColor *)underPageBackgroundColor NS_DEPRECATED_IOS(5_0, 7_0) __TVOS_PROHIBITED;

@end

NS_ASSUME_NONNULL_END
