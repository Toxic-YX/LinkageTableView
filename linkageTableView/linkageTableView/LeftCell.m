//
//  LeftCell.m
//  linkageTableView
//
//  Created by YuXiang on 2017/7/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "LeftCell.h"

@implementation LeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureForPhoto:(NSArray *)arr {
    
    self.titleLbl.text = [NSString stringWithFormat:@"%@",@"123"];
}


@end
