//
//  UIImage+BN.h
//  SmartBand
//
//  Created by wangboning on 15/9/4.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BN)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
+(UIImage *)resizedImageWithImage:(UIImage *)image;

//image From Color
+ (instancetype)imageWithColor:(UIColor *)color;


/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;

/**
 裁剪头像（圆形）
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 截图
 */
+ (instancetype)captureInView:(UIView *)view;



@end
