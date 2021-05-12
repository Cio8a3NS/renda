//
//  RGGFixedIncomeCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/23.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGFixedCell.h"
#import "RGGTransactionManagementController.h"
#define margin 10
@interface RGGFixedCell()
@property(nonatomic ,strong)UIImageView *tianshuImageView;
@property(nonatomic ,strong)UILabel *touzieduLable;
@property(nonatomic ,strong)UILabel *leijishijianLable;
@property(nonatomic ,strong)UILabel *leijishouyiLable;
@property(nonatomic ,strong)UILabel *goumaitime;
@property(nonatomic ,strong)UILabel *daoqitime;
@property(nonatomic ,strong)UILabel *touzhizhongLable;
@property(nonatomic ,strong)UIButton *tikuanBtn;
@end
@implementation RGGFixedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         [self addSubview:self.tianshuImageView];
         [self addSubview:self.touzieduLable];
         [self addSubview:self.leijishijianLable];
         [self addSubview:self.leijishouyiLable];
         [self addSubview:self.touzhizhongLable];
         [self addSubview:self.goumaitime];
         [self addSubview:self.daoqitime];
         [self addSubview:self.tikuanBtn];
        [self loadContrains];
    
    }
    return self;
}


- (void)setFixIncomeModel:(RGGFixIncomeModel *)fixIncomeModel{
    _fixIncomeModel = fixIncomeModel;
    
    [self refreshUI];

}


- (void)refreshUI{
    
    //天数图片显示
    
    switch ([_fixIncomeModel.product_id integerValue]) {
        case 1:
            self.tianshuImageView.image = [UIImage imageNamed:@"6天"];
            break;
        case 2:
            self.tianshuImageView.image = [UIImage imageNamed:@"10"];
            break;
        case 3:
            self.tianshuImageView.image = [UIImage imageNamed:@"14"];
            break;
        case 4:
            self.tianshuImageView.image = [UIImage imageNamed:@"18"];
            break;
        default:
            
            break;
    }
    
    //投资额度
    self.touzieduLable.text = [NSString stringWithFormat:@"投资额度 ￥%@元",_fixIncomeModel.money];
    //累计时间
    self.leijishijianLable.text = [NSString stringWithFormat:@"累计时间 %@天",_fixIncomeModel.day];
    //累计收益
    self.leijishouyiLable.text = [NSString stringWithFormat:@"累计收益 ￥%ld元",(long)_fixIncomeModel.shouyi.integerValue];
    
    self.goumaitime.text = [NSString stringWithFormat:@"购买时间 %@",[NSString timeToDate:_fixIncomeModel.create_time.floatValue]];
    
    self.daoqitime.text = [NSString stringWithFormat:@"到期时间 %@",[NSString timeToDate:_fixIncomeModel.guoqi_time.floatValue]];
    
    //
    
    switch (_fixIncomeModel.status.integerValue) {
        case 0:
            self.tikuanBtn.enabled = YES;
            self.touzhizhongLable.text = @"投资中";
            [self.tikuanBtn setTitle:@"提款" forState:UIControlStateNormal];
            [self.tikuanBtn addTarget:self action:@selector(zhanghutixianVC) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [self.tikuanBtn setTitle:@"已收益" forState:UIControlStateNormal];
            [self.tikuanBtn setBackgroundColor:[UIColor grayColor]];
            self.tikuanBtn.enabled = NO;
            break;
        case 2:
            self.tikuanBtn.enabled = NO;
            [self.tikuanBtn setTitle:@"已提现" forState:UIControlStateNormal];
            [self.tikuanBtn setBackgroundColor:[UIColor grayColor]];
            self.tikuanBtn.enabled = NO;
            break;
        default:
            break;
    }

}

- (void)zhanghutixianVC{
//    RGGTransactionManagementController  *TransactionManagementVC = [[RGGTransactionManagementController alloc]init];
//    [[self viewController].navigationController pushViewController:TransactionManagementVC animated:YES];
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"请输入支付密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提现",nil];
    [dialog setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    
    [dialog show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        UITextField *txt = [alertView textFieldAtIndex:0];
        if (txt.text.length ==0) {
            return;
        }
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"type"] = @"jinniubi_yingji";
        parameters[@"sign"] = [FactoryTool rendeCode];
        parameters[@"qtime"] = qtime;
        parameters[@"equipment"] = [FactoryTool myuuid];
        parameters[@"pay_password"] = [FactoryTool md532BitLower:txt.text];
        parameters[@"id"] = _fixIncomeModel.id;
        NSLog(@"%@",parameters);
        [HttpTool post:BaseURL params:parameters success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"status"]integerValue] == 1) {
              
                [self.tikuanBtn setTitle:@"已提现" forState:UIControlStateNormal];
                [self.tikuanBtn setBackgroundColor:[UIColor grayColor]];
                self.tikuanBtn.enabled = NO;
                self.touzhizhongLable.hidden = YES;
                [SVProgressHUD showInfoWithStatus:@"提现成功!"];
            }
            else{
                [SVProgressHUD showInfoWithStatus:json[@"msg"]];
                
            }
            //
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:@"提现失败!"];
            NSLog(@"error%@",error);
        }];
        
    }
    
}



