//
//  BNEmployee.h
//  Xcode8
//
//  Created by Berning on 2018/10/4.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNEmployee : NSManagedObject


@end

@interface BNEmployee (properties)

+ (NSFetchRequest<BNEmployee *> *)fetchRequest;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *height;
@property(nonatomic,strong)NSDate *createDate;


@end

NS_ASSUME_NONNULL_END
