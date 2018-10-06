//
//  Employee+CoreDataProperties.h
//  coreDataTest
//
//  Created by Berning on 2018/10/5.
//  Copyright © 2018年 BN. All rights reserved.
//
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *birthday;
@property (nonatomic) float height;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Department *department;

@end

NS_ASSUME_NONNULL_END
