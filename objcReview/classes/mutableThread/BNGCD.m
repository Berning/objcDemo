//
//  BNGCD.m
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNGCD.h"

@implementation BNGCD

-(void)testSingle
{
    NSLog(@"singleton");
}
+(void)test
{
    
    [self onceAndApply:1];
}
/*
GCD 中的队列是用来放置需要执行的任务的，任务的取出遵循队列的先进先出的原则。
GCD 将队列中的任务取出，并放置到对应的线程中执行。

串行队列，同一时刻只有一个任务在执行，后面的任务需要等待正在执行的任务结束，才能执行。
并行队列，同一时刻可以有多个任务在执行，后面的任务不需等待，只要有可以执行任务的线程，就可以执行。其中，执行任务的线程数量取决于当前系统的状态，包括处理数、CPU核数、CPU负荷等系统状态。

 同步派发 VS 异步派发
派发指的是将任务追加到指定的队列中，等待 GCD 取出执行。
同步派发 dispatch_sync，一个任务的追加会等待当前任务执行完，再进行。同步，保证了任务执行的顺序。
异步派发 dispatch_async，一个任务的追加不等待当前任务执行完，直接追加在队列中。因为任务的追加不等待，直接追加，也就需要 GCD 为其开启新线程来执行操作。
*/
// 同步函数,会等block执行完毕, 才会执行后面的代码
+ (void)syncWithSerial
{
    // 1.创建一个串行队列
    // #define DISPATCH_QUEUE_SERIAL NULL
    // 所以可以直接传NULL
    dispatch_queue_t queue = dispatch_queue_create("com.520it.lnj", DISPATCH_QUEUE_CONCURRENT);
    
    // 2.将任务添加到队列中
    dispatch_sync(queue, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    NSLog(@"任务1完毕");

    dispatch_sync(queue, ^{
        NSLog(@"任务2  == %@", [NSThread currentThread]);
    });
    NSLog(@"任务2完毕");

    dispatch_sync(queue, ^{
        NSLog(@"任务3  == %@", [NSThread currentThread]);
    });
    NSLog(@"任务3完毕");

    
}

#pragma mark 特殊情况

//如果是在主线程中调用同步函数 + 主队列, 那么会导致死锁
//导致死锁的原因:
//sync函数是在主线程中执行的, 并且会等待block执行完毕.---- 先调用
//block是添加到主队列的, 也需要在主线程中执行. -----后调用

+(void)syncWithMain
{
    NSLog(@"begin:\n");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //  同步函数,会等同步函数中的block执行完毕, 才会执行后面的代码,但由于主队列上的任务是顺序执行的，block内容（即新添加到mianqueue的任务）在主队列后面，需要等待主队列前面的任务执行完才能执行；然而，又由于sync的缘故，后面的任务又要等待blockn内容（新添加到主队列的任务）执行完才能继续执行。故而造成互相等待的现象（死锁）
    // 注意: 如果dispatch_sync方法是在主线程中调用的, 并且传入的队列是主队列, 那么会导致死锁
    dispatch_sync(queue, ^{
        NSLog(@"block内容");
    });
    NSLog(@"end");
}




+(void)syncWithConcurrent
{
        // 1.创建一个并发队列
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        
        // 2.将任务添加到队列中
        dispatch_sync(queue, ^{
            NSLog(@"任务1  == %@", [NSThread currentThread]);
        });
    
        NSLog(@"任务1完毕");

        dispatch_sync(queue, ^{
            NSLog(@"任务2  == %@", [NSThread currentThread]);
        });
    
        NSLog(@"任务2完毕");

        dispatch_sync(queue, ^{
            NSLog(@"任务3  == %@", [NSThread currentThread]);
        });
    
        NSLog(@"任务3完毕");

}



+(void)asyncWithSerial
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.520it.lnj", DISPATCH_QUEUE_SERIAL);
    /*
     能够创建新线程的原因:
     我们是使用"异步"函数调用
     只创建1个子线程的原因:
     我们的队列是串行队列
     */
    // 2.将任务添加到队列中
    dispatch_async(queue, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    NSLog(@"任务1完毕  == %@", [NSThread currentThread]);

    dispatch_async(queue, ^{
        NSLog(@"任务2  == %@", [NSThread currentThread]);
    });
    NSLog(@"任务2完毕  == %@", [NSThread currentThread]);

    dispatch_async(queue, ^{
        NSLog(@"任务3  == %@", [NSThread currentThread]);
    });
    
    NSLog(@"任务3完毕  == %@", [NSThread currentThread]);
}

/*
 2018-09-23 23:45:36.469292+0800 Xcode8[7529:2374222] 任务1完毕  == <NSThread: 0x1c0072740>{number = 1, name = main}
 2018-09-23 23:45:36.469364+0800 Xcode8[7529:2374222] 任务2完毕  == <NSThread: 0x1c0072740>{number = 1, name = main}
 2018-09-23 23:45:36.469374+0800 Xcode8[7529:2374248] 任务1  == <NSThread: 0x1c046d480>{number = 3, name = (null)}
 2018-09-23 23:45:36.469391+0800 Xcode8[7529:2374222] 任务3完毕  == <NSThread: 0x1c0072740>{number = 1, name = main}
 2018-09-23 23:45:36.469409+0800 Xcode8[7529:2374248] 任务2  == <NSThread: 0x1c046d480>{number = 3, name = (null)}
 2018-09-23 23:45:36.469434+0800 Xcode8[7529:2374248] 任务3  == <NSThread: 0x1c046d480>{number = 3, name = (null)}
*/

#pragma mark 特殊情况
//异步 + 主队列 : 不会创建新的线程, 并且任务是在主线程中执行
+(void)asyncWithMain
{
    // 主队列:
    // 特点: 只要将任务添加到主队列中, 那么任务"一定"会在主线程中执行 \
    无论你是调用同步函数还是异步函数
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"任务完成---%@",[NSThread currentThread]);
}


