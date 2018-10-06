//
//  eQueue.h
//  Xcode8
//
//  Created by uBerning on 2017/3/14.
//  Copyright © 2017年 BN. All rights reserved.
//

#ifndef eQueue_h
#define eQueue_h


//    const char *（char const * ）  -->指向一个常量，常量内容不可修改，指针可修改  （指针常量）
//    char * const  -->常量指针，常量可修改，指针不可修改         （常量指针）i.e.常指针
//    const char * const    -->常量与指针，都不可修改
//    char const * const(同 const char * const）



/*
                char str[]="BNComeInNotification";
                char str1[]="BNComeInNotification1";

                const char * BNComeInNotification =str;
                NSLog(@"指针修改前:%s",BNComeInNotification);

                BNComeInNotification=str1;  //常量指针则不能修改
                NSLog(@"指针修改后:%s",BNComeInNotification);
=============================常量指针===============================
                char strr[]="BNGoOutNotification";

                char *const BNGoOutNotification=strr;
                NSLog(@"常量修改前:%s",BNGoOutNotification);

                BNGoOutNotification[0]='X';   //指针常量则不能修改
                BNGoOutNotification[1]='X';
                NSLog(@"常量修改后:%s",BNGoOutNotification);
*/

void dispatch_async(dispatch_queue_t queue, dispatch_block_t block);

//dispatch_function_t == typedef void (*dispatch_function_t)(void *_Nullable)
void dispatch_async_f(dispatch_queue_t queue, void *_Nullable context,dispatch_function_t wok);


void dispatch_sync(dispatch_queue_t queue, dispatch_block_t block);
void dispatch_sync_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);

//即将废掉
dispatch_queue_t dispatch_get_current_queue(void); macos(10.6,10.9), ios(4.0,6.0)

dispatch_queue_t dispatch_get_main_queue(void);
//identifier qos_class or priority
//flags  传除0外的值可能返回空
dispatch_queue_t dispatch_get_global_queue(long identifier,unsigned long flags );

#pragma mark--（1）创建队列方法
//new in iOS_10 & macOS_10.12
dispatch_queue_t dispatch_queue_create_with_target(const char *_Nullable label, dispatch_queue_attr_t _Nullable attr, dispatch_queue_t _Nullable target);

dispatch_queue_t dispatch_queue_create(const char *_Nullable label ,dispatch_queue_attr_t _Nullable attr);
#pragma mark--（2）延迟执行／栅栏／遍历函数
//1.schedule a block for execution on a  given queue at a specified time 延迟执行
void dispatch_after(dispatch_time_t when ,dispatch_queue_t queue, dispatch_block_t block);

void dispatch_after_f(dispatch_time_t when,dispatch_queue_t queue, void * _Nullable context, dispatch_function_t work);

//2.此函数必须要等前面内容执行完，才执行，后面的内容要等该函数执行完，才会执行
void dispatch_barrier_async(dispatch_queue_t queue, dispatch_block_t block );

void dispatch_barrier_async_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);


void dispatch_barrier_sync(dispatch_queue_t queue,dispatch_block_t block);

void dispatch_barrier_sync_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);

//3.遍历函数
void dispatch_apply(size_t iterations, dispatch_queue_t queue, void(^block)(size_t));
void dispatch_apply_f(size_t iterations, dispatch_queue_t queue, void *_Nullable context, void (*work)(void * _Nullable,size_t ));










#pragma mark--（3）以下三个方法返回一个串行，并行，或者NULL

//返回一个 非活跃属性 提供给  dispatch_queue_create()或者dispatch_queue_create_with_target()
//new in iOS_10 & macOS_10.12
dispatch_queue_attr_t dispatch_queue_attr_make_initially_inactive(dispatch_queue_attr_t _Nullable attr);
//new in iOS_10 & macOS_10.12
dispatch_queue_attr_t dispatch_queue_attr_make_with_autorelease_frequency(dispatch_queue_attr_t _Nullable attr, dispatch_autorelease_frequency_t frequency);
//new in ios_8  & macOS_10.10
dispatch_queue_attr_t dispatch_queue_attr_make_with_qos_class(dispatch_queue_attr_t _Nullable attr, dispatch_qos_class_t qos_class, int relative_priority);




#pragma mark--（4）设置获取队列的一些特性
//返回queue名称
const char *                  dispatch_queue_get_label(dispatch_queue_t queue);

//返回qos class 和相关优先级
dispatch_qos_class_t          dispatch_queue_get_qos_class(dispatch_queue_t queue,int * _Nullable relative_priority_ptr);



//为给定对象设置目标队列
void  dispatch_set_target_queue(dispatch_object_t obj,dispatch_queue_t _Nullable queue);

//执行已经提交到主队列上的block
void dispatch_main(void);



//Associates a subsystem-specific context with a dispatch queue, for a key unique to the subsystem.
void dispatch_queue_set_specific(dispatch_queue_t queue, const void *key, void *_Nullable context,dispatch_function_t work);

void *_Nullable dispatch_queue_get_specific(dispatch_queue_t queue, const void *key);

void *_Nullable dispatch_get_specific(const void *key);


//Verifies that the current block is executing on a given dispatch queue.检测任务（block是否在执行)
void dispatch_assert_queue(dispatch_queue_t queue);

void dispatch_assert_queue_barrier(dispatch_queue_t queue);

void dispatch_assert_queue_not(dispatch_queue_t queue);



#endif /* eQueue_h */
