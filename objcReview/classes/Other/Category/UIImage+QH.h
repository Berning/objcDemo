//
//  UIImage+QH.h
//  SmartBand
//
//  Created by wangboning on 15/9/4.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QH)
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

/**
 *  画头像
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//image From Color
+ (instancetype)imageWithColor:(UIColor *)color;


@end