+(void)asyncWithConcurrent
{
    /*
     执行任务
     dispatch_async
     dispatch_sync
     */
    
    /*
     第一个参数: 队列的名称
     第二个参数: 告诉系统需要创建一个并发队列还是串行队列
     DISPATCH_QUEUE_SERIAL :串行
     DISPATCH_QUEUE_CONCURRENT　并发
     */
    //    dispatch_queue_t queue = dispatch_queue_create("com.520it.lnj", DISPATCH_QUEUE_CONCURRENT);
    
    // 系统内部已经给我们提供好了一个现成的并发队列
    /*
     第一个参数: iOS8以前是优先级, iOS8以后是服务质量
     iOS8以前
     *  - DISPATCH_QUEUE_PRIORITY_HIGH          高优先级 2
     *  - DISPATCH_QUEUE_PRIORITY_DEFAULT:      默认的优先级 0
     *  - DISPATCH_QUEUE_PRIORITY_LOW:          低优先级 -2
     *  - DISPATCH_QUEUE_PRIORITY_BACKGROUND:
     
     iOS8以后
     *  - QOS_CLASS_USER_INTERACTIVE  0x21 用户交互(用户迫切想执行任务)
     *  - QOS_CLASS_USER_INITIATED    0x19 用户需要
     *  - QOS_CLASS_DEFAULT           0x15 默认
     *  - QOS_CLASS_UTILITY           0x11 工具(低优先级, 苹果推荐将耗时操作放到这种类型的队列中)
     *  - QOS_CLASS_BACKGROUND        0x09 后台
     *  - QOS_CLASS_UNSPECIFIED       0x00 没有设置
     
     第二个参数: 废物
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    /*
     第一个参数: 用于存放任务的队列
     第二个参数: 任务(block)
     
     GCD从队列中取出任务, 遵循FIFO原则 , 先进先出
     输出的结果和苹果所说的原则不符合的原因: CPU可能会先调度其它的线程
     
     能够创建新线程的原因:
     我们是使用"异步"函数调用
     能够创建多个子线程的原因:
     我们的队列是并发队列
     */
    dispatch_async(queue, ^{
        for (int i=0; i<10; i++) {
            NSLog(@"任务1  == %@", [NSThread currentThread]);
        }
    });
    NSLog(@"任务1完毕---%@",[NSThread currentThread]);

    dispatch_async(queue, ^{
        for (int i=0; i<10; i++) {
            NSLog(@"任务2  == %@", [NSThread currentThread]);
        }
    });
    NSLog(@"任务2完毕---%@",[NSThread currentThread]);


}



