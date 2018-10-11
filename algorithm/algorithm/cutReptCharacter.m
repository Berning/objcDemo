//
//  cutReptCharacter.m
//  algorithm
//
//  Created by uBerning on 2017/3/12.
//  Copyright © 2017年 360. All rights reserved.
//

#import "cutReptCharacter.h"

@implementation cutReptCharacter

-(void)mySort:(NSMutableArray *)mutArray {
    id tmpObj = nil;
    unsigned long flag = mutArray.count-1;//flag :最大脚标 while (flag > 0) {
    int k = flag;
    flag = 0;
    for (int j = 0 ; j < k ; j++) {
        int order = NSOrderedAscending;// 或 NSOrderedDescending
        if ([[mutArray[j] description] compare:[mutArray[j+1] description]] == -order) {
            tmpObj = mutArray[j];
            mutArray[j] = mutArray[j+1];
            mutArray[j+1] = tmpObj;
            flag = j;
        } }
    NSLog(@"%@",mutArray);
    NSLog(@"%@",[mutArray[2] description]);
}


- (void)mySort2:(NSArray *)oldArray {
    NSMutableArray * newArray=[NSMutableArray arrayWithArray:oldArray];
    NSInteger num=[oldArray count];
    for(int i = 0 ; i < num ; i++)
    {
        for(int j=0; j<num-1-i; j++) {
            int num1 = [[newArray objectAtIndex: j] intValue];
            int num2 = [[newArray objectAtIndex: j+1] intValue];
            
            if(num1 >num2) {
                [newArray replaceObjectAtIndex: j withObject:[NSString stringWithFormat:@"%d",num2]];
                [newArray replaceObjectAtIndex: j+1 withObject:[NSString stringWithFormat:@"%d",num1]];
            }
        }
    }
    NSLog(@"%@",oldArray);
    
    NSLog(@"%@",newArray);
    
    //    return newArray;
}

#pragma mark -分离字符串
-(void)sepatareString
{
    NSString * str1=[NSString stringWithFormat:@"%@",@"hello|world"];
    NSArray * array=[str1 componentsSeparatedByString:@"|"];
    for (NSString * temp in array)
    {
        NSLog(@"---->%@",temp);
    }
    
}

#pragma mark -移除重复字符串法一

-(void)removeRepeat
{
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"aabcadabcd"];
    
    
    NSMutableArray *marry = [[NSMutableArray alloc]init];
    for (int i = 0; i < str.length - 1; i++) {
        unsigned char a = [str characterAtIndex:i];
        for (int j = i + 1; j < str.length; j++) {
            unsigned char b = [str characterAtIndex:j];
            if (a == b) {
                if (j == i + 1) {
                    
                }else{
                    
                    [marry addObject:[NSString stringWithFormat:@"%d",j]];
                }
            }
        }
    }
    for (int i = marry.count - 1; i > 0; i--) {
        
        NSInteger num = [[marry objectAtIndex:i]intValue];
        [str deleteCharactersInRange:NSMakeRange(num, 1)];
        
    }
    NSLog(@"%@",str);
    
}

#pragma  mark -移除重复字符法二

-(void) removeRepeat:(NSString *)aNum

{
    
    NSMutableArray *mArr = [[NSMutableArray alloc]initWithCapacity:10];
    
    for(int i = 0; i<aNum.length; i++)
        
    {
        
        [mArr addObject:[aNum substringWithRange:NSMakeRange(i,1)]];
        
    }
    
    //    NSLog(@"%@",mArr);
    
    [self compareNum:mArr];
    
    NSLog(@"%@",mArr);
    
}

//  比较是否相等

-(NSMutableArray *)compareNum:(NSMutableArray *)mArr

{
    
    int count  = mArr.count; // 重新定义了count不会减1
    
    for(int j = 0; j< count - 1 ;j++)
        
    {
        
        for(int i = j;i < count -1-1-1;i++)
            
        {
            
            //            NSLog(@"%@  %@",[mArr objectAtIndex:j],[mArr objectAtIndex:i + 2]);
            
            NSString *a = [mArr objectAtIndex:j];
            
            NSString *b = [mArr objectAtIndex:i+2];
            
            if([a isEqualToString:b])
                
            {
                
                [mArr replaceObjectAtIndex:i + 2 withObject:@" "];
                
            }
            
        }
        
    }
    
    return mArr;
    
}


@end
