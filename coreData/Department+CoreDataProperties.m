//
//  Department+CoreDataProperties.m
//  coreDataTest
//
//  Created by Berning on 2018/10/5.
//  Copyright © 2018年 BN. All rights reserved.
//
//

#import "Department+CoreDataProperties.h"

@implementation Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Department"];
}

@dynamic createDate;
@dynamic departName;
@dynamic employee;

@end
