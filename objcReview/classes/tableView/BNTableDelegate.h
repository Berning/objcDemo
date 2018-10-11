//
//  BNTableDelegate.h
//  Xcode8
//
//  Created by Berning on 2018/9/5.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^selectCell) (NSIndexPath *indexPath);


@interface BNTableDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

/**
 *  创建代理对象实例，并将数据列表传进去
 *  代理对象将消息传递出去，是通过block的方式向外传递消息的
 *  @return 返回实例对象
 */
+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList
                                        selectBlock:(selectCell)selectBlock;


@end
