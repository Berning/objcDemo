//
//  BNVidio.h
//  objcReview
//
//  Created by aBerning on 2019/9/14.
//  Copyright © 2019 Bien. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNVidio : NSObject

@property(copy,nonatomic )NSString *videoId;

@property(copy,nonatomic )NSString *name;
@property(copy,nonatomic )NSString *length;
@property(copy,nonatomic )NSString *videoURL;
@property(copy,nonatomic )NSString *imageURL;
@property(copy,nonatomic )NSString *descs;

@property(copy,nonatomic )NSString *teacher;

@property (nonatomic, strong) UIImage *image;


@end

NS_ASSUME_NONNULL_END
