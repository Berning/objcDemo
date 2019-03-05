
#ifndef Header_h
#define Header_h

typedef struct objc_method *Method;
typedef struct objc_ivar *Ivar;
typedef struct objc_category *Category;
typedef struct objc_property *objc_property_t;

struct objc_class {
    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
    Class _Nullable super_class;
    const char * _Nonnull name;
    long version;
    long info;
    long instance_size;
    struct objc_ivar_list * _Nullable ivars;
    struct objc_method_list * _Nullable * _Nullable methodLists;
    struct objc_cache * _Nonnull cache;
    struct objc_protocol_list * _Nullable protocols;

    
} ;


#ifdef __OBJC__
@class Protocol;
#else
typedef struct objc_object Protocol;
#endif

struct objc_method_description {
    SEL _Nullable name;               /**< The name of the method */
    char * _Nullable types;           /**< The types of the method arguments */
};

typedef struct {
    const char * _Nonnull name;           /**< The name of the attribute */
    const char * _Nonnull value;          /**< The value of the attribute (usually empty) */
} objc_property_attribute_t;

//函数以 object ,objc,class ,ivar,method,property,protocal,sel 开头
//object_
id _Nullable object_copy(id _Nullable obj, size_t size)
id _Nullable object_dispose(id _Nullable obj)
Class _Nullable object_getClass(id _Nullable obj)
Class _Nullable object_setClass(id _Nullable obj, Class _Nonnull cls)
BOOL object_isClass(id _Nullable obj)

id _Nullable object_getIvar(id _Nullable obj, Ivar _Nonnull ivar)

void object_setIvar(id _Nullable obj, Ivar _Nonnull ivar, id _Nullable value)

void object_setIvarWithStrongDefault(id _Nullable obj, Ivar _Nonnull ivar,id _Nullable value)

Ivar _Nullable object_setInstanceVariable(id _Nullable obj, const char * _Nonnull name,

Ivar _Nullable object_setInstanceVariableWithStrongDefault(id _Nullable obj,const char * _Nonnull name,void * _Nullable value)
Ivar _Nullable object_getInstanceVariable(id _Nullable obj, const char * _Nonnull name,void * _Nullable * _Nullable outValue)

//objc_
Class _Nullable objc_getClass(const char * _Nonnull name)
Class _Nullable objc_getMetaClass(const char * _Nonnull name)
Class _Nullable objc_lookUpClass(const char * _Nonnull name)
Class _Nonnull objc_getRequiredClass(const char * _Nonnull name)
                                          
int objc_getClassList(Class _Nonnull * _Nullable buffer, int bufferCount)

Class _Nonnull * _Nullable objc_copyClassList(unsigned int * _Nullable outCount)
id _Nullable objc_constructInstance(Class _Nullable cls, void * _Nullable bytes)
void * _Nullable objc_destructInstance(id _Nullable obj)

Class _Nullable objc_allocateClassPair(Class _Nullable superclass, const char * _Nonnull name,size_textraBytes)
void objc_registerClassPair(Class _Nonnull cls)
Class _Nonnull objc_duplicateClass(Class _Nonnull original, const char * _Nonnull name,
                                 size_t extraBytes)
void objc_disposeClassPair(Class _Nonnull cls)


                                          
//class
const char * _Nonnull class_getName(Class _Nullable cls)
BOOL class_isMetaClass(Class _Nullable cls)
Class _Nullable class_getSuperclass(Class _Nullable cls)
Class _Nonnull class_setSuperclass(Class _Nonnull cls, Class _Nonnull newSuper)
int class_getVersion(Class _Nullable cls)
void class_setVersion(Class _Nullable cls, int version)
size_t class_getInstanceSize(Class _Nullable cls)
Ivar _Nullable class_getInstanceVariable(Class _Nullable cls, const char * _Nonnull name)
Ivar _Nullable class_getClassVariable(Class _Nullable cls, const char * _Nonnull name)
Ivar _Nonnull * _Nullable class_copyIvarList(Class _Nullable cls, unsigned int * _Nullable outCount)
Method _Nullable class_getInstanceMethod(Class _Nullable cls, SEL _Nonnull name)
Method _Nullable class_getClassMethod(Class _Nullable cls, SEL _Nonnull name)
IMP _Nullable class_getMethodImplementation(Class _Nullable cls, SEL _Nonnull name)
IMP _Nullable class_getMethodImplementation_stret(Class _Nullable cls, SEL _Nonnull name)
BOOL class_respondsToSelector(Class _Nullable cls, SEL _Nonnull sel)
Method _Nonnull * _Nullable class_copyMethodList(Class _Nullable cls, unsigned int * _Nullable outCount)
BOOL class_conformsToProtocol(Class _Nullable cls, Protocol * _Nullable protocol)
Protocol * __unsafe_unretained _Nonnull * _Nullable class_copyProtocolList(Class _Nullable cls, unsigned int * _Nullable outCount)
objc_property_t _Nullable class_getProperty(Class _Nullable cls, const char * _Nonnull name)
objc_property_t _Nonnull * _Nullable class_copyPropertyList(Class _Nullable cls, unsigned int * _Nullable outCount)
const uint8_t * _Nullable class_getIvarLayout(Class _Nullable cls)
const uint8_t * _Nullable class_getWeakIvarLayout(Class _Nullable cls)
BOOL class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,const char * _Nullable types)
IMP _Nullable class_replaceMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,const char * _Nullable types)
BOOL class_addIvar(Class _Nullable cls, const char * _Nonnull name, size_t size,uint8_t alignment, const char * _Nullable types)
BOOL class_addProtocol(Class _Nullable cls, Protocol * _Nonnull protocol)
BOOL class_addProperty(Class _Nullable cls, const char * _Nonnull name,const objc_property_attribute_t * _Nullable attributes,
                  unsigned int attributeCount)
