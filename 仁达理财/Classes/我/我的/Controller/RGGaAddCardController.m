//
//  RGGaAddCardController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/18.
//  Copyright © 2016年 六点科技. All rights reserved.
//
#define margin 20
#import "RGGaAddCardController.h"
#import "HcdActionSheet.h"
#import "RGGTextFiled.h"
#import "MMPickerView.h"
@interface RGGaAddCardController ()<UITextFieldDelegate>

@property (strong, nonatomic)UILabel *typeLable;
@property (strong, nonatomic)UILabel *bankNameLable;
@property (strong, nonatomic)RGGTextFiled *cardNumFiled;

@property (strong, nonatomic)RGGTextFiled *zhifubaoFiled;
@property (strong, nonatomic)RGGTextFiled *weixinnichengFiled;
@property (strong, nonatomic)RGGTextFiled *weixinAccountFiled;
@property (strong, nonatomic)UIButton *submitBtn;
@property (nonatomic, strong) NSArray *banksArray;
@property (nonatomic, strong) NSString * selectedString;
@property (nonatomic, assign) NSInteger selectedBankid;
@property (nonatomic, strong) NSArray *objectsArray;
@property (nonatomic, assign) id selectedObject;
@end

@implementation RGGaAddCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI{
    self.view.backgroundColor = GLOBALCOLOR(254, 255, 255);
    self.title = @"添加";
    [self.view addSubview:self.typeLable];
    [self.view addSubview:self.bankNameLable];
    [self.view addSubview:self.cardNumFiled];
    [self.view addSubview:self.zhifubaoFiled];
    [self.view addSubview:self.weixinnichengFiled];
    [self.view addSubview:self.weixinAccountFiled];
    
    [self.view addSubview:self.submitBtn];
    self.banksArray = @[@"中国工商银行",@"中国农业银行",@"中国建设银行",@"中国银行",@"民生银行",@"广发银行",@"浦发银行",@"交通银行",@"中信银行",@"北京银行",@"渤海银行",@"其他银行"];
    _objectsArray = [NSArray arrayWithObjects: @"hello", @14, @13.3, @"Icecream", @1,  nil];
    
    _selectedObject = [_objectsArray objectAtIndex:0];
    _selectedString = [_banksArray objectAtIndex:0];
    [self loadContriants:1];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cardNumFiled resignFirstResponder];
}

- (void)loadContriants:(NSInteger)index{
    [_typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(margin);
        make.trailing.equalTo(self.view).offset(-margin);
        make.size.mas_equalTo(CGSizeMake(screenWidth-2*margin, 50));
        
    }];
  
    if (index == 1) {
        [_bankNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_typeLable.mas_bottom).offset(margin);
            make.trailing.left.height.equalTo(_typeLable);
            
        }];
        [_cardNumFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bankNameLable.mas_bottom).offset(margin);
            make.trailing.left.height.equalTo(_typeLable);
            
        }];
        
        
        
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_cardNumFiled.mas_bottom).offset(margin);
            make.width.equalTo(@(screenWidth-2*margin));
            make.height.equalTo(_cardNumFiled.mas_height);
            make.left.equalTo(_cardNumFiled.mas_left);
        }];
    }
    else if (index == 2){
        [_zhifubaoFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_typeLable.mas_bottom).offset(margin);
            make.trailing.left.height.equalTo(_typeLable);
            
        }];
        
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_zhifubaoFiled.mas_bottom).offset(margin);
            make.width.equalTo(@(screenWidth-2*margin));
            make.height.equalTo(_zhifubaoFiled.mas_height);
            make.left.equalTo(_zhifubaoFiled.mas_left);
        }];
        
    }
     else if (index == 3){
        [_weixinnichengFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_typeLable.mas_bottom).offset(margin);
            make.trailing.left.height.equalTo(_typeLable);
            
        }];
        [_weixinAccountFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_weixinnichengFiled.mas_bottom).offset(margin);
            make.trailing.left.height.equalTo(_typeLable);
            
        }];
    
        
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_weixinAccountFiled.mas_bottom).offset(margin);
            make.width.equalTo(@(screenWidth-2*margin));
            make.height.equalTo(_weixinnichengFiled.mas_height);
            make.left.equalTo(_weixinnichengFiled.mas_left);
        }];
        
    }
    
   
}



- (void)tapSelectBankLable:(UITapGestureRecognizer *)tap{
    
    [MMPickerView showPickerViewInView:self.view
                           withStrings:_banksArray
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:_selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                
                            _bankNameLable.text = [NSString stringWithFormat:@" %@",selectedString];
                            _selectedString = selectedString;
                            for (int i=0; i<self.banksArray.count; i++) {
                                if ([_selectedString isEqualToString:self.banksArray[i]]) {
                                    _selectedBankid = i+1;
                                 }
                                }
                            }];
    
}

