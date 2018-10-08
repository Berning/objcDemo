//
//  objcDefines.h
//  objcDemo
//
//  Created by Berning on 2018/10/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef objcDefines_h
#define objcDefines_h


//objc.h
#if !OBJC_TYPES_DEFINED
typedef struct objc_class *Class;
struct objc_object {
    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
};
typedef struct objc_object *id;
#endif
typedef struct objc_selector *SEL;  //where is objc_selector's struct
#if !OBJC_OLD_DISPATCH_PROTOTYPES
typedef void (*IMP)(void /* id, SEL, ... */ );
#else
typedef id _Nullable (*IMP)(id _Nonnull, SEL _Nonnull, ...);

//runtime.h
#if !OBJC_TYPES_DEFINED
typedef struct objc_method *Method;
typedef struct objc_ivar *Ivar;
typedef struct objc_category *Category;
typedef struct objc_property *objc_property_t; //where is objc_property's struct
struct objc_class {
    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
#if !__OBJC2__
    Class _Nullable super_class                              OBJC2_UNAVAILABLE;
    const char * _Nonnull name                               OBJC2_UNAVAILABLE;
    long version                                             OBJC2_UNAVAILABLE;
    long info                                                OBJC2_UNAVAILABLE;
    long instance_size                                       OBJC2_UNAVAILABLE;
    struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE;
    struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE;
    struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE;
    struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
#endif
} OBJC2_UNAVAILABLE;
/* Use `Class` instead of `struct objc_class *` */
#endif

#ifdef __OBJC__
@class Protocol;
#else
typedef struct objc_object Protocol;
#endif




#endif /* objcDefines_h */
