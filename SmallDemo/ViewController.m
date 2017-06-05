//
//  ViewController.m
//  SmallDemo
//
//  Created by tongle on 2017/6/2.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "LabelViewController.h"
#import "infoViewController.h"
#import "askViewController.h"


#define GlobleWidth self.view.frame.size.width
#define GlobleHeight self.view.frame.size.height
#define backColor [UIColor colorWithRed:230/255.0 green:0 blue:49/255.0 alpha:1]

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isScroll;
    NSInteger headerHeight;
    NSInteger  oldOrigin;
    NSInteger  newOrigin;
    NSInteger  currentOrigin;
}
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)UITableView * topView;
@property (nonatomic,strong)UITableView * bottomView;
@property (nonatomic,strong)UIButton * centerBtn;
@property (nonatomic,strong)UIButton * leftBtn;
@property (nonatomic,strong)NSMutableArray * oneArray;
@property (nonatomic,strong)NSMutableArray * twoArray;
@property (nonatomic,strong)NSMutableArray * threeArray;


@end

static NSString * topIdentifier = @"cellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, GlobleWidth, GlobleHeight)];
    self.backScrollView.backgroundColor =[UIColor whiteColor];
    self.backScrollView.scrollEnabled = NO;
    
    self.topView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, GlobleWidth, 60)];
    self.topView.scrollEnabled = NO;

    
    self.bottomView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, GlobleWidth, GlobleHeight- 60)];
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.topView];
    self.topView.delegate = self;
    self.topView.dataSource = self;
    self.bottomView.delegate = self;
    self.bottomView.dataSource = self;
     [self.topView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:topIdentifier];
    
    [self.backScrollView addSubview:self.bottomView];
    self.backScrollView.contentSize = self.view.bounds.size;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    // 返回所有数据
}
/*懒加载*/
-(NSMutableArray *)oneArray{
    if (_oneArray == nil) {
        _oneArray = [NSMutableArray array];
    }
    return _oneArray;
}
-(NSMutableArray *)twoArray{
    if (_twoArray == nil) {
        _twoArray = [NSMutableArray array];
    }
    return _twoArray;
}
-(NSMutableArray *)threeArray{
    if (_threeArray == nil) {
        _threeArray = [NSMutableArray array];
    }
    return _threeArray;
}
-(Model *)model{
    if (_model == nil) {
        _model = [[Model alloc]init];
    }
    return _model;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}
