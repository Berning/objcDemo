//
//  NSString+Security.h
//  objcReview
//
//  Created by aBerning on 2019/9/4.
//  Copyright © 2019 Bien. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//Base64
@interface NSString (BNDataBase64Encoding)

//base64加密
+ (NSString *)base64StringWithString:(NSString *)string;

//base64解密
+ (NSString *)stringWithBase64String:(NSString *)base64String;

@end


//DES
@interface NSString (BNDataEncryptionStandard)

+ (NSString *)DESStringWithString:(NSString *)string;

+ (NSString *)stringWithDESString:(NSString *)DESString;

@end


//MD5(Message Digest Algorithm )

@interface NSString (MD5)

//不可逆；相同字符串加密的结果相同；加盐解决；
+ (NSString *)MD5WithString:(NSString *)string;

+ (NSString *)MD5WithComplexString:(NSString *)string;

+ (NSString *)SHA1WithString:(NSString *)string;
@end




NS_ASSUME_NONNULL_END
