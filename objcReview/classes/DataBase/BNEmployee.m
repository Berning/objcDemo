//
//  BNEmployee.m
//  Xcode8
//
//  Created by Berning on 2018/10/4.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNEmployee.h"

@implementation BNEmployee




@end

@implementation BNEmployee (properties)

+ (NSFetchRequest<BNEmployee *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"BNEmployee"];
}

@dynamic createDate;
@dynamic height;
@dynamic name;



@end
