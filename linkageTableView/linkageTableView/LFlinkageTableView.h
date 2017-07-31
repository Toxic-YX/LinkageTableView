//
//  LFlinkageTableView.h
//  linkageTableView
//
//  Created by YuXiang on 2017/7/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LFlinkageTableSelectedType) {
    
    LFlinkageTableSelectedTypeNone = 0,  // None
    LFlinkageTableSelectedTypeLeft,         // Left
    LFlinkageTableSelectedTypeRight        // Right
};

typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);

@protocol LFlinkageTableViewDelegate <NSObject>

@optional

@end

@interface LFlinkageTableView : UIView

@property (nonatomic, copy) NSString *leftCellClassName;
@property (nonatomic, copy) NSString *rightCellClassName;

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<LFlinkageTableViewDelegate>)delegate
                    leftTableViewWidth:(CGFloat)width
                  configureLeftCell:(CellConfigureBefore)aLeftCellBlock
               configureRightCell:(CellConfigureBefore)aRightCellBlock;

- (void)addLeftModels:(NSArray *)leftModels
          rightModels:(NSArray *)rightModels;

@end