- (void)loadContrains{
    
    [_tianshuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@margin);
        make.size.mas_equalTo(CGSizeMake(65, 52));
        
    }];
    
    [_touzieduLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(2*margin);
        make.left.equalTo(_tianshuImageView.mas_right).offset(margin);
        make.size.mas_equalTo(CGSizeMake(screenWidth -180, 30));
        
    }];
   
    [_leijishijianLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_touzieduLable.mas_bottom);
        make.left.equalTo(_touzieduLable.mas_left);
        make.size.mas_equalTo(_touzieduLable);
    }];
    [_leijishouyiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leijishijianLable.mas_bottom);
        make.left.equalTo(_touzieduLable.mas_left);
        make.size.mas_equalTo(_touzieduLable);
    }];
    [_goumaitime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leijishouyiLable.mas_bottom);
        make.left.equalTo(_touzieduLable.mas_left);
        make.size.mas_equalTo(_touzieduLable);
    }];
    
    [_daoqitime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goumaitime.mas_bottom);
        make.left.equalTo(_touzieduLable.mas_left);
        make.size.mas_equalTo(_touzieduLable);
    }];
    
    [_touzhizhongLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_touzieduLable);
        make.trailing.equalTo(self.mas_trailing).offset(-margin);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        
    }];
    [_tikuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-margin);
        make.top.equalTo(_daoqitime.mas_top);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}

- (UIImageView *)tianshuImageView{
    if (_tianshuImageView == nil) {
        _tianshuImageView = [[UIImageView alloc]init];
    }
    return _tianshuImageView;
    
}
- (UILabel *)leijishijianLable{
    if (_leijishijianLable== nil) {
        _leijishijianLable = [[UILabel alloc]init];
        _leijishijianLable.font = [UIFont systemFontOfSize:14.0f];
    }
    return _leijishijianLable;
    
}
- (UILabel *)touzieduLable{
    if (_touzieduLable == nil) {
        _touzieduLable = [[UILabel alloc]init];
         _touzieduLable.font = [UIFont systemFontOfSize:14.0f];
    }
    return _touzieduLable;

}

- (UILabel *)leijishouyiLable{
    if (_leijishouyiLable == nil) {
        _leijishouyiLable = [[UILabel alloc]init];
        _leijishouyiLable.font = [UIFont systemFontOfSize:14.0f];
        
    }
    return _leijishouyiLable;
    
}
- (UILabel *)goumaitime{
    if (_goumaitime == nil) {
        _goumaitime = [[UILabel alloc]init];
        _goumaitime.font = [UIFont systemFontOfSize:14.0f];
        
    }
    return _goumaitime;
    
}
- (UILabel *)daoqitime{
    if (_daoqitime == nil) {
        _daoqitime = [[UILabel alloc]init];
        _daoqitime.font = [UIFont systemFontOfSize:14.0f];
        
    }
    return _daoqitime;
    
}
- (UILabel *)touzhizhongLable{
    if (_touzhizhongLable == nil) {
        _touzhizhongLable = [[UILabel alloc]init];
        _touzhizhongLable.textColor = [UIColor redColor];
        _touzhizhongLable.textAlignment = NSTextAlignmentCenter;
        _touzhizhongLable.font = [UIFont systemFontOfSize:14];
    }
    return _touzhizhongLable;
}
- (UIButton *)tikuanBtn{
    if (_tikuanBtn == nil) {
        _tikuanBtn = [[UIButton alloc]init];
        [_tikuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tikuanBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _tikuanBtn.layer.cornerRadius = 10;
         [_tikuanBtn setTitle:@"提款" forState:UIControlStateNormal];
        _tikuanBtn.backgroundColor = mycolor;
    }
    return _tikuanBtn;
}
@end
