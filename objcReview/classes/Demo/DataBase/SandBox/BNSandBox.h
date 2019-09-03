//
//  BNSandBox.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>


//home                     //NSHomeDirectory() 根目录
//applications             //资源文件 ，可执行文件，app签名后不可更改

/*
    library:              //NSLibraryDirectory(5)
    1. caches（）          // NSCachesDirectory(13) 存放缓存数据（如图片，不重要的数据，icoud不备份,但比tmp文件下数据持久时间长）
    2. preferences        //NSUserDefaults 存取 iTunes备份
*/

//documents              //NSDocumentDirectory参数方式（9） 用于存储程序执行过程中产生的数据,itunes备份
//tmp                    //NSTemporaryDirectory()函数方法  存放临时文件，app退出后清除


@interface BNSandBox : NSObject

@property(nonatomic,class,readonly)void test;

+(void)pathForDirectoryInDomains;

@end
