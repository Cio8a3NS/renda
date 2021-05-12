//
//  LoginViewController.m
//  仁达
//
//  Created by 杨方军 on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "LoginViewController.h"
#import "CodeLoginViewController.h"
#import "RegViewController.h"
#import "FindPassWordViewController.h"
#import "RGGTabBarController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

/**顶部的LogoView*/
@property (strong,nonatomic)UIImageView *logoImageView;

/**用户账号*/
@property (strong,nonatomic)UITextField *userField;

/**密码*/
@property (strong,nonatomic)UITextField *psdField;

/**登录按钮*/
@property (strong,nonatomic)UIButton *loginBtn;

/**验证码登录*/
@property (strong,nonatomic)UILabel *codeLoginLabel;

/**忘记密码*/
@property (strong,nonatomic)UILabel *forgetLabel;

/**立即注册*/
@property (strong,nonatomic)UILabel *regLabel;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initlizeAppance];
    
}

//- (void)goBack{
//    
//    if (self.chooseBackBlock) {
//        
//        self.chooseBackBlock(YES);
//    }
//    if (self.return_RootVC) {
//        
//        self.tabBarController.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
//        CATransition *animation =[CATransition animation];
//        [animation setDuration:0.75f];
//        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//        [animation setType:kCATransitionPush];
//        [animation setSubtype:kCATransitionFromLeft];
//        [self.tabBarController.view.layer addAnimation:animation forKey:@"reveal"];
//        
//        self.tabBarController.selectedIndex = 0;
//        
//    }else{
//
//        [self.navigationController popViewControllerAnimated:YES];
//    
//    }
//    
//}



- (void)viewWillAppear:(BOOL)animated{
      //nslog(@"loginnav%@",self.navigationController);
    //    导航栏变为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
//    self.navigationController.navigationBar.shadowImage=[UIImage new];
//    if (!self.hide_return) {
//        
//        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//        self.navigationItem.leftBarButtonItem = leftBarBtn;
//        [self.navigationController.navigationBar setTitleTextAttributes:
//         @{NSFontAttributeName:[UIFont systemFontOfSize:19],
//           NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        
//        UINavigationBar* bar=self.navigationController.navigationBar;
//        bar.barStyle=UIBarStyleBlack;
//        [bar setTintColor:[UIColor whiteColor]];
//        bar.backgroundColor = GLOBALCOLOR(245, 98, 54);
//        [self.navigationController.navigationBar setTranslucent:YES];
//        self.navigationController.navigationBar.shadowImage = [UIImage new];
//        self.navigationController.view.backgroundColor = GLOBALCOLOR(245, 98, 54);
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//
//        
//        
//    }else{
//    
//        self.navigationController.navigationBar.hidden = YES;
//    
//    }
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    self.navigationController.navigationBar.hidden = NO;

}

#pragma mark - 初始化UI
- (void)initlizeAppance{

    float padding = 25;
    self.title = @"登录";
//    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.298 blue:0.161 alpha:1.000];
    UILabel *userLabel = [FactoryTool factoryLabel:@"账号" color:LoginColor size:FontOfSize];
    UILabel *psdLabel = [FactoryTool factoryLabel:@"密码" color:LoginColor size:FontOfSize];
    [self.view addSubview:userLabel];
    [self.view addSubview:psdLabel];
    
    UIView *lineViewOne = [[UIView alloc] init];
    lineViewOne.backgroundColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f];
    [self.view addSubview:lineViewOne];
    
    UIView *lineViewTwo = [[UIView alloc] init];
    lineViewTwo.backgroundColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f];
    [self.view addSubview:lineViewTwo];
    
    /**开始写UI约束*/
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.width.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(self.logoImageView.mas_width).multipliedBy(ip4?0.5:0.6);
        make.width.equalTo(self.view);
    }];
    
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(padding);
//        make.top.equalTo(self.logoImageView.mas_bottom).offset(padding);
        make.top.equalTo(@150);
        make.width.height.equalTo(@40);
        
    }];
    
    [self.userField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(userLabel.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(userLabel);
        make.height.equalTo(userLabel);
    }];
    
    [lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.userField.mas_bottom).offset(8);
        make.height.equalTo(@0.5);
        make.left.equalTo(userLabel);
        make.right.equalTo(self.userField);
    }];
    
    [psdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(userLabel);
        make.top.equalTo(lineViewOne.mas_bottom).offset(padding);
        
        
    }];
    
    [self.psdField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(self.userField);
        make.top.equalTo(psdLabel);
    }];
    
    [lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.psdField.mas_bottom).offset(8);
        make.height.equalTo(@0.5);
        make.left.equalTo(psdLabel);
        make.right.equalTo(self.psdField);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(lineViewTwo);
        make.height.equalTo(@50);
        make.top.equalTo(lineViewTwo.mas_bottom).offset(padding);
    }];
