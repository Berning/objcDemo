//
//  dispatchType.h
//  Xcode8
//
//  Created by Berning on 2018/9/25.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef dispatchType_h
#define dispatchType_h

dispatch_queue_t  //defined in queue.h a
//DISPATCH_DECL(dispatch_queue);

dispatch_queue_attr_t //defined in queue.h as
//DISPATCH_DECL(dispatch_queue_attr);

dispatch_block_t //defined in object.h as
//typedef void (^dispatch_block_t)(void);

dispatch_function_t  //defined in base.h as
//typedef void (*dispatch_function_t)(void *_Nullable);

dispatch_time_t;   //defined in time.h as
//typedef uint64_t dispatch_time_t;

dispatch_group_t   //defined in group.h
//DISPATCH_DECL(dispatch_group);

#endif /* dispatchType_h */
