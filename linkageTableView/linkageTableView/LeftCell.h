//
//  LeftCell.h
//  linkageTableView
//
//  Created by YuXiang on 2017/7/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
- (void)configureForPhoto:(NSArray *)arr;
@end
