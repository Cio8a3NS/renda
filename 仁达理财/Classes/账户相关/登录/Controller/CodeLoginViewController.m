//
//  CodeLoginViewController.m
//  仁达
//
//  Created by 杨方军 on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "CodeLoginViewController.h"
#import "RegViewController.h"

const   float padding = 20;

@interface CodeLoginViewController (){

    NSInteger time;

}

/**顶部的大的电话号码*/
@property (strong,nonatomic)UILabel *maxPhoneNumber;

/**输入手机号*/
@property (strong,nonatomic)UITextField *phoneField;

/**验证码*/
@property (strong,nonatomic)UITextField *codeField;

/**登录按钮*/
@property (strong,nonatomic)UIButton *loginBtn;

/**立即注册*/
@property (strong,nonatomic)UILabel *regLabel;

@property (strong,nonatomic)UILabel *phoneLabel;

@property (strong,nonatomic)UILabel *codeLabel;

@property (strong,nonatomic)UIView *lineViewOne;

@property (strong,nonatomic)UIView *lineViewTwo;

@property (strong,nonatomic)UIButton *codeBtn;

@property (strong,nonatomic)NSTimer *timer;


@end

@implementation CodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initlizeAppance];
    time = 60;
}


- (void)viewWillAppear:(BOOL)animated{

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.933 green:0.298 blue:0.161 alpha:1.000]];
    self.navigationController.navigationBar.translucent = YES;
    


}


#pragma mark - 加载UI

- (void)initlizeAppance{
    
    self.title = @"验证码登录";
    
    [super initlizeAppance];
    self.phoneLabel = [FactoryTool factoryLabel:@"手机" color:LoginColor size:FontOfSize];
    self.codeLabel = [FactoryTool factoryLabel:@"验证码" color:LoginColor size:FontOfSize];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.codeLabel];
    
    self.lineViewOne = [[UIView alloc] init];
    self.lineViewOne.backgroundColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f];
    [self.view addSubview:self.lineViewOne];
    
    self.lineViewTwo = [[UIView alloc] init];
    self.lineViewTwo.backgroundColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f];
    [self.view addSubview:self.lineViewTwo];
    
    self.codeBtn = [FactoryTool factoryButton:@"发送验证码" color:[UIColor clearColor]];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.codeBtn setTitleColor:[UIColor colorWithRed:53/255.0 green:153/255.0 blue:238/255.0 alpha:1.000] forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeBtn];
    
    /**UI约束*/
    
    [self.maxPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(64);
        make.width.left.equalTo(self.view);
        if ([self maxPthoneAction].length != 0) {
            
            make.height.equalTo(@60);
            
        }
        
        
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.maxPhoneNumber.mas_bottom).offset(padding);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.phoneLabel.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.phoneLabel);
        make.height.equalTo(self.phoneLabel);
    }];
    
    [self.lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.phoneField.mas_bottom).offset(8);
        make.height.equalTo(@0.5);
        make.left.equalTo(self.phoneLabel);
        make.right.equalTo(self.phoneField);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.width.height.equalTo(self.phoneLabel);
        make.top.equalTo(self.lineViewOne.mas_bottom).offset(padding);
        
        
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.height.equalTo(self.phoneField);
        make.top.equalTo(self.codeLabel);
        make.right.equalTo(self.codeBtn.mas_left);
    }];
    
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.codeField.mas_right);
        make.right.equalTo(self.phoneField);
        make.width.equalTo(@100);
        make.height.top.equalTo(self.codeField);
        
    }];
    
    [self.lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.codeField.mas_bottom).offset(8);
        make.height.equalTo(@0.5);
        make.left.equalTo(self.codeLabel);
        make.right.equalTo(self.codeBtn);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.lineViewTwo);
        make.height.equalTo(@60);
        make.top.equalTo(self.lineViewTwo.mas_bottom).offset(padding);
    }];
    
    
    [self.regLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.centerX.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
}