- (void)tapPayTypeLable:(UITapGestureRecognizer *)tap{
    HcdActionSheet *sheet = [[HcdActionSheet alloc] initWithCancelStr:nil
                                                    otherButtonTitles:@[@"银行卡",@"支付宝",@"微信"]
                                                          attachTitle:nil];
    sheet.selectButtonAtIndex = ^(NSInteger index) {
    [self loadContriants:index];
        switch (index) {
            case 1:
                _cardNumFiled.hidden = NO;
                _bankNameLable.hidden = NO;
                _weixinAccountFiled.hidden = YES;
                 _weixinnichengFiled.hidden = YES;
                 _zhifubaoFiled.hidden = YES;
                break;
            case 2:
                _cardNumFiled.hidden = YES;
                _bankNameLable.hidden = YES;
                _weixinAccountFiled.hidden = YES;
                _weixinnichengFiled.hidden = YES;
                _zhifubaoFiled.hidden = NO;
                break;
            case 3:
                _cardNumFiled.hidden = YES;
                _bankNameLable.hidden = YES;
                _weixinAccountFiled.hidden = NO;
                _weixinnichengFiled.hidden = NO;
                _zhifubaoFiled.hidden = YES;
                break;
            default:
                break;
        }
        
    _typeLable.text = index == 1?@" 银行卡":index == 2?@" 支付宝":@" 微信";

    };
    [[UIApplication sharedApplication].keyWindow addSubview:sheet];
    [sheet showHcdActionSheet];
}
#pragma mark - 懒加载

- (UILabel *)typeLable{
    if (!_typeLable) {
        _typeLable = [[UILabel alloc]init];
       
        _typeLable.layer.borderWidth = 1;
        _typeLable.layer.cornerRadius = 5;
        _typeLable.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
        
        _typeLable.textColor = [UIColor blackColor];
        _typeLable.text = @" 银行卡";
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPayTypeLable:)];
//        _typeLable.userInteractionEnabled = YES;
//        [_typeLable addGestureRecognizer:tap];
        
    }
    return _typeLable;
}


- (UILabel *)bankNameLable{
    if (!_bankNameLable) {
        _bankNameLable = [[UILabel alloc]init];
        _bankNameLable.layer.borderWidth = 1;
        _bankNameLable.layer.cornerRadius = 5;
        _bankNameLable.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
        _bankNameLable.text = @" 请选择银行";
        UITapGestureRecognizer *tapSelectBankLable = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelectBankLable:)];
        _bankNameLable.userInteractionEnabled = YES;
        [_bankNameLable addGestureRecognizer:tapSelectBankLable];
//         _nameFiled.enabled = NO;
        
    }
    return _bankNameLable;
}
//
- (UITextField *)cardNumFiled{
    if (!_cardNumFiled) {
        _cardNumFiled = [[RGGTextFiled alloc]init];
        _cardNumFiled.layer.borderWidth = 1;
        _cardNumFiled.layer.cornerRadius = 5;
        _cardNumFiled.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;

        [_cardNumFiled setPlaceholder:@"请输入银行卡号"];
    }
    return _cardNumFiled;
}

- (UITextField *)zhifubaoFiled{
    if (!_zhifubaoFiled) {
        _zhifubaoFiled = [[RGGTextFiled alloc]init];
        _zhifubaoFiled.layer.borderWidth = 1;
        _zhifubaoFiled.layer.cornerRadius = 5;
        _zhifubaoFiled.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
        
        [_zhifubaoFiled setPlaceholder:@"请输入支付宝账号"];
    }
    return _zhifubaoFiled;
}
- (UITextField *)weixinnichengFiled{
    if (!_weixinnichengFiled) {
        _weixinnichengFiled = [[RGGTextFiled alloc]init];
        _weixinnichengFiled.layer.borderWidth = 1;
        _weixinnichengFiled.layer.cornerRadius = 5;
        _weixinnichengFiled.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
        
        [_weixinnichengFiled setPlaceholder:@"请输入微信昵称"];
    }
    return _weixinnichengFiled;
}
- (UITextField *)weixinAccountFiled{
    if (!_weixinAccountFiled) {
        _weixinAccountFiled = [[RGGTextFiled alloc]init];
        _weixinAccountFiled.layer.borderWidth = 1;
        _weixinAccountFiled.layer.cornerRadius = 5;
        _weixinAccountFiled.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
        
        [_weixinAccountFiled setPlaceholder:@"请输入支微信账号"];
    }
    return _weixinAccountFiled;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = GLOBALCOLOR(52, 129, 228);
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 20;
  
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
      
    }
    return _submitBtn;
}


-(void)submit:(id)sender{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"user_addbank";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
    parameters[@"equipment"] = [FactoryTool myuuid];
    parameters[@"banktype"] = @(2);
    parameters[@"bankid"] = @(_selectedBankid);
    parameters[@"account"] = _cardNumFiled.text;
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
             [SVProgressHUD showInfoWithStatus:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
//            block([RGGVipBuyModel mj_objectArrayWithKeyValuesArray:json[@"data"]]);
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];

}



@end
