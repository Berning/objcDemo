//
//  BNPthread.m
//  objcReview
//
//  Created by Berning on 2018/11/11.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNPthread.h"

@implementation BNPthread

+ (void)test
{
    
}

#ifdef _GNU_SOURCE

void *operate(void *param) {
    pthread_setname_np("my_thread");
    char thread_name[10];
    pthread_getname_np(pthread_self(), thread_name, 10);
    printf("an operation running in %s with param \"%s\"", thread_name, param);

    pthread_exit((void *)0);
}
#endif

+(void)pthreadTest
{
    pthread_t thread = NULL;
#ifdef _GNU_SOURCE

    pthread_create(&thread, NULL, operate, "my_param");
#endif

}


@end
