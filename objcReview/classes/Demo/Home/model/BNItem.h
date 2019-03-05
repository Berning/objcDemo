//
//  BNItem.h
//  objcReview
//
//  Created by Berning on 2018/12/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNItem : NSObject

+ (instancetype)itemWithDictionary:(NSDictionary *)dict;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *image;



@end

NS_ASSUME_NONNULL_END
