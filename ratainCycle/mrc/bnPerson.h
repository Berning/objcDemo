//
//  bnPerson.h
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol bnPersonDelegate <NSObject>


@end
@interface bnPerson : NSObject

//必须为weak,strong需要dealloc 手动self.delegate=nil
@property(nonatomic,weak,nullable)id<bnPersonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
