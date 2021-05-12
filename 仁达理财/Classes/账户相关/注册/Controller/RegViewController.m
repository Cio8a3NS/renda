//
//  RegViewController.m
//  仁达
//
//  Created by 杨方军 on 16/7/29.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "RegViewController.h"
#import "RegTableViewCell.h"
#import "UserInfo.h"
#import "RGGPersonInfoController.h"
@interface RegViewController ()<UITableViewDelegate,UITableViewDataSource,RegTableViewCellDelegate>

/**顶部的大提醒*/
@property (strong,nonatomic)UILabel *topInfoLabel;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)UIView *footerView;

@property (strong,nonatomic)NSMutableArray *cellArray;


@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initlizeAppance];
    [self initlizeDataSource];
}



- (void)viewWillAppear:(BOOL)animated{
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.933 green:0.298 blue:0.161 alpha:1.000]];

}


#pragma mark - 加载UI
- (void)initlizeAppance{
    //nslog(@"regnav%@",self.navigationController);
    [super initlizeAppance];
    self.title = @"注册";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapview)];
    [self.view addGestureRecognizer:tap];
    
    [self.topInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(self.view).multipliedBy(0.1);
        make.left.right.equalTo(self.view);
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topInfoLabel.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        
        
    }];
    
    
}

- (void)tapview{
    //手机号
    RegTableViewCell *cell = self.cellArray[0];
    [cell.inputField resignFirstResponder];
    //验证码
    RegTableViewCell *codeCell = self.cellArray[1];
    [codeCell.inputField  resignFirstResponder];
    //登录密码
    RegTableViewCell *passwordCell = self.cellArray[2];
    [passwordCell.inputField  resignFirstResponder];
    RegTableViewCell *confirmCell = self.cellArray[3];
    [confirmCell.inputField  resignFirstResponder];
}

#pragma mark - 初始化数据源
- (void)initlizeDataSource{
    
    NSArray *titleArray = @[@"手机",@"验证码",@"登录密码",@"确认密码"];
    NSArray *placeArray = @[@"请输入手机号码",@"请输入验证码",@"组合字母、数字或符号",@"请再次输入密码"];
    NSArray *rightBtnArray = @[@"删除",@"发送验证码",@"隐藏密码",@"隐藏密码"];
    
    for (int i = 0 ; i < titleArray.count; i ++) {
        
        RegModel *model   = [[RegModel alloc]init];
        model.title       = titleArray[i];
        model.placeStr    = placeArray[i];
        model.rightBtnStr = rightBtnArray[i];
        model.btnType     = i != 1 ? ImageType:DefaultType;
        model.btnType     = i == 0 ? HideIcoType : model.btnType;
        model.is_Show     = i == 2||i == 3 ?1:0;
        [self.dataSource addObject:model];
        
    }
    
    
}


#pragma mark - 注册账号
- (void)regAction{
    
        if (self.cellArray.count == 0) {
    
            return;
        }
    
        //手机号
        RegTableViewCell *cell = self.cellArray[0];
        NSString *mobile = cell.inputField.text;
        //验证码
        RegTableViewCell *codeCell = self.cellArray[1];
        NSString *code = codeCell.inputField.text;
        //登录密码
        RegTableViewCell *passwordCell = self.cellArray[2];
        NSString *password = passwordCell.inputField.text;
    
        /************判断输入****************/
        for (int i = 0; i < self.cellArray.count; i ++) {
    
            RegTableViewCell *cell = self.cellArray[i];
            NSString *str = cell.inputField.text;
            //判断手机号
            if (i == 0 && ![FactoryTool isMobileNumber:str]){
                [self handleInputData:i];
                return;
            }
            if (str.length == 0) {
    
                [self handleInputData:i];
                return;
            }
        }
    
        RegTableViewCell *psdCell = self.cellArray[2];
        RegTableViewCell *confirmCell = self.cellArray[3];
        if (![psdCell.inputField.text isEqualToString:confirmCell.inputField.text]) {
    
            [self handleInputData:100];
            return;
            
        }
        
        if (![FactoryTool predicatePassWord:password]) {
            
            return;
        }

    //构建字典传值
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@([mobile integerValue]),@"phone",@([code integerValue]),@"code",[[FactoryTool md532BitUpper:psdCell.inputField.text] uppercaseString],@"password",nil];
    
    RGGPersonInfoController *personInfoController = [[RGGPersonInfoController alloc]init];
    personInfoController.dictionary = dictionary;
    [self.navigationController pushViewController:personInfoController animated:YES];
    
//
//    
//    /**************开始注册上传数据******************/
//    
//    NSDictionary *dic = @{@"mobile":mobile,
//                          @"code":code,
////                          @"password":[FactoryTool md5:password]
//                          };
////    dic  = [NSDictionary code:dic];
//    
//    [HttpTool post:[NSString stringWithFormat:@"%@register.json",BaseURL] params:dic success:^(id json) {
//        
//        if (![json isKindOfClass:[NSDictionary class]]) {
//            
//            [SVProgressHUD showInfoWithStatus:@"数据异常"];
//        }
//        
//        NSInteger code = [json[@"code"] integerValue];
//        switch (code) {
//            case 200:
//                //注册成功,跳转到登录页面
//                {
//                    
//                    //暂时不存储用户数据，后面需要存储在打开
////                    UserInfo *userInfo = [UserInfo sharedManager];
////                    [userInfo saveUserInfoData:json];
//                    [SVProgressHUD showInfoWithStatus:@"注册成功"];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        
//                        //跳转到登录页面
//                        LoginViewController *loginVC = [[LoginViewController alloc]init];
//                        loginVC.hide_return = NO;
////                        [self.navigationController pushViewController:loginVC animated:YES];
//                         [self.navigationController popViewControllerAnimated:YES];
//                        
//                    });
//                    
//                }
//                break;
//            default:
//                //失败了
//                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"注册失败!\n失败原因:%@",json[@"msg"]]];
//                break;
//        }
//        
//    } failure:^(NSError *error) {
//        
//        [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
//        
//        
//        
//    }];
//    
    
    
    
}

