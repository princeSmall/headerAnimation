//
//  infoViewController.m
//  SmallDemo
//
//  Created by tongle on 2017/6/2.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, 30, 30)];
   [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(viewReture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewReture{
      [self dismissViewControllerAnimated:YES completion:nil];
}
-(Model *)model{
    if (_model == nil) {
        _model = [[Model alloc]init];
    }
    return _model;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //给model赋值
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
