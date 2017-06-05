//
//  LabelViewController.m
//  SmallDemo
//
//  Created by tongle on 2017/6/2.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "LabelViewController.h"
#import "CollectionViewCell.h"

@interface LabelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * oneArray;
@property (nonatomic,strong)NSMutableArray * twoArray;
@property (nonatomic,strong)UIButton * editBtn;
@property (nonatomic,strong)UILabel * titleLab;
@property (nonatomic,strong)CollectionViewCell * collectionCell;



@end

NSString * identifier = @"cell";
static NSString *const headerId = @"headerId";

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, 30, 30)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(viewReture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
  
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"one"] == nil) {
        self.oneArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",nil];
    }else{
        id array = [[NSUserDefaults standardUserDefaults]objectForKey:@"one"];
        [self.oneArray addObjectsFromArray:array];
    }
    if ( [[NSUserDefaults standardUserDefaults]objectForKey:@"two"] == nil) {
        self.twoArray = [NSMutableArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j", nil];
    }else{
        id array = [[NSUserDefaults standardUserDefaults]objectForKey:@"two"];
        [self.twoArray addObjectsFromArray:array];
    }
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}
-(void)viewReture{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(Model *)model{
    if (_model == nil) {
        _model = [[Model alloc]init];
    }
    return _model;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 添加结束给model赋值
    [_model.labelArray addObjectsFromArray:self.oneArray];
}
-(NSMutableArray *)oneArray{
    if (_oneArray == nil) {
        _oneArray = [[NSMutableArray alloc]init];
    }
    return _oneArray;
}
-(NSMutableArray *)twoArray{
    if (_twoArray == nil) {
        _twoArray = [[NSMutableArray alloc]init];
    }
    return _twoArray;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.collectionCell.edit == YES) {
        if (indexPath.section == 0) {
            id  object = [self.oneArray objectAtIndex:indexPath.row];
            [self.oneArray removeObjectAtIndex:indexPath.row];
            [self.twoArray addObject:object];
            [self.collectionView reloadData];
        }else{
            id object = [self.twoArray objectAtIndex:indexPath.row];
            [self.twoArray removeObjectAtIndex:indexPath.row];
            [self.oneArray addObject:object];
            [self.collectionView reloadData];
        }
        [[NSUserDefaults standardUserDefaults]setObject:self.oneArray forKey:@"one"];
        [[NSUserDefaults standardUserDefaults]setObject:self.twoArray forKey:@"two"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else{

        
    }
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.oneArray.count;
    }else
        return self.twoArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 40);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor darkGrayColor];
    
    // 防止复用
    [headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50, 40)];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textColor = [UIColor whiteColor];
    [headerView addSubview:self.titleLab];
    
    if (indexPath.section == 0) {
        self.titleLab.text = @"已添加目录,点击编辑可操作";
        _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 0, 50, 40)];
        
        if (self.collectionCell.edit == NO) {
            [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }else{
            [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        }
        [_editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.editBtn];
    }else{
        self.titleLab.text = @"待添加目录";
    }
    
    
    return headerView;
    
}
-(void)edit{
    for (CollectionViewCell * cell in self.collectionView.visibleCells) {
        if (cell.edit == NO) {
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 0.7f;
            cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
            cell.layer.shadowOffset = CGSizeMake(1.f, 1.f);
            cell.deleteBtn.hidden = NO;
            [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
            cell.edit = YES;
        }else{
            cell.edit = NO;
            cell.deleteBtn.hidden = YES;
            cell.layer.masksToBounds = YES;
            [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }
    }
    
}
-(void)deleteCellButton:(id)sender{
    CollectionViewCell * cell = (CollectionViewCell *)[[sender superview] superview];
    NSIndexPath * indexpath = [self.collectionView indexPathForCell:cell];
    if (indexpath.section ==0) {
        [self.oneArray removeObjectAtIndex:indexpath.row];
    }else{
        [self.twoArray removeObjectAtIndex:indexpath.row];
    }
    [self.collectionView reloadData];
    [[NSUserDefaults standardUserDefaults]setObject:self.oneArray forKey:@"one"];
    [[NSUserDefaults standardUserDefaults]setObject:self.twoArray forKey:@"two"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    [cell.deleteBtn addTarget:self action:@selector(deleteCellButton:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.section == 0) {
        cell.titleLabel.text = self.oneArray[indexPath.row];
    }else{
        cell.titleLabel.text = self.twoArray[indexPath.row];
    }
    self.collectionCell = cell;
    
    return  cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
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
