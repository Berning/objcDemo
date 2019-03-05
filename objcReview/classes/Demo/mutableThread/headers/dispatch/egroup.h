//
//  group.h
//  Xcode8
//
//  Created by Berning on 2018/9/27.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef group_h
#define group_h


API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_MALLOC DISPATCH_RETURNS_RETAINED DISPATCH_WARN_RESULT
DISPATCH_NOTHROW

//1.create group
dispatch_group_t
dispatch_group_create(void);


//2.dispatch_group_async(_f)
#ifdef __BLOCKS__
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_async(dispatch_group_t group,
                     dispatch_queue_t queue,
                     dispatch_block_t block);
#endif /* __BLOCKS__ */


API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL1 DISPATCH_NONNULL2 DISPATCH_NONNULL4
DISPATCH_NOTHROW
void
dispatch_group_async_f(dispatch_group_t group,
                       dispatch_queue_t queue,
                       void *_Nullable context,
 
                       dispatch_function_t work)

//3.dispatch_group_notify(_f)  所有添加到group中的block都已完成，才会再添加此函数的block
#ifdef __BLOCKS__
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_notify(dispatch_group_t group,
                      dispatch_queue_t queue,
                      dispatch_block_t block);
#endif /* __BLOCKS__ */

API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL1 DISPATCH_NONNULL2 DISPATCH_NONNULL4
DISPATCH_NOTHROW
void
dispatch_group_notify_f(dispatch_group_t group,
                        dispatch_queue_t queue,
                        void *_Nullable context,
                        dispatch_function_t work);





//4.dispatch_group_wait
//Wait synchronously until all the blocks associated with a group have completed or until the specified timeout has elapsed.
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
long
dispatch_group_wait(dispatch_group_t group, dispatch_time_t timeout);


//5.dispatch_group_enter Manually indicate a block has entered the group
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_enter(dispatch_group_t group);

//6.dispatch_group_leave   Manually indicate a block in the group has completed
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_leave(dispatch_group_t group);

__END_DECLS

DISPATCH_ASSUME_NONNULL_END



#endif /* group_h */