void class_replaceProperty(Class _Nullable cls, const char * _Nonnull name,
                      const objc_property_attribute_t * _Nullable attributes,
                      unsigned int attributeCount)
void class_setIvarLayout(Class _Nullable cls, const uint8_t * _Nullable layout)
void class_setWeakIvarLayout(Class _Nullable cls, const uint8_t * _Nullable layout)
Class _Nonnullobjc_getFutureClass(const char * _Nonnull name)
id _Nullable class_createInstance(Class _Nullable cls, size_t extraBytes)
                                          
                                          
//method
SEL _Nonnull method_getName(Method _Nonnull m)
IMP _Nonnull method_getImplementation(Method _Nonnull m)
const char * _Nullable method_getTypeEncoding(Method _Nonnull m)
unsigned int method_getNumberOfArguments(Method _Nonnull m)
char * _Nonnull method_copyReturnType(Method _Nonnull m)
char * _Nullable method_copyArgumentType(Method _Nonnull m, unsigned int index)
void method_getReturnType(Method _Nonnull m, char * _Nonnull dst, size_t dst_len)
void method_getArgumentType(Method _Nonnull m, unsigned int index,
                       char * _Nullable dst, size_t dst_len)
struct objc_method_description * _Nonnull method_getDescription(Method _Nonnull m)
IMP _Nonnull method_setImplementation(Method _Nonnull m, IMP _Nonnull imp)
void method_exchangeImplementations(Method _Nonnull m1, Method _Nonnull m2)

//ivar
const char * _Nullable ivar_getName(Ivar _Nonnull v)
const char * _Nullable ivar_getTypeEncoding(Ivar _Nonnull v)
ptrdiff_t ivar_getOffset(Ivar _Nonnull v)

//property
const char * _Nonnull property_getName(objc_property_t _Nonnull property)
const char * _Nullable property_getAttributes(objc_property_t _Nonnull property)
objc_property_attribute_t * _Nullable property_copyAttributeList(objc_property_t _Nonnull property,
                           unsigned int * _Nullable outCount)
char * _Nullable property_copyAttributeValue(objc_property_t _Nonnull property,
                            const char * _Nonnull attributeName)
Protocol * _Nullable objc_getProtocol(const char * _Nonnull name)
Protocol * __unsafe_unretained _Nonnull * _Nullable objc_copyProtocolList(unsigned int * _Nullable outCount)

//protocol
BOOL protocol_conformsToProtocol(Protocol * _Nullable proto,Protocol * _Nullable other)
BOOL protocol_isEqual(Protocol * _Nullable proto, Protocol * _Nullable other)
const char * _Nonnull protocol_getName(Protocol * _Nonnull proto)

struct objc_method_description protocol_getMethodDescription(Protocol * _Nonnull proto, SEL _Nonnull aSel,
                              BOOL isRequiredMethod, BOOL isInstanceMethod)

struct objc_method_description * _Nullable protocol_copyMethodDescriptionList(Protocol * _Nonnull proto,
BOOL isRequiredMethod,BOOL isInstanceMethod,unsigned int * _Nullable outCount)

objc_property_t _Nullable protocol_getProperty(Protocol * _Nonnull proto,const char * _Nonnull name,
                     BOOL isRequiredProperty, BOOL isInstanceProperty)

objc_property_t _Nonnull * _Nullable protocol_copyPropertyList(Protocol * _Nonnull proto,
                          unsigned int * _Nullable outCount)

objc_property_t _Nonnull * _Nullable protocol_copyPropertyList2(Protocol * _Nonnull proto,
unsigned int * _Nullable outCount,BOOL isRequiredProperty, BOOL isInstanceProperty)

