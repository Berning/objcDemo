//
//  BNDog.h
//  Xcode8
//
//  Created by uBerning on 2017/3/22.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BNBall;

@interface BNDog : NSObject<NSCoding>

@property(nonatomic,strong)NSArray *dogs;

@property(nonatomic,assign)int age ;

@property(nonatomic,assign)float weight;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *dogType;

@property(nonatomic,weak)UIColor *dogColor;

@property(nonatomic,assign,getter=isRipped)BOOL ripe;

@property(nonatomic,strong)BNBall *ball;


-(void)run;

-(void)walk;

-(id)eat;




@end
