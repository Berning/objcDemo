//
//  BNParseViewController.h
//  objcReview
//
//  Created by aBerning on 2019/9/15.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNTableViewController.h"
#import "BNVidio.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNParseViewController : BNTableViewController

{
@public
    char * _publicName;
@private
    char * _privateName;

@protected
    char * _protectedName;

@package
    char * _packageName;

    
}

@property(strong,nonatomic)NSArray *videos;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
