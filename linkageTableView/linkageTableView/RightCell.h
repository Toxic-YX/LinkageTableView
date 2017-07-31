//
//  RightCell.h
//  linkageTableView
//
//  Created by YuXiang on 2017/7/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
- (void)configureForPhoto:(NSArray *)arr;
@end