#pragma mark - 登录
- (void)loginAction{
    
    WeakSelf
    if (![FactoryTool isMobileNumber:self.phoneField.text]) {
        
        [SVProgressHUD showInfoWithStatus:@"手机号码输入错误"];
        return;
    }
    if (self.codeField.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"你好像没有填写验证码"];
        return;
    }
    
    
    NSDictionary *dic = @{
                          @"mobile":self.phoneField.text,
                          @"code":self.codeField.text
                          };
//    dic  = [NSDictionary code:dic];
    
    [HttpTool post:BaseURL params:dic success:^(id json) {

        NSInteger  code = [json[@"code"]integerValue];
        NSString *msg = json[@"msg"];
        UserInfo *userInfo = [UserInfo sharedManager];
        switch (code) {
            case 200:
            {
                [userInfo saveUserInfoData:json];
                
                if (weakSelf.url) {
                    
                    //h5页面登录成功 返回到h5

                    int index = (int)self.navigationController.viewControllers.count-1;
                    index = index-2;
                    if (index<0) {
                        index = 0;
                    }
                    
                    [weakSelf.navigationController popToViewController:self.navigationController.viewControllers[index] animated:YES];
                }else{
                    
                    
//                    if (!userInfo.openLock && ![CLLockVC hasPwd] && [FactoryTool is_ShowLock]) {
//                        
//                        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
//                            
//                            /**开启手势*/
//                            userInfo.openLock = [CLLockVC hasPwd];
//                            [lockVC dismiss:0.1];
//                            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//                        }];
//                    }else{
                        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//                    }
                    
                }
                

              
                
            }
                break;
            default:
                [SVProgressHUD showInfoWithStatus:msg];
                break;
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
        
        
    }];

    
    
}


#pragma mark - 注册
- (void)regAction{
    
    RegViewController *regVC = [[RegViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
    
    
}


#pragma mark - 匹配顶部的电话号码的显示
- (NSString *)maxPthoneAction{
    
    NSString *str  = @"";
    
    NSString *isNumberStr = [self.phoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (isNumberStr.length > 0) {
        
        return str;
    }
    
    NSUInteger phoneLength = self.phoneField.text.length;
    
    
    if (phoneLength == 11) {
        
        str = [NSString stringWithFormat:@"%@-%@-%@",[self.phoneField.text substringToIndex:3],[self.phoneField.text substringWithRange:NSMakeRange(3,4)],[self.phoneField.text substringFromIndex:7]];
        
    }
    
    if (phoneLength <= 3) {
        
        str = self.phoneField.text;
        
    }
    if (phoneLength < 7 && phoneLength > 3) {
        NSString *str1 = [self.phoneField.text substringToIndex:3];
        NSString *str2 = [self.phoneField.text substringWithRange:NSMakeRange(3,self.phoneField.text.length-3)];
        str = [NSString stringWithFormat:@"%@-%@",str1,str2];
        
    }
    
    if (phoneLength <= 11 && phoneLength >= 7) {
        
        NSString *str1 = [self.phoneField.text substringToIndex:3];
        NSString *str2 = [self.phoneField.text substringWithRange:NSMakeRange(3,4)];
        NSString *str3 = [self.phoneField.text substringWithRange:NSMakeRange(7,self.phoneField.text.length-7)];
        str= [NSString stringWithFormat:@"%@-%@-%@",str1,str2,str3];
        
    }
    
    if (phoneLength > 11) {
        
        NSString *str1 = [self.phoneField.text substringToIndex:3];
        NSString *str2 = [self.phoneField.text substringWithRange:NSMakeRange(3,4)];
        NSString *str3 = [self.phoneField.text substringWithRange:NSMakeRange(7,self.phoneField.text.length-7)];
        str= [NSString stringWithFormat:@"%@-%@-%@",str1,str2,str3];
        str = [str substringToIndex:13];
        
    }
    
    
    return str;
    
    
}


#pragma mark - 电话号码输入框属性发送变化
- (void)phoneNumberChange{
    
    self.maxPhoneNumber.text = [self maxPthoneAction];
    
    [self.maxPhoneNumber mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(64);
        make.width.equalTo(self.view);
        if (self.maxPhoneNumber.text.length == 0) {
            
            make.height.equalTo(@0);
        }else{
            
            make.height.equalTo(@80);
            
        }
        
        make.bottom.equalTo(self.phoneLabel.mas_top);
        
    }];
    
    [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.maxPhoneNumber.mas_bottom).offset(padding);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        
    }];
    
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}