Protocol * __unsafe_unretained _Nonnull * _Nullable protocol_copyProtocolList(Protocol * _Nonnull proto,
                          unsigned int * _Nullable outCount)

Protocol * _Nullable objc_allocateProtocol(const char * _Nonnull name)

void objc_registerProtocol(Protocol * _Nonnull proto)

void protocol_addMethodDescription(Protocol * _Nonnull proto, SEL _Nonnull name,const char * _Nullable types, BOOL isRequiredMethod, BOOL isInstanceMethod)

void protocol_addProtocol(Protocol * _Nonnull proto, Protocol * _Nonnull addition)

void protocol_addProperty(Protocol * _Nonnull proto, const char * _Nonnull name,const objc_property_attribute_t * _Nullable attributes,unsigned int attributeCount,BOOL isRequiredProperty, BOOL isInstanceProperty)

const char * _Nonnull * _Nonnull objc_copyImageNames(unsigned int * _Nullable outCount)
const char * _Nullable class_getImageName(Class _Nullable cls)
const char * _Nonnull * _Nullable objc_copyClassNamesForImage(const char * _Nonnull image,
                            unsigned int * _Nullable outCount)
                                          
//sel
const char * _Nonnull sel_getName(SEL _Nonnull sel)

SEL _Nonnull sel_registerName(const char * _Nonnull str)

BOOL sel_isEqual(SEL _Nonnull lhs, SEL _Nonnull rhs)

void objc_enumerationMutation(id _Nonnull obj)

void objc_setEnumerationMutationHandler(void (*_Nullable handler)(id _Nonnull ))
void objc_setForwardHandler(void * _Nonnull fwd, void * _Nonnull fwd_stret)
IMP _Nonnull imp_implementationWithBlock(id _Nonnull block)
id _Nullable imp_getBlock(IMP _Nonnull anImp)
BOOL imp_removeBlock(IMP _Nonnull anImp)
id _Nullable objc_loadWeak(id _Nullable * _Nonnull location)
id _Nullable objc_storeWeak(id _Nullable * _Nonnull location, id _Nullable obj)

                                          
typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
    OBJC_ASSOCIATION_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
                                            *   The association is not made atomically. */
    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
                                            *   The association is not made atomically. */
    OBJC_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
                                            *   The association is made atomically. */
    OBJC_ASSOCIATION_COPY = 01403          /**< Specifies that the associated object is copied.
                                            *   The association is made atomically. */
};

void objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key,
                         id _Nullable value, objc_AssociationPolicy policy)
id _Nullable objc_getAssociatedObject(id _Nonnull object, const void * _Nonnull key)
void objc_removeAssociatedObjects(id _Nonnull object)
typedef BOOL (*objc_hook_getImageName)(Class _Nonnull cls, const char * _Nullable * _Nonnull outImageName);
void objc_setHook_getImageName(objc_hook_getImageName _Nonnull newValue,
                                           objc_hook_getImageName _Nullable * _Nonnull outOldValue)
        
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
struct objc_method_description_list {
    int count;
    struct objc_method_description list[1];
};

struct objc_protocol_list {
    struct objc_protocol_list * _Nullable next;
    long count;
    __unsafe_unretained Protocol * _Nullable list[1];
};

struct objc_ivar_list {
    int ivar_count;
#ifdef __LP64__
    int space;
#endif
  /* variable length structure */
    struct objc_ivar ivar_list[1];
    
};

struct objc_method_list {
    struct objc_method_list * _Nullable obsolete;
  
    int method_count;
#ifdef __LP64__
    int space;
#endif
  
    struct objc_method method_list[1];
    
};
                                          
                                          
                                          
                                          
struct objc_category {
    char * _Nonnull category_name;
    char * _Nonnull class_name;
    struct objc_method_list * _Nullable instance_methods;
    struct objc_method_list * _Nullable class_methods;
    struct objc_protocol_list * _Nullable protocols;
    
};
                                          
struct objc_ivar {
    char * _Nullable ivar_name;
    char * _Nullable ivar_type;
    int ivar_offset;
#ifdef __LP64__
    int space;
#endif
};

struct objc_method {
    SEL _Nonnull method_name;
    char * _Nullable method_types;
    IMP _Nonnull method_imp;
    
};


typedef struct objc_symtab *Symtab;

struct objc_symtab {
    unsigned long sel_ref_cnt;
    SEL _Nonnull * _Nullable;
    unsigned short;
    unsigned short;
    void * _Nullable defs[1];
};


typedef struct objc_cache *Cache;

struct objc_cache {
    unsigned int mask ;
    unsigned int occupied;
    Method _Nullable buckets[1];
};

typedef struct objc_module *Module;

struct objc_module {
    unsigned long version;
    unsigned long size;
    const char * _Nullable name;
    Symtab _Nullable symtab;
};

struct objc_method_list;

#endif

#endif /* Header_h */
