//
//  Employee+CoreDataProperties.m
//  coreDataTest
//
//  Created by Berning on 2018/10/5.
//  Copyright © 2018年 BN. All rights reserved.
//
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
}

@dynamic birthday;
@dynamic height;
@dynamic name;
@dynamic department;

@end