- (void)getCode{

    
    if (![FactoryTool isMobileNumber:self.phoneField.text]) {
        
        [SVProgressHUD showInfoWithStatus:@"手机号码输入错误"];
        return;
        
    }
    
    WeakSelf
    NSDictionary *dic = @{@"mobile":self.phoneField.text};
//    dic  = [NSDictionary code:dic];
    
    [HttpTool post:[NSString stringWithFormat:@"%@sms/login.json",BaseURL] params:dic success:^(id json) {
        if ([json[@"code"]integerValue] == 200) {
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
            weakSelf.timer.fireDate = [NSDate distantPast];
            weakSelf.codeBtn.enabled = NO;
        }
        else{
          [SVProgressHUD showInfoWithStatus:json[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
        
    }];

}

- (void)codeAction{
    
    WeakSelf;

    [weakSelf.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒重试",(long)time--] forState:UIControlStateNormal];
    
    if (time <= 1 ) {
        self.codeBtn.enabled = YES;
        self.timer.fireDate = [NSDate distantFuture];
        self.timer = nil;
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        time = 60;
        
    }
    
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    self.timer.fireDate = [NSDate distantFuture];
    self.timer = nil;
    
}



#pragma mark - 哥是懒加载

- (UITextField *)phoneField{
    
    if (!_phoneField) {
        
        _phoneField = [FactoryTool factoryTextField:@"手机号" color:LoginColor size:FontOfSize - 2];
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneField addTarget:self action:@selector(phoneNumberChange) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_phoneField];
        
    }
    return _phoneField;
    
    
}
- (UITextField *)codeField{
    
    if (!_codeField) {
        
        _codeField = [FactoryTool factoryTextField:@"请输入验证码" color:LoginColor size:FontOfSize - 2];
        _codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_codeField];
        
    }
    return _codeField;
    
    
}

- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        
        _loginBtn = [FactoryTool factoryButton:@"登录" color:GLOBALCOLOR(245, 98, 54)];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 3;
        _loginBtn.clipsToBounds = YES;
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
        
    }
    
    return _loginBtn;
    
    
}






- (UILabel *)regLabel{
    
    if (!_regLabel) {
        
        _regLabel = [FactoryTool factoryLabel:@"注册 >" color:[UIColor colorWithRed:0.200 green:0.545 blue:0.925 alpha:1.000] size:14];
        _regLabel.userInteractionEnabled = YES;
        _regLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(regAction)];
        [_regLabel addGestureRecognizer:tap];
        [self.view addSubview:_regLabel];
        
    }
    return _regLabel;
    
    
}

- (UILabel *)maxPhoneNumber{
    
    if (!_maxPhoneNumber) {
        
        NSString *str = [self maxPthoneAction];
        
        _maxPhoneNumber = [FactoryTool factoryLabel:str color:[UIColor colorWithWhite:0.110 alpha:1.000] size:24];
        _maxPhoneNumber.userInteractionEnabled = YES;
        _maxPhoneNumber.textAlignment = NSTextAlignmentCenter;
        //        _maxPhoneNumber.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_maxPhoneNumber];
        
    }
    return _maxPhoneNumber;
    
    
}



- (NSTimer *)timer{
    
    if (!_timer) {
        
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(codeAction) userInfo:nil repeats:YES];
    }
    return _timer;
    
}




- (void)dealloc{





}




@end
