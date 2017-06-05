//
//  TableViewCell.m
//  SmallDemo
//
//  Created by tongle on 2017/6/2.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateUI{
    self.cellView.layer.masksToBounds = YES;
    self.cellView.layer.cornerRadius = 20;
    self.cellView.backgroundColor = [UIColor whiteColor];
    self.cellView.alpha = 0.4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
