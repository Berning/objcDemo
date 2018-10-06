//
//  BNSingleton.m
//  Xcode8
//
//  Created by uBerning on 2017/3/12.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNSingleton.h"

@implementation BNSingleton

static  BNSingleton *_data=nil;
+(id)allocWithZone:(struct _NSZone *)zone
{
    if (!_data) {
        
        //        static dispatch_once_t onceToken;
        //        dispatch_once(&onceToken, ^{
        //            _data=[super allocWithZone:zone];
        //
        //        });
        
        @synchronized(self){
            _data=[super allocWithZone:zone];
        }
    }
    return _data;
}

-(id)init
{
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        _data =[super init];
    //    });
    
    @synchronized(self){
        _data=[super init];
    }
    return _data;
}

+(instancetype)shareData
{
    return [[self alloc]init];
    
}

+(id)copyWithZone:(struct _NSZone *)zone{
    return _data;
}
+(id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _data;
}


#if !__has_feature(objc_arc)
-(id)retain{
    return self ;
}

-(NSUInteger)retainCount{
    return 1;
}

-(oneway void)release{}

#endif


@end