#pragma 嵌套
/*
 如果是在子线程中调用 同步函数 + 主队列, 那么没有任何问题
 */

+(void)syncInAsync:(UIView *)view
{
   
    UIImageView *imgView=[[UIImageView alloc ] initWithFrame:CGRectMake(20, 114,  100, 100)];
    imgView.backgroundColor=[UIColor cyanColor];
    [view addSubview:imgView];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 2.调用异步函数
    dispatch_async(queue, ^{
        // 1.下载图片
        NSURL *url = [NSURL URLWithString:@"https://wx2.sinaimg.cn/mw690/624d98e1ly1fdmcckuhkcj20en081aaf.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 2.将二进制转换为图片
        UIImage *image = [UIImage imageWithData:data];
        
        // 3.回到主线程更新UI
        //        self.imageView.image = image;
        /*
         技巧:
         如果想等UI更新完毕再执行后面的代码, 那么使用同步函数
         如果不想等UI更新完毕就需要执行后面的代码, 那么使用异步函数
         */
        
        NSLog( @"thread:%@",[NSThread currentThread]);
        dispatch_sync(dispatch_get_main_queue(), ^{ // 会等block代码执行完毕后，执行后面最后一句的打印代码
            imgView.image = image;
            NSLog( @"thread:%@",[NSThread currentThread]);
            
        });
        NSLog(@"设置图片完毕 %@", image);
    });

}

+(void)timeDelay:(int)option
{
    [[self new] delayFunction:option];
}
-(void)delayFunction:(int)option
{
    switch (option) {
        case 0:
        {  
            NSLog(@"start...");
             

            
            NSLog(@"NSEC_PER_SEC:%llu",NSEC_PER_SEC);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"welcome GCD delay");
                NSLog(@"thread:%@",[NSThread currentThread]);
            });
        
        }
            break;
        case 1:
        {
            NSLog(@"start...");
            [NSThread sleepForTimeInterval:3];
            NSLog(@"welcome NSThread delay");
            NSLog(@"thread:%@",[NSThread currentThread]);

        }
            
            break;
        case 2:
        {
            NSLog(@"start...");
            [self performSelector:@selector(run) withObject:self afterDelay:3]; //NSObject(NSDelayedPerforming) in NSRunLoop

        }
            break;
        case 3:
        {
            NSLog(@"start...");
            [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
                NSLog(@"welcome NSTimer delay");
                NSLog(@"thread:%@",[NSThread currentThread]);


            }];
        }
            
            break;

            
        default:
            break;
    }
    
}

-(void)run
{
    NSLog(@"welcome NSObject(RunLoop) delay");
    NSLog(@"thread:%@",[NSThread currentThread]);

}