#pragma mark - 处理用户输入的数据
- (void)handleInputData:(NSInteger)tag{
    
    switch (tag) {
        case 0:
                [SVProgressHUD showInfoWithStatus:@"手机号码输入错误"];
            break;
        case 1:
            [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
            break;
        case 2:
        case 3:
            [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
            break;
            
        default:
            [SVProgressHUD showInfoWithStatus:@"输入的密码不一致"];
            break;
    }


}



#pragma mark - tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = [NSString stringWithFormat:@"cell:%ld",(long)indexPath.row];
    RegTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[RegTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.cellArray addObject:cell];
    cell.inputField.keyboardType = indexPath.row == 0||indexPath.row == 1?UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
    [cell setRegModel:self.dataSource[indexPath.row]];
    
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 108/2;
    
}



#pragma mark - RegTableViewCellDelegate


- (void)getCodeAction:(ResultBlock)block{

    if (self.cellArray.count == 0) {
        
        return;
    }
    
    RegTableViewCell *cell = [self.cellArray firstObject];
    
    NSString *mobile = cell.inputField.text;
    if (![FactoryTool isMobileNumber:mobile]) {
        
        [SVProgressHUD showInfoWithStatus:@"手机号码输入错误"];
        return;
        
    }
    
//    CGFloat time = (NSInteger)[[NSDate date] timeIntervalSince1970];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在获取验证码,请稍后..."];
    NSDictionary *dic = @{@"type":@"login_rgsendcode",
                          @"sign":[FactoryTool rendeCode],
                          @"qtime":@((NSInteger)[[NSDate date] timeIntervalSince1970]),
                          @"phone":mobile
                          };
//    dic  = [NSDictionary code:dic];
    NSLog(@"%@",dic);
    
    [HttpTool post:BaseURL params:dic success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        NSInteger status = [json[@"status"]integerValue];
        if (status == 1) {
            block();
        }else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
    } failure:^(NSError *error) {
         [SVProgressHUD dismiss];
         [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
    }];

}

- (void)regTapAction{

//    NSString *url = [NSString stringWithFormat:@"%@register/regAgreement",RegAgreement];
//    RootWebViewController *webVC = [[RootWebViewController alloc]init];
//    webVC.url = url;
//    webVC.webViewType = OtherTyReturnpepe;
//    [self.navigationController pushViewController:webVC animated:YES];


}




#pragma mark - 懒人

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



- (UILabel *)topInfoLabel{
    
    if (!_topInfoLabel) {
        
        _topInfoLabel = [FactoryTool factoryLabel:@"提示：默认登录密码和支付密码一致" color:[UIColor redColor] size:15];
        _topInfoLabel.numberOfLines = 0;
        _topInfoLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_topInfoLabel];
        
    }
    return _topInfoLabel;
    
    
}


- (UIView *)footerView{
    
    if (!_footerView) {
        
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _footerView.userInteractionEnabled = YES;
        UIImageView *xxImageView = [FactoryTool factoryImageView:@"勾勾"];
        [xxImageView setFrame:CGRectMake(20, 25, 20, 20)];
        [_footerView addSubview:xxImageView];
        NSString *str = @"我已阅读并同意仁达";
        UILabel *infoLabel = [FactoryTool factoryLabel:str color:GLOBALCOLOR(153,153,153) size:12];
        [infoLabel setFrame:CGRectMake(CGRectGetMaxX(xxImageView.bounds) + 25, 20, 160, 30)];
//        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
//        NSRange range;
//        range.length = 8;
//        range.location = str.length - 8;
//        [attributeStr addAttribute:NSForegroundColorAttributeName
//                             value:GLOBALCOLOR(53,153,238,1)
//                             range:range];
//        infoLabel.attributedText = attributeStr;
        
        UILabel *regProtocolLabel  = [FactoryTool factoryLabel:@"《注册服务协议》" color:GLOBALCOLOR(53,153,238) size:12];
        regProtocolLabel.frame = CGRectMake(CGRectGetMaxX(infoLabel.bounds), 20, SCREEN_WIDTH, 30);
        regProtocolLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(regTapAction)];
        [regProtocolLabel addGestureRecognizer:tap];
        [_footerView addSubview:regProtocolLabel];
        
        UIButton *regBtn          = [FactoryTool factoryButton:@"下一步" color:GLOBALCOLOR(137, 191, 255)];
        [regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [regBtn setFrame:CGRectMake(30, CGRectGetMaxY(infoLabel.bounds) + 40, SCREEN_WIDTH - 60, 55)];
        regBtn.layer.cornerRadius = 3;
        regBtn.clipsToBounds      = YES;
        [regBtn addTarget:self action:@selector(regAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:regBtn];
        [_footerView addSubview:infoLabel];
        
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
