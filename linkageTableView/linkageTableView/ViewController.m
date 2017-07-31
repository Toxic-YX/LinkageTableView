//
//  ViewController.m
//  linkageTableView
//
//  Created by YuXiang on 2017/7/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "ViewController.h"
#import "LFlinkageTableView.h"
#import "LeftCell.h"
#import "RightCell.h"


@interface ViewController ()<LFlinkageTableViewDelegate>

@end

static NSString * leftID = @"LeftCell";
static  NSString * rightID = @"RightCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *leftArr = @[@"商品1",@"商品2",@"商品3",@"商品4",@"商品5",@"商品6",@"商品7"];
    NSArray *rightArr = @[
  @[@"1",@"one",@"two",@"three",@"foue",@"five"],
  @[@"1",@"one",@"two",@"three",@"foue",@"five"],
                          @[@"1",@"one",@"two",@"three",@"foue",@"five"],
                          @[@"1",@"one",@"two",@"three",@"foue",@"five"],
                          @[@"1",@"one",@"two",@"three",@"foue",@"five"],
  @[@"1",@"one",@"two",@"three",@"foue",@"five"],
  @[@"1",@"one",@"two",@"three",@"foue",@"five"]
                          ];
    
    CellConfigureBefore leftCofigureCell = ^(LeftCell *cell, NSArray *lefArr, NSIndexPath *indexPath) {
        [cell configureForPhoto:lefArr];
    };
    
    CellConfigureBefore rightCofigureCell = ^(RightCell *cell, NSArray *rightArr, NSIndexPath *indexPath) {
        [cell configureForPhoto:rightArr];
    };

    LFlinkageTableView *tableV = [[LFlinkageTableView alloc] initWithFrame:self.view.bounds delegate:self  leftTableViewWidth:100 configureLeftCell:leftCofigureCell configureRightCell:rightCofigureCell];
    tableV.leftCellClassName = @"LeftCell";
    tableV.rightCellClassName = @"RightCell";
    [tableV addLeftModels:leftArr rightModels:rightArr];
    [self.view addSubview:tableV];
    
}



@end