+(void)onceAndApply:(int)option
{
    if (option==0) {
        static int a=0;
        int  b=100;
        for(int i=0;i<10;i++){
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                a+=3;
            });
            
            b-=4;
        }
        
        NSLog(@"a==%d,b==%d",a,b);
    }
    else if(1==option)
    {
        
        //index顺序不确定 e.g. index output:0134526789
        dispatch_apply(10, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^(size_t index) {
            NSLog(@"applyTest:%zu",index);
        });
        
        
//        NSString *sourcePath = @"/Users/berning/btest/Xcode8/原始文件";
//        NSString *destPath = @"/Users/berning/btest/Xcode8/目标文件";
//        // 2.取出原始文件夹中所有的文件
//        NSFileManager *manager = [NSFileManager defaultManager];
//        
//        
//        //subpathsAtPath遍历给定路径的文件，并返回一个与给定路径反转的过的数组
//        NSArray *files = [manager subpathsAtPath:sourcePath];
//        NSLog(@"output:%@\n%@\n%@",manager,sourcePath,files);
//
//        //    NSLog(@"%@", files);
//        // 3.开始拷贝文件
//        /*
//         for (NSString *fileName in files) {
//         // 3.1生产原始文件的绝对路径
//         NSString *sourceFilePath = [sourcePath stringByAppendingPathComponent:fileName];
//         // 3.2生产目标文件的绝对路径
//         NSString *destFilePath = [destPath stringByAppendingPathComponent:fileName];
//         //        NSLog(@"%@", sourceFilePath);
//         //        NSLog(@"%@", destFilePath);
//         // 3.3利用NSFileManager拷贝文件
//         [manager moveItemAtPath:sourceFilePath toPath:destFilePath error:nil];
//         }
//         */
//        dispatch_apply(files.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
//            NSString *fileName = files[index];
//
//            // 3.1生产原始文件的绝对路径
//            NSString *sourceFilePath = [sourcePath stringByAppendingPathComponent:fileName];
//            // 3.2生产目标文件的绝对路径
//            NSString *destFilePath = [destPath stringByAppendingPathComponent:fileName];
////            NSLog(@"source:%@", sourceFilePath);
////            NSLog(@"destination:%@", destFilePath);
//            // 3.3利用NSFileManager拷贝文件
//            [manager moveItemAtPath:sourceFilePath toPath:destFilePath error:NULL];
//        });
        
    }
    else
    {
        NSLog(@"option error");
    }


}


+(void)barrierAsync:(UIView *)view
{
    UIImageView *imgView=[[UIImageView alloc ] initWithFrame:CGRectMake(20, 114,  300, 100)];
    imgView.backgroundColor=[UIColor cyanColor];
    [view addSubview:imgView];

    
    dispatch_queue_t queue = dispatch_queue_create("com.bn.www", DISPATCH_QUEUE_CONCURRENT);
    
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    // 1.开启一个新的线程下载第一张图片
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://img.alicdn.com/tps/i1/TB1AE.sFVXXXXaCXFXXwu0bFXXX.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image1 = image;
        NSLog(@"图片1下载完毕");
    });
    // 2.开启一个新的线程下载第二张图片
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image2 = image;
        NSLog(@"图片2下载完毕");
    });
    
    // 3.开启一个新的线程, 合成图片
    // 栅栏
    dispatch_barrier_async(queue, ^{
        // 图片下载完毕
        NSLog(@"\n%@ :%f\n%@:%f", image1,image1.scale, image2,image2.scale);
        
        // 1.开启图片上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        // 2.画图
        [image1 drawInRect:CGRectMake(0, 0, 100, 200)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 200)];
        // 3.从上下文中获取绘制好的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSLog(@"currentThread:%@", [NSThread currentThread]);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            imgView.image = newImage;
            // 将合并后的图片写到本地桌面：
            [UIImagePNGRepresentation(newImage) writeToFile:@"/Users/berning/btest／Xcode8/123.png" atomically:YES];
        });
        
        NSLog(@"barrier执行完毕");
    });
    
    
//    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
//    
//    //    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);   //不能是global queue
    
    
//    dispatch_async(queue, ^{
//        for (int  i=0; i<100; i++) {
//            
//            NSLog(@"----1-----%@", [NSThread currentThread]);
//        }
//    });
//    
//    
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"----barrier-----%@", [NSThread currentThread]);
//    });
//    
//    dispatch_async(queue, ^{
//        {
//            for (int  i=0; i<10; i++) {
//                
//                NSLog(@"----3-----%@", [NSThread currentThread]);
//            }
//        }
//    });

    
}



