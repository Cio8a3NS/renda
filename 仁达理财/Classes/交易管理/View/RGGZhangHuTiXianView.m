//
//  RGGZhangHuTiXianView.m
//  仁达理财
//
//  Created by wangdong on 16/8/26.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGZhangHuTiXianView.h"
#define margin 40
@interface RGGZhangHuTiXianView()
@property(nonatomic, strong)UILabel *tipLable;

@property(nonatomic, strong)UITextField *moneyTextFeild;
@property(nonatomic, strong)UITextField *passWordTextFeild;
@property(nonatomic, strong)UIButton *tixianBtn;
@property(nonatomic, assign)CGFloat yue;
@end

@implementation RGGZhangHuTiXianView


- (void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.tipLable];
    [self addSubview:self.moneyTextFeild];
    [self addSubview:self.passWordTextFeild];
    [self addSubview:self.tixianBtn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shousuojinapan)];
    [self addGestureRecognizer:tap];
    [self loadContraint];
}

- (void)shousuojinapan{
    [self.moneyTextFeild resignFirstResponder];
    [self.passWordTextFeild resignFirstResponder];
}

- (void)setZhanghuyue:(NSString *)zhanghuyue{

    _zhanghuyue = zhanghuyue;
    
    self.yue = _zhanghuyue.floatValue;
    [self refreshtipLable];
}

- (void)loadContraint{
    [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@margin);
        make.trailing.equalTo(@-margin);
        make.height.equalTo(@40);
        
    }];
    
    [_moneyTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLable.mas_bottom).offset(20);
        make.left.equalTo(@margin);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2*margin, 40));
        
    }];
    [_passWordTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyTextFeild.mas_bottom).offset(20);
        make.left.equalTo(@margin);
        make.size.mas_equalTo(_moneyTextFeild);
        
    }];
    [_tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passWordTextFeild.mas_bottom).offset(20);
        make.left.equalTo(@margin);
        make.size.mas_equalTo(_moneyTextFeild);
        
    }];


}

- (void)refreshtipLable{
    _tipLable.text = [NSString stringWithFormat:@"当前账户余额 %@(注:提现金额为100的整数倍)",_zhanghuyue];
}

- (UILabel *)tipLable{
    if (_tipLable == nil) {
        _tipLable = [[UILabel alloc]init];
        _tipLable.textColor = [UIColor redColor];
       
        _tipLable.font = [UIFont systemFontOfSize:14.0f];
        _tipLable.lineBreakMode = NSLineBreakByCharWrapping;
        _tipLable.numberOfLines = 0;
    }
    return _tipLable;

}
- (UITextField *)moneyTextFeild{
    if (_moneyTextFeild == nil) {
        _moneyTextFeild = [[UITextField alloc]init];
        _moneyTextFeild.layer.borderWidth = 1;
        _moneyTextFeild.layer.cornerRadius = 5;
        _moneyTextFeild.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
        [_moneyTextFeild setPlaceholder:@"请输入金额"];
    }
    return _moneyTextFeild;
    
}
- (UITextField *)passWordTextFeild{
    if (_passWordTextFeild == nil) {
        _passWordTextFeild = [[UITextField alloc]init];
        _passWordTextFeild.layer.borderWidth = 1;
        _passWordTextFeild.layer.cornerRadius = 5;
        _passWordTextFeild.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
        self.passWordTextFeild.secureTextEntry = YES;
        [_passWordTextFeild setPlaceholder:@"请输入密码"];
    }
    return _passWordTextFeild;
    
}

- (UIButton *)tixianBtn{
    if (_tixianBtn == nil) {
        _tixianBtn = [[UIButton alloc]init];
        [_tixianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_tixianBtn setTitle:@"提现" forState:UIControlStateNormal];
        _tixianBtn.backgroundColor = mycolor;
        _tixianBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_tixianBtn addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _tixianBtn;
}

- (void)tixian{
    [SVProgressHUD showWithStatus:@"正在提现..."];
//    if (_zhanghuyue.floatValue - _moneyTextFeild.text.floatValue<0) {
//        [SVProgressHUD showInfoWithStatus:@"提现金额大于账户现有金额!!!"];
//        return;
//    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_tixian";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    parameters[@"money"] = _moneyTextFeild.text;
    parameters[@"pay_password"] = [FactoryTool md532BitLower:_passWordTextFeild.text];

    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            self.yue = self.yue -  _moneyTextFeild.text.floatValue - 10;
             _tipLable.text = [NSString stringWithFormat:@"当前账户余额 %.2lf(注:提现金额为100的整数倍)",self.yue];
            [SVProgressHUD showInfoWithStatus:@"提现成功"];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"error%@",error);
    }];


}


@end
