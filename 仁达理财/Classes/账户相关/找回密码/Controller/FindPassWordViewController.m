//
//  FindPassWordViewController.m
//  仁达
//
//  Created by 杨方军 on 16/7/30.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "PassWordModel.h"
#import "PassWordTableViewCell.h"

#import "ResetPwdViewController.h"

#import "ResetService.h"

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
//    [self.navigationController.navigationBar setTranslucent:NO];
//    [self.navigationController.navigationBar setBarTintColor:GLOBALCOLOR(245, 98, 54)];
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
    
  
    if (![FactoryTool isMobileNumber:iphoneCell.inputField.text]) {
        
         [SVProgressHUD showInfoWithStatus:@"手机号码输入错误"];
         return;
    }
    if (!is_code) {
        
        [SVProgressHUD showInfoWithStatus:@"验证码不正确"];
        return;
        
    }
    
    UserInfo *user = [UserInfo sharedManager];
    user.phone = iphoneCell.inputField.text;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在获取验证码..."];
    NSDictionary *dic = @{
                          @"type" : @"login_sendcode",
                          @"sign" : [FactoryTool rendeCode],
                          @"qtime" : qtime,
                          @"phone" : iphoneCell.inputField.text
                          };
    [HttpTool post:BaseURL params:dic success:^(id json) {
         NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            ResetPwdViewController *reset = [[ResetPwdViewController alloc] init];
            [self.navigationController pushViewController:reset animated:YES];
          
        }
        else{

        [SVProgressHUD showInfoWithStatus:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
    }];

    

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
        
        UIButton *codeBtn          = [FactoryTool factoryButton:@"发送手机验证码" color:mycolor];
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
