//
//  ViewController.m
//  Xcode8
//
//  Created by uBerning on 2017/3/12.
//  Copyright © 2017年 BN. All rights reserved.
//

//C
#include "cbasic.h"

//test
#import "BNPerson.h"
#import "BNMalePerson.h"

#import "ViewController.h"
#import "BNViewController.h"
#import "BNRunTime.h"

//thread
#import "BNGCD.h"
#import "BNThread.h"
#import "BNOpration.h"

//dataBase
#import "BNSandBox.h"
#import "BNBaseStore.h"
#import "BNSQLite.h"
#import "BNCoreData.h"

//network
#import "BNHttp.h"
#import "AFNetworking.h"

#import "BNProgressView.h"
#import <security/Security.h>


//viewcontroller
#import "BNBaseTableView.h"


@interface ViewController ()

//@property(nonatomic,weak)UIButton *wBtn;

//BOOL 默认0
@property(nonatomic,assign,getter=isExecuting)BOOL *executing;

@property(nonatomic,weak)BNProgressView *progressView;


@end


@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
#pragma mark c
//    cmain();
//    cinpunt(19);
#pragma mark thread

//    [BNThread test];
//    [BNBlock test];
//    [BNGCD test];
//    BNGCD *gcd=[BNGCD sharedMed];
//    [gcd testSingle];
//    [BNOpration test];
    
#pragma mark store
//    [BNBaseStore test];
//    [BNCoreData test];
    
    
}

@end
