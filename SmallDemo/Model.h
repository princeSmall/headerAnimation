//
//  Model.h
//  SmallDemo
//
//  Created by tongle on 2017/6/2.
//  Copyright © 2017年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,strong)NSMutableArray * labelArray;
@property (nonatomic,strong)NSMutableArray * infoArray;
@property (nonatomic,strong)NSMutableArray * aksArray;

@end
