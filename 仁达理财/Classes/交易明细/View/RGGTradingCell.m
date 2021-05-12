//
//  RGGTradingCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/19.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGTradingCell.h"
#import "RGGTradingContentModel.h"
#define margin 20
@interface RGGTradingCell()<UIAlertViewDelegate>
@property(nonatomic, strong)UILabel *numtitleLable;
@property(nonatomic, strong)UILabel *ratioLable;
@property(nonatomic, strong)UIImageView *newpersonImageView;
@property(nonatomic, strong)UIButton *joinBtn;
@end


@implementation RGGTradingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.numtitleLable];
        [self.contentView addSubview:self.joinBtn];
        [self.contentView addSubview:self.ratioLable];
        [self.ratioLable addSubview:self.newpersonImageView];
       
        
    }
    return self;
}


- (void)setTradingModel:(RGGTradingModel *)tradingModel{

    _tradingModel = tradingModel;
    
    
    
    [self loadContraint];
    
    [self setCellUI];

}

- (void)setProductDic:(NSMutableDictionary *)productDic{
    _productDic = productDic;
    
    if ([[_productDic objectForKey:@"day_number"]integerValue] !=0) {
          [_joinBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            _joinBtn.backgroundColor = mycolor;
           _joinBtn.enabled = YES;
    }
    else{
         [_joinBtn setTitle:@"已抢完" forState:UIControlStateNormal];
        _joinBtn.backgroundColor = [UIColor lightGrayColor];
        _joinBtn.enabled = NO;
    }
    
}

//- (void)setSecNum:(NSInteger)secNum{
//    _secNum = secNum;
//
//}

- (void)loadContraint{
    
   [_numtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.equalTo(self).offset(margin);
       make.size.mas_equalTo(CGSizeMake(screenWidth - 2 * margin, margin));
   }];
    [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(- 2*margin);
        make.trailing.equalTo(self).offset(- margin);
        make.size.mas_equalTo(CGSizeMake(80, 1.5*margin));
    }];
    [_ratioLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numtitleLable.mas_bottom).offset(2*margin);
        make.centerX.equalTo(_joinBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 2*margin));
    }];
    [_newpersonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-margin);
        make.centerY.equalTo(_ratioLable.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    

}

- (void)setCellUI{
    _numtitleLable.text = _tradingModel.numtitle;
    _ratioLable.text = _tradingModel.ratio;
    NSArray *colorArray = @[GLOBALCOLOR(247, 122, 126),GLOBALCOLOR(252, 195, 39),GLOBALCOLOR(137, 221, 189),GLOBALCOLOR(74, 156, 235)];
    for (int i=0; i<_tradingModel.contentArray.count; i++) {
        //content
        
        RGGTradingContentModel *tradingContentModel = _tradingModel.contentArray[i];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2 * margin+5, 3*margin+40*i, screenWidth - 4 * margin, 40)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14.];
        label.text = tradingContentModel.num;
        [self.contentView addSubview:label];
        
        //数字
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(margin, 3*margin+40*i+12, 16, 16)];
        
       
        backView.backgroundColor = colorArray[i];
        backView.layer.cornerRadius = 8;
        [self.contentView addSubview:backView];
        
    }
    
    if (![_tradingModel.newpersontag integerValue]) {
        self.newpersonImageView.hidden =YES;
    }
    
    
}

- (UILabel *)numtitleLable{
    if (_numtitleLable == nil) {
        _numtitleLable = [[UILabel alloc]init];
        _numtitleLable.font = [UIFont systemFontOfSize:15.];
        _numtitleLable.textColor = mycolor;
        
    }
    return _numtitleLable;
}
- (UILabel *)ratioLable{
    if (_ratioLable == nil) {
        _ratioLable = [[UILabel alloc]init];
        _ratioLable.textColor = mycolor;
        _ratioLable.font = [UIFont systemFontOfSize:25.];
      
    }
    return _ratioLable;
}

- (UIButton *)joinBtn{
    if (_joinBtn == nil) {
        _joinBtn = [[UIButton alloc]init];
        _joinBtn.backgroundColor = mycolor;
        _joinBtn.layer.cornerRadius = 10;
        _joinBtn.titleLabel.font = [UIFont systemFontOfSize:14.];
//        _joinBtn.clipsToBounds = YES;
        [_joinBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [[_joinBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"请输入充值金额" message:@"每份价格100元" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交申购",nil];
            [dialog setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
            [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
            [[dialog textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeDefault];
            [[dialog textFieldAtIndex:0] setPlaceholder:@"请输入购买份数"];
            [[dialog textFieldAtIndex:1] setPlaceholder:@"请输入交易密码"];
            [dialog show];
            
        }];
    }
    return _joinBtn;
}

- (UIImageView *)newpersonImageView{
    if (_newpersonImageView == nil) {
        _newpersonImageView = [[UIImageView alloc]init];
        _newpersonImageView.image = [UIImage imageNamed:@"新人专享"];
    }
    return _newpersonImageView;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex ==0) {
        return;
    }
    switch ([[_productDic objectForKey:@"day"]integerValue]) {
        case 6:
            _secNum = 1;
            break;
        case 10:
            _secNum = 2;
            break;
        case 14:
            _secNum = 3;
            break;
        case 18:
            _secNum = 4;
            break;
        default:
            break;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交申购..."];
    UITextField *txt = [alertView textFieldAtIndex:0];
    UITextField *txt1 = [alertView textFieldAtIndex:1];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_buyproduct";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    parameters[@"money"] = txt.text;
    parameters[@"product_id"] = @(_secNum);
//    parameters[@"pay_password"] = @"123456";
     parameters[@"pay_password"] = [FactoryTool md532BitLower:txt1.text];
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            [SVProgressHUD showInfoWithStatus:@"恭喜你,成功购买!"];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"提交申购失败"];
        NSLog(@"error%@",error);
    }];
}


@end
