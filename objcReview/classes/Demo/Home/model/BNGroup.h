//
//  BNGroup.h
//  objcReview
//
//  Created by Berning on 2018/12/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum:NSUInteger{
    BNGroupTypeObjc,
    BNGroupTypeC,
    BNGroupTypeWeb,
    BNGroupTypeAlgorithm,
} BNGroupType;

NS_ASSUME_NONNULL_BEGIN

@interface BNGroup : NSObject

+ (instancetype)groupWithTpye:(BNGroupType)type;


@property(nonatomic,strong)NSArray *items;

@property(nonatomic,copy)NSString *header;

@property(nonatomic,copy)NSString *footer;

@end

NS_ASSUME_NONNULL_END
