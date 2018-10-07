//
//  fmessage.h
//  objcDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef fmessage_h
#define fmessage_h



#ifndef _OBJC_MESSAGE_H
#define _OBJC_MESSAGE_H

#include <objc/objc.h>
#include <objc/runtime.h>

#ifndef OBJC_SUPER
#define OBJC_SUPER

struct objc_super {
    __unsafe_unretained _Nonnull id receiver;
    
#if !defined(__cplusplus)  &&  !__OBJC2__
    __unsafe_unretained _Nonnull Class class;
#else
    __unsafe_unretained _Nonnull Class super_class;
#endif
};
#endif

#if !OBJC_OLD_DISPATCH_PROTOTYPES
void objc_msgSend(void /* id self, SEL op, ... */ )

void objc_msgSendSuper(void /* struct objc_super *super, SEL op, ... */ )

#else
id _Nullable objc_msgSend(id _Nullable self, SEL _Nonnull op, ...)
id _Nullable objc_msgSendSuper(struct objc_super * _Nonnull super, SEL _Nonnull op, ...)

#endif

#if !OBJC_OLD_DISPATCH_PROTOTYPES
void objc_msgSend_stret(void /* id self, SEL op, ... */ )

void objc_msgSendSuper_stret(void /* struct objc_super *super, SEL op, ... */ )
#else

void objc_msgSend_stret(id _Nullable self, SEL _Nonnull op, ...)
void objc_msgSendSuper_stret(struct objc_super * _Nonnull super,
                        SEL _Nonnull op, ...)
#endif



 
#if !OBJC_OLD_DISPATCH_PROTOTYPES

# if defined(__i386__)

void objc_msgSend_fpret(void /* id self, SEL op, ... */ )

# elif defined(__x86_64__)

void objc_msgSend_fpret(void /* id self, SEL op, ... */ )


void objc_msgSend_fp2ret(void /* id self, SEL op, ... */ )


# endif

#else

# if defined(__i386__)

double objc_msgSend_fpret(id _Nullable self, SEL _Nonnull op, ...)

# elif defined(__x86_64__)
long double objc_msgSend_fpret(id _Nullable self, SEL _Nonnull op, ...)

#  if __STDC_VERSION__ >= 199901L
_Complex long double objc_msgSend_fp2ret(id _Nullable self, SEL _Nonnull op, ...)

#  else
void objc_msgSend_fp2ret(id _Nullable self, SEL _Nonnull op, ...)

#  endif

# endif
#endif


#if !OBJC_OLD_DISPATCH_PROTOTYPES
void method_invoke(void /* id receiver, Method m, ... */ )
void method_invoke_stret(void /* id receiver, Method m, ... */ )

#else
id _Nullable method_invoke(id _Nullable receiver, Method _Nonnull m, ...)

void method_invoke_stret(id _Nullable receiver, Method _Nonnull m, ...)

#endif

#if !OBJC_OLD_DISPATCH_PROTOTYPES
void _objc_msgForward(void /* id receiver, SEL sel, ... */ )

void _objc_msgForward_stret(void /* id receiver, SEL sel, ... */ )
#else
id _Nullable _objc_msgForward(id _Nonnull receiver, SEL _Nonnull sel, ...)

void _objc_msgForward_stret(id _Nonnull receiver, SEL _Nonnull sel, ...)
#endif

typedef void* marg_list;

id _Nullable objc_msgSendv(id _Nullable self, SEL _Nonnull op, size_t arg_size, marg_list _Nonnull arg_frame)


void objc_msgSendv_stret(void * _Nonnull stretAddr, id _Nullable self,SEL _Nonnull op, size_t arg_size,
                    marg_list _Nullable arg_frame)


#if defined(__i386__)
double objc_msgSendv_fpret(id _Nullable self, SEL _Nonnull op,
                    unsigned arg_size, marg_list _Nullable arg_frame)
#endif


#if !__OBJC2__

#define marg_prearg_size    0

#define marg_malloc(margs, method) \
do { \
margs = (marg_list *)malloc (marg_prearg_size + ((7 + method_getSizeOfArguments(method)) & ~7)); \
} while (0)

#define marg_free(margs) \
do { \
free(margs); \
} while (0)

#define marg_adjustedOffset(method, offset) \
(marg_prearg_size + offset)

#define marg_getRef(margs, offset, type) \
( (type *)((char *)margs + marg_adjustedOffset(method,offset) ) )

#define marg_getValue(margs, offset, type) \
( *marg_getRef(margs, offset, type) )

#define marg_setValue(margs, offset, type, value) \
( marg_getValue(margs, offset, type) = (value) )

#endif

#endif


#endif /* fmessage_h */
