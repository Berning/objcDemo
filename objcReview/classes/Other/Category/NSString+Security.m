//
//  NSString+Security.m
//  objcReview
//
//  Created by aBerning on 2019/9/4.
//  Copyright © 2019 Bien. All rights reserved.
//
#import "NSString+Security.h"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
#define nullString   @""

@implementation NSString (base64)

+ (NSString *)base64StringWithString:(NSString *)string;
{
    if (string && ![string isEqualToString:nullString])
    {
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSString *str= [self base64EncodedStringFrom:data];
        if ([str containsString:@"="]) {
            str=[str stringByReplacingOccurrencesOfString:@"=" withString:nullString];
        }
        return str;
    }
    else
    {
        return nullString;
    }
}

+ (NSString *)stringWithBase64String:(NSString *)base64String
{
    if (base64String && ![base64String isEqualToString:nullString])
    {
        NSData *data = [self dataWithBase64EncodedString:base64String];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else
    {
        return nullString;
    }
}


/**
 Description 文本数据转换为base64格式字符串
 
 @param data 需要解密的数据
 @return    返回字符串
 */
+(NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return nullString;
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}


/**
 Description base64格式字符串转换为文本数据

 @param string 需要加密的字符串
 @return    加密成功的数据
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@"字符串不能为空"];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

@end


#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (BNDataEncryptionStandard)


+ (NSString *)DESStringWithString:(NSString *)string
{
    NSString *key = [[NSBundle mainBundle] bundleIdentifier];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    data = [self DESEncrypt:data WithKey:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithDESString:(NSString *)DESString
{
    NSString *key = [[NSBundle mainBundle] bundleIdentifier];
    NSData *data=[DESString dataUsingEncoding:NSUTF8StringEncoding];
    data =[self DESDecrypt:data WithKey:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

//DES加密 (文本不可过长)
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    

    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

////DES解密 (文本不可过长)
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

@end

#pragma mark -MD5
@implementation NSString (MD5)
static NSString *str1=@"2qruoaesjfh23*&*%(*Y*(%dfadfggasdjfadls;!$DASada#$%DASFA;dksajdasasd";
static NSString *str2=@"asdflkjklaj23082-dsa!daj3)fasdljfkaddjffahdalsgal\\as\dpajrsgkljaldd;";

//加盐

+ (NSString *)MD5WithComplexString:(NSString *)string
{
    return [self MD5WithComplexString:[NSString stringWithFormat:@"%@%@%@",str1,string,str2]];
}

//- (NSString *)MD5
+ (NSString *)MD5WithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];

    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);

    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

#pragma mark 使用SHA1加密字符串
+ (NSString *)SHA1WithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);

    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }

    return result;
}


@end
