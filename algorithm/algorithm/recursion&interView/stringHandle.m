//
//  stringHandle.m
//  algorithm
//
//  Created by uBerning on 2017/3/12.
//  Copyright © 2017年 360. All rights reserved.
//

#import "stringHandle.h"

@implementation stringHandle

+(void)test
{
    stringHandle *obj=[self new];
    [obj bnRemoveRepeat1];
}

#pragma mark -分离字符串
-(void)bnSepatareString
{
    NSString * str1=[NSString stringWithFormat:@"%@",@"hello|world"];
    NSArray * array=[str1 componentsSeparatedByString:@"|"];
    for (NSString * temp in array)
    {
        NSLog(@"---->%@",temp);
    }
    
}

#pragma mark -移除重复字符串法一

-(void)bnRemoveRepeat
{
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"aabcadabcd"];
    
    NSMutableArray *rpArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < str.length - 1; i++)
    {
        for (int j = i + 1; j < str.length; j++)
        {
            if (([str characterAtIndex:i] ==[str characterAtIndex:j]) && (![rpArray containsObject:@(j)]))
                [rpArray addObject:@(j)];
        }
    }
    
    NSLog(@"rpArray:%@",rpArray);
    
    for (int i = (int)rpArray.count-1; i>=0;i--)
    {
        NSUInteger loc = [[rpArray objectAtIndex:i]intValue];
        [str deleteCharactersInRange:NSMakeRange(loc, 1)];
        NSLog(@"unrpStr:%@---%ld--%d",str,loc,i);

    }
    NSLog(@"unrpStr:%@",str);
    
}

#pragma  mark -移除重复字符法二

-(void)bnRemoveRepeat1
{
    NSMutableString *string = [[NSMutableString alloc]initWithFormat:@"aabcadabcd"];
    NSMutableArray *mArr = [[NSMutableArray alloc]init];
    for(int i = 0; i<string.length; i++)
    {
        [mArr addObject:[string substringWithRange:NSMakeRange(i,1)]];
    }
    //    NSLog(@"%@",mArr);
    [self removeRepeatElement:mArr];
    NSLog(@"%@",mArr);
}

//移除数组中重复元素
-(NSMutableArray *)removeRepeatElement:(NSMutableArray *)mArr

{
    NSLog(@"marr=%@",mArr);

    int count  = (int)mArr.count;
    for(int i = 0; i< count - 1 ;i++)
    {

        for(int j =i+1 ;j< count;j++)
        {
            NSString *a = [mArr objectAtIndex:i];
            NSString *b = [mArr objectAtIndex:j];
            
            if([a isEqualToString:b])
            {
                [mArr removeObjectAtIndex:j];
                count--;
            }
        }
    }

    return mArr;
}


@end
