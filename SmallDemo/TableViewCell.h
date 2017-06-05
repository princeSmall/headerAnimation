//
//  TableViewCell.h
//  SmallDemo
//
//  Created by tongle on 2017/6/2.
//  Copyright © 2017年 tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic,strong) Model * model;
-(void)updateUI;
@end