//    [self.codeLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.equalTo(self.loginBtn.mas_centerX).offset(-padding-16);
//        make.top.equalTo(self.loginBtn.mas_bottom).offset(padding);
//        make.width.equalTo(@85);
//        
//    }];
    [self.forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.loginBtn.mas_right);
        make.top.width.equalTo(self.regLabel);
        
        
    }];
    
    
    [self.regLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.bottom.equalTo(self.view).offset(ip4?-padding/2:-padding);
//        
//        make.width.equalTo(self.view);
        make.left.equalTo(self.loginBtn.mas_left);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(padding);
        make.width.equalTo(@85);
    }];
    
}


#pragma mark - 登录
- (void)loginAction{
    
//    WeakSelf
    
    if (![FactoryTool isMobileNumber:self.userField.text]) {
        
         [SVProgressHUD showInfoWithStatus:@"手机号码输入错误"];
        return;
    }
    
    if (self.psdField.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
       
        return;
    }
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在登录..."];
    NSDictionary *dic = @{
                          @"type":@"login_index",
                          @"sign":[FactoryTool rendeCode],
                          @"qtime":qtime,
                          @"username":self.userField.text,
                          @"password":[FactoryTool md532BitLower:self.psdField.text],
                          @"equipment":[FactoryTool myuuid],
//                         @"password":[FactoryTool md5:self.psdField.text]
                          
                          };
//    dic  = [NSDictionary code:dic];
    NSLog(@"%@",dic);
    [HttpTool post:BaseURL params:dic success:^(id json) {
        NSLog(@"%@",json);
        NSInteger  code = [json[@"status"]integerValue];
        UserInfo *userInfo = [UserInfo sharedManager];
         [SVProgressHUD dismiss];
        switch (code) {
          
            case 1:
                {
                    [userInfo saveUserInfoData:json];
                    userInfo.payPassWord = self.psdField.text;
                    [[UIApplication sharedApplication].delegate window].rootViewController = [[RGGTabBarController alloc]init];
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
                
                }
                break;
            default:
                [SVProgressHUD showInfoWithStatus:json[@"msg"]];
                break;
        }
       
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
        
        
    }];
    
    
    
}


#pragma mark - 忘记密码
- (void)forgetAction{
    
    FindPassWordViewController *findPWDVC = [[FindPassWordViewController alloc]init];
    [self.navigationController pushViewController:findPWDVC animated:YES];;
    
    
    
}

#pragma mark - 注册
- (void)regAction{
    
    RegViewController *regVC = [[RegViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
    
}


#pragma mark - 验证码登录
- (void)codeLoginAction{
    
    CodeLoginViewController *codeVC = [[CodeLoginViewController alloc]init];
    codeVC.url = self.url;
    [self.navigationController pushViewController:codeVC animated:YES];
    
    
}


#pragma mark - 哥是懒加载


- (UIImageView *)logoImageView{
    
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
//        _logoImageView.image = [UIImage imageNamed:@"登录top"];

        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_logoImageView];
    }
    return _logoImageView;
    
    
}

- (UITextField *)userField{
    
    if (!_userField) {
        
        _userField = [FactoryTool factoryTextField:@"请输入账号" color:LoginColor size:FontOfSize - 2];
        UserInfo *userInfo = [UserInfo sharedManager];
        [userInfo getserInfoData];
        _userField.text = userInfo.phone;
        [self.view addSubview:_userField];
        
    }
    return _userField;
    
    
}
- (UITextField *)psdField{
    
    if (!_psdField) {
        
        _psdField = [FactoryTool factoryTextField:@"请输入登录密码" color:LoginColor size:FontOfSize - 2];
        _psdField.secureTextEntry = YES;
        _psdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_psdField];
        
    }
    return _psdField;
    
    
}

- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        
        _loginBtn = [FactoryTool factoryButton:@"登录" color:mycolor];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 3;
        _loginBtn.clipsToBounds = YES;
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
        
    }
    
    return _loginBtn;
    
    
}





- (UILabel *)forgetLabel{
    
    if (!_forgetLabel) {
        _forgetLabel = [FactoryTool factoryLabel:@" 忘记密码?" color:[UIColor colorWithWhite:0.369 alpha:1.000] size:15];
        _forgetLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgetAction)];
        [_forgetLabel addGestureRecognizer:tap];
        [self.view addSubview:_forgetLabel];
        
    }
    return _forgetLabel;
    
    
}

- (UILabel *)regLabel{
    
    if (!_regLabel) {
        
        _regLabel = [FactoryTool factoryLabel:@"注册" color:[UIColor colorWithWhite:0.369 alpha:1.000] size:15];
        _regLabel.userInteractionEnabled = YES;
        _regLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(regAction)];
        [_regLabel addGestureRecognizer:tap];
        [self.view addSubview:_regLabel];
        
    }
    return _regLabel;
    
    
}
//
//- (UILabel *)codeLoginLabel{
//    
//    if (!_codeLoginLabel) {
//        
//        _codeLoginLabel = [FactoryTool factoryLabel:@"验证码登录  |  " color:[UIColor colorWithWhite:0.369 alpha:1.000] size:14];
//        _codeLoginLabel.userInteractionEnabled = YES;
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeLoginAction)];
//        [_codeLoginLabel addGestureRecognizer:tap];
//        [self.view addSubview:_codeLoginLabel];
//        
//    }
//    return _codeLoginLabel;
//    
//    
//}



@end