/* TODO */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    isScroll = YES;
    newOrigin = self.bottomView.frame.origin.y;
    
    NSLog(@"new---%ld,old--%ld",(long)newOrigin,(long)oldOrigin);
    
    if (newOrigin  <  300) {
        if (oldOrigin - newOrigin > 0) {
            if (oldOrigin == 60) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.topView.frame = CGRectMake(0, 0,GlobleWidth, 0);
                    self.bottomView.frame = CGRectMake(0, 0,GlobleWidth,GlobleHeight);
                }];
            }else
            [UIView animateWithDuration:0.5 animations:^{
                self.topView.frame = CGRectMake(0, 0,GlobleWidth, 60);
                self.bottomView.frame = CGRectMake(0, 60,GlobleWidth,GlobleHeight);
                self.centerBtn.hidden = NO;
                self.leftBtn.hidden = YES;
            }];
        }else{
            if (oldOrigin == 0) {
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.topView.frame = CGRectMake(0, 0,GlobleWidth, 60);
                    self.bottomView.frame = CGRectMake(0, 60,GlobleWidth,GlobleHeight);
                    
                }];
            }else
            [UIView animateWithDuration:0.5 animations:^{
                self.centerBtn.hidden = YES;
                self.leftBtn.hidden = NO;
                self.topView.frame = CGRectMake(0, 0,GlobleWidth, 300);
                self.bottomView.frame = CGRectMake(0, 300,GlobleWidth,GlobleHeight);
                
            }];
        }
    }

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
    isScroll = NO;
    headerHeight = self.topView.frame.size.height;
    oldOrigin = self.bottomView.frame.origin.y;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    currentOrigin = self.bottomView.frame.origin.y;
    NSLog(@"---%ld",currentOrigin);
    if (oldOrigin == 300 && scrollView.contentOffset.y < 0) {
        
    }else if (oldOrigin == 60){
        
            if (isScroll == NO) {
                self.topView.frame = CGRectMake(0, 0, GlobleWidth, headerHeight + currentOrigin);
                
                CGRect frames = self.bottomView.frame;
                frames.origin.y  -= scrollView.contentOffset.y;
                self.bottomView.frame = frames;
        }
    
    }
    else{
        if (isScroll == NO) {
            self.topView.frame = CGRectMake(0, 0, GlobleWidth, headerHeight - scrollView.contentOffset.y);
            
            CGRect frames = self.bottomView.frame;
            frames.origin.y  -= scrollView.contentOffset.y;
            self.bottomView.frame = frames;

        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.topView) {
        return 4;
    }else{
        return 6;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIButton *)centerBtn{
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, GlobleWidth-20, 40)];
        [_centerBtn setBackgroundColor:[UIColor whiteColor]];
        _centerBtn.alpha = 0.4;
        _centerBtn.layer.cornerRadius = 20;
        _centerBtn.layer.masksToBounds = YES;
        [_centerBtn addTarget:self action:@selector(topButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _centerBtn;
}
-(UIButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 20, 30)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"icon-right"] forState:UIControlStateNormal];
        _leftBtn.alpha = 0.4;
        _leftBtn.layer.cornerRadius = 20;
        _leftBtn.layer.masksToBounds = YES;
        [_leftBtn addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GlobleWidth, 60)];
    view.backgroundColor = backColor;
    if (tableView == self.topView) {
        [view addSubview:self.centerBtn];
        [view addSubview:self.leftBtn];
        self.leftBtn.hidden = YES;
       
    }else{
        
    }
     return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.topView) {
        if (indexPath.row == 1) {
            askViewController * ask = [[askViewController alloc]init];
            [self.navigationController presentViewController:ask animated:YES completion:nil];
        }else if (indexPath.row == 2){
            LabelViewController * label = [[LabelViewController alloc]init];
            [self.navigationController presentViewController:label animated:YES completion:nil];
        }else if (indexPath.row == 3){
            infoViewController * info = [[infoViewController alloc]init];
            [self.navigationController presentViewController:info animated:YES completion:nil];
          
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = @"cell";
        if (tableView == self.topView) {
        TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:topIdentifier forIndexPath:indexPath];
        self.topView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.backgroundColor = backColor;
            // 更新ui的时候应该赋值model
            [cell updateUI];
            if (indexPath.row == 0) {
                //应该是 textfield
                if (self.model.name == nil) {
                    cell.infoLabel.text = @"用户昵称";
                }else{
                    cell.infoLabel.text = self.model.name;
                }
                
            }else if (indexPath.row == 1){
                if (self.model.aksArray == nil) {
                    cell.infoLabel.text = @"服务要求";
                }else{
                     //选择返回值aksArray；
                }
                
            }else if (indexPath.row == 2){
                if (self.model.labelArray == nil) {
                     cell.infoLabel.text = @"标签属性----点击此行";
                }else{
                     //选择返回值labelArray；
                }
               
            }else if (indexPath.row == 3){
                if (self.model.infoArray == nil) {
                     cell.infoLabel.text = @"详细信息";
                }else{
                    //选择返回值infoLabel；
                }
               
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        return  cell;
    }

}

-(void)topButtonTouch{
     self.centerBtn.hidden = YES;
    self.leftBtn.hidden = NO;

    [UIView animateWithDuration:0.5 animations:^{
            self.topView.frame = CGRectMake(0, 0,GlobleWidth, 300);
            self.bottomView.frame = CGRectMake(0, 300,GlobleWidth,GlobleHeight);
       
    
    }];
    
}
-(void)leftButtonTouch{
    self.centerBtn.hidden = NO;
    self.leftBtn.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.topView.frame = CGRectMake(0, 0,GlobleWidth, 60);
        self.bottomView.frame = CGRectMake(0, 60,GlobleWidth,GlobleHeight);
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