+(void)groupAsync:(UIView *)view
{
//    创建
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    dispatch_group_t group=dispatch_group_create();
    __block UIImage *image1=nil;
    __block UIImage *image2=nil;
    
    UIImageView *imgView=[[UIImageView alloc ] initWithFrame:CGRectMake(20, 114,  300, 300)];
    imgView.backgroundColor=[UIColor cyanColor];
    [view addSubview:imgView];
    
    //开线程，瞎子图片
    
    dispatch_group_async(group, queue, ^{
        image1=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://wx1.sinaimg.cn/mw690/68774058gy1fdmqamlpu3j20hs0hsdi3.jpg"]]];
        NSLog(@"image1完毕:%@",image1);
    });
    
    
    dispatch_group_async(group, queue, ^{
       
        image2=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://wx2.sinaimg.cn/mw690/68774058gy1fdmqb6xf44j20yi16d45t.jpg"]]];
        NSLog(@"image2完毕:%@",image2);

    });

    
    //上面两张图片全部下载完，才执行
    dispatch_group_notify(group, queue, ^{
        //合成图片
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];;
        
        UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        //更新UI
    
        dispatch_async(dispatch_get_main_queue(), ^{
            imgView.image=newImage;
            
            [UIImagePNGRepresentation(newImage) writeToFile:@"/Users/berning/btest／Xcode8/123.png" atomically:YES];
        });
        
        NSLog(@"更新完毕");
    });
    
}

SingletonM(Med)

+(instancetype)shareData
{
    static id data;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        data= [BNGCD new];
    });
    
    return data;
}


+(void)GCDTest
{
    //
//    dispatch_queue_t sQueue=dispatch_queue_create("com.bn.gcd",DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t cQueue=dispatch_queue_create("com.bn.concurrent",DISPATCH_QUEUE_CONCURRENT);
//    
//    //
//    dispatch_queue_t mainQ=dispatch_get_main_queue();
//    dispatch_queue_t globalQ=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 );
    

    
}


@end


@implementation BNBlock

+(void)test
{
    BNBlock *obj=[BNBlock new];
    NSLog(@"obj:%@",obj);
    __weak __typeof(obj) weakObj=obj;
    [obj setCompletion:^(id object) {
        weakObj.name=@"wbn";
        NSLog(@"complete:%@",weakObj.name);
        
//        obj.name=@"wbn";
        NSLog(@"complete:%@",object);
    }];
    
    //即使不调用block，还是会引起内存泄漏
    obj.completion(@"我是block参数");
    
    
//    =======================
    
    void (^block)(void)=^{};
    obj.block1=^{};
    
    NSLog(@"block:%@\n%@",block,obj.block1);
    NSLog(@"=====================================separator===============================================");

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"name"]=@"wbn";
    dict[@"age"]=@"20";
    dict[@"sex"]=@"man";
    
    [self testBlock:dict success:^(id obj) {
        NSLog(@"success:%@",obj);
        
    } failure:^(NSError *error) {
        NSLog(@"error:%ld:%@",error.code,error.domain);
        
    }];
    
    NSLog(@"=====================================separator===============================================");

    [self testBlock:@"123ddd" success:^(id obj) {
        NSLog(@"success:%@",obj);
        
    } failure:^(NSError *error) {
        NSLog(@"error:%ld:%@",error.code,error.domain);
        
    }];
    
    

    
    
}

-(void)dealloc
{
    
    NSLog(@"%@释放了",self);
    //ARC不能调用
    //    [super dealloc];
}



+(void)testBlock:(id)object success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure
{
    
    NSLog(@"s:%@",success);
    
    NSLog(@"f:%@\n%@",object,failure);
    
    if ([object isKindOfClass:[NSDictionary class]])
    {
        if (success) {
            //        NSLog(@"s:%@\n%@",str,success);
            object[@"height"]=@"180";
            success(object);
        }

    }
    else
    {
        if(failure)
        {
            //        NSLog(@"f:%@\n%@",str,failure);
            NSString *str=@"object is not a dictionary";
            NSError *aError=[NSError errorWithDomain:str code:404 userInfo:nil];
            failure(aError);
        }

    }
    
}




@end

