//
//  RightCell.m
//  linkageTableView
//
//  Created by YuXiang on 2017/7/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "RightCell.h"

@implementation RightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureForPhoto:(NSArray *)arr {
    
    self.contentLbl.text = [NSString stringWithFormat:@"%@",@"234"];
}

@end
