//
//  FindPassWordViewController.m
//  仁达理财
//
//  Created by 杨方军 on 16/7/30.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "PassWordModel.h"
#import "PassWordTableViewCell.h"

@interface FindPassWordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)UIView *footerView;

/**cellArray*/
@property (strong,nonatomic)NSMutableArray *cellArray;


@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initlizeAppance];
    [self initlizeDataSource];
}


- (void)initlizeAppance{

    [super initlizeAppance];
    
    self.title = @"找回密码";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
        
    }];
    
    
}



- (void)initlizeDataSource{

    NSArray *titleArray = @[@"手机",@"验证码"];
    NSArray *placeArray = @[@"请输入手机号码",@"请输入验证码"];
    
    for (int i = 0 ; i < titleArray.count; i ++) {
        
        PassWordModel *model   = [[PassWordModel alloc]init];
        model.title       = titleArray[i];
        model.placeStr    = placeArray[i];
        model.show_Code   = i == 1 ? 1:0;
        [self.dataSource addObject:model];
        
    }
    
    


}

#pragma mark - 发送手机验证码
- (void)getCodeAction{

    PassWordTableViewCell *iphoneCell = self.cellArray[0];
    PassWordTableViewCell *codeCell   = self.cellArray[1];
    
    BOOL is_code = [[codeCell.inputField.text uppercaseString] isEqualToString:[codeCell.codeView.authCodeStr uppercaseString]];
    
  
    if (![self isMobileNumber:iphoneCell.inputField.text]) {
        
         [WSProgressHUD showErrorWithStatus:@"手机号输入错误"];
         return;
    }
    if (!is_code) {
        
        [WSProgressHUD showErrorWithStatus:@"验证码不正确"];
        return;
        
    }
    


}


- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //  NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * MOBILE = @"^1[0-9]{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = [NSString stringWithFormat:@"cell:%ld",(long)indexPath.row];
    PassWordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[PassWordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.dataSource[indexPath.row]];
    [self.cellArray addObject:cell];
    
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}






#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.footerView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
    
}


- (UIView *)footerView{
    
    if (!_footerView) {
        
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _footerView.userInteractionEnabled = YES;
        
        UIButton *codeBtn          = [FactoryTool factoryButton:@"发送手机验证码" color:[UIColor colorWithRed:1.000 green:0.200 blue:0.177 alpha:0.9]];
        [codeBtn setFrame:CGRectMake(30,40, SCREEN_WIDTH - 60, 55)];
        codeBtn.layer.cornerRadius = 3;
        codeBtn.clipsToBounds      = YES;
        [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [codeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:codeBtn];
        
    }
    return _footerView;
    
    
}


- (NSMutableArray *)cellArray{
    
    if (!_cellArray) {
        
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
    
    
}












@end
