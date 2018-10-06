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

//delegate是可以用ratain的，只要在第三方中设置delegate就OK
@property(nonatomic,strong,nullable)id<bnPersonDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
