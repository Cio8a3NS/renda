//
//  RGGMeHeaderView.m
//  仁达理财
//
//  Created by yuanmc on 16/8/17.
//  Copyright © 2016年 六点科技. All rights reserved.
//
#define margin 20
#import "RGGMeHeaderView.h"
#import "RGGMyAssetsViewModel.h"
#import "LoginViewController.h"
@interface RGGMeHeaderView()
/**头像*/
@property(nonatomic, copy)UIImageView *headImgView;
/**箭头*/
@property(nonatomic, copy)UIImageView *arrowImgView;
/**分割线1*/
@property(nonatomic, copy)UIView *dividingline1;
/**分割线2*/
@property(nonatomic, copy)UIView *dividingline2;
/**分割线3*/
@property(nonatomic, copy)UIView *dividingline3;
/**编号*/
@property(nonatomic, copy)UILabel *numLable;
/**名字*/
@property(nonatomic, copy)UILabel *nameLable;
/**总收益lable*/
@property(nonatomic, copy)UILabel *totalRevenue;
/**固定收益lable*/
@property(nonatomic, copy)UILabel *fixedIncome;
/**佣金lable*/
@property(nonatomic, copy)UILabel *commission;
/**总收益金额*/
@property(nonatomic, copy)UILabel *totalRevenueNum;
/**固定收益金额*/
@property(nonatomic, copy)UILabel *fixedIncomeNum;
/**佣金金额*/
@property(nonatomic, copy)UILabel *commissionNum;

@property(nonatomic, copy)UIButton *extBtn;
@property(nonatomic, strong)RGGMyAssetsViewModel *assetsViewModel;

@end

@implementation RGGMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
    [self addSubview:self.headImgView];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.numLable];
    [self addSubview:self.nameLable];
    [self addSubview:self.totalRevenue];
    [self addSubview:self.fixedIncome];
    [self addSubview:self.commission];
    [self addSubview:self.totalRevenueNum];
    [self addSubview:self.fixedIncomeNum];
    [self addSubview:self.commissionNum];
    [self addSubview:self.dividingline1];
    [self addSubview:self.dividingline2];
    [self addSubview:self.dividingline3];
     [self addSubview:self.extBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI:) name:@"refreshMeHeader" object:nil];
        
    [self loadContriant];
//    [self.assetsViewModel getMyAssetsInfo:^(id json) {
//            
//        _assetsModel = json;
//        [self refreshUI];
//        }];
    }
    return self;
}

//- (void)setAssetsModel:(RGGAssetsModel *)assetsModel{
//    _assetsModel = assetsModel;
//     [self refreshUI];
//}

- (void)refreshUI:(NSNotification*)notification{
    RGGAssetsModel *assetModel = [notification object];
    self.totalRevenueNum.text = assetModel.zongShouyi;
    self.fixedIncomeNum.text = assetModel.gudingShouyi;
    self.commissionNum.text = assetModel.yongjinShouyi;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:@"http://www.czhsj.com/Public/pank/ai/nan.jpg"] placeholderImage:nil];
}

//- (RGGMyAssetsViewModel *)assetsViewModel{
//    if (_assetsViewModel == nil) {
//        _assetsViewModel = [[RGGMyAssetsViewModel alloc]init];
//    }
//    return _assetsViewModel;
//}


#pragma mark - 约束
- (void)loadContriant{
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(margin);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-margin);
        make.centerY.mas_equalTo(_headImgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImgView.mas_right).offset(margin/2.0);
        make.bottom.mas_equalTo(_headImgView.mas_bottom).offset(-margin/4.0);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImgView.mas_right).offset(margin/2.0);
        make.top.mas_equalTo(_headImgView.mas_top).offset(margin/4.0);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [_dividingline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.equalTo(@margin);
        make.size.mas_equalTo(CGSizeMake(screenWidth - 2*margin, 0.5));
    }];
    [_totalRevenue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(_dividingline1.mas_bottom).offset(margin);
        make.size.mas_equalTo(CGSizeMake((screenWidth-1)/3.0, 30));
    }];
    [_totalRevenueNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_totalRevenue.mas_left);
        make.size.mas_equalTo(_totalRevenue);
        make.bottom.mas_equalTo(self).offset(-margin);
    }];
    [_dividingline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_totalRevenue.mas_right);
        make.top.mas_equalTo(_totalRevenue.mas_top);
        make.size.mas_equalTo(CGSizeMake(0.5, 100 - 2*margin));
    }];

    [_fixedIncome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dividingline2.mas_right);
        make.size.mas_equalTo(_totalRevenue);
        make.top.mas_equalTo(_totalRevenue.mas_top);
    }];
    [_fixedIncomeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dividingline2.mas_right);
        make.size.mas_equalTo(_totalRevenue);
       make.bottom.mas_equalTo(self).offset(-margin);
    }];
    
    [_dividingline3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_fixedIncomeNum.mas_right);
        make.top.mas_equalTo(_totalRevenue.mas_top);
        make.size.mas_equalTo(CGSizeMake(0.5,100 - 2*margin));
    }];
    
    [_commission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dividingline3.mas_right);
        make.size.mas_equalTo(_totalRevenue);
        make.top.mas_equalTo(_totalRevenue.mas_top);
    }];
    [_commissionNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dividingline3.mas_right);
        make.size.mas_equalTo(_totalRevenue);
        make.bottom.mas_equalTo(self).offset(-margin);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.layer.cornerRadius = 30;
        [_headImgView.layer setMasksToBounds:YES];
        [_headImgView setImage:[UIImage imageNamed:@"123"]];
        
    }
    return _headImgView;
}

- (UIImageView *)arrowImgView{
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc]init];
    }
    return _arrowImgView;
}
- (UIView *)dividingline1{
    if (!_dividingline1) {
        _dividingline1 = [[UIView alloc]init];
        _dividingline1.backgroundColor = GLOBALCOLOR(68, 139, 226);
    }
    return _dividingline1;
}
- (UIView *)dividingline2{
    if (!_dividingline2) {
        _dividingline2 = [[UIView alloc]init];
         _dividingline2.backgroundColor = GLOBALCOLOR(68, 139, 226);
    }
    return _dividingline2;
}
- (UIView *)dividingline3{
    if (!_dividingline3) {
        _dividingline3 = [[UIView alloc]init];
         _dividingline3.backgroundColor = GLOBALCOLOR(68, 139, 226);
    }
    return _dividingline3;
}

- (UILabel *)numLable{
    if (!_numLable) {
        _numLable = [[UILabel alloc]init];
        _numLable.textColor = [UIColor whiteColor];
        _numLable.text = [UserInfo sharedManager].nickname;
    }
    return _numLable;
}
- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]init];
        _nameLable.textColor = [UIColor whiteColor];
        _nameLable.text = [UserInfo sharedManager].phone;
    }
    return _nameLable;
}
- (UILabel *)totalRevenue{
    if (!_totalRevenue) {
        _totalRevenue = [[UILabel alloc]init];
        _totalRevenue.textAlignment = NSTextAlignmentCenter;
        _totalRevenue.textColor = [UIColor whiteColor];
        _totalRevenue.text = @"总收益(元)";
    }
    return _totalRevenue;
}
- (UILabel *)fixedIncome{
    if (!_fixedIncome) {
        _fixedIncome = [[UILabel alloc]init];
        _fixedIncome.textAlignment = NSTextAlignmentCenter;
        _fixedIncome.textColor = [UIColor whiteColor];
        _fixedIncome.text = @"固定收益(元)";
    }
    return _fixedIncome;
}
- (UILabel *)commission{
    if (!_commission) {
        _commission = [[UILabel alloc]init];
        _commission.textAlignment = NSTextAlignmentCenter;
        _commission.textColor = [UIColor whiteColor];
        _commission.text = @"佣金(元)";
    }
    return _commission;
}
- (UILabel *)totalRevenueNum{
    if (!_totalRevenueNum) {
        _totalRevenueNum = [[UILabel alloc]init];
        _totalRevenueNum.textAlignment = NSTextAlignmentCenter;
        _totalRevenueNum.textColor = [UIColor whiteColor];
     
    }
    return _totalRevenueNum;
}
- (UILabel *)commissionNum{
    if (!_commissionNum) {
        _commissionNum = [[UILabel alloc]init];
        _commissionNum.textAlignment = NSTextAlignmentCenter;
         _commissionNum.textColor = [UIColor whiteColor];
        
    }
    return _commissionNum;
}
- (UILabel *)fixedIncomeNum{
    if (!_fixedIncomeNum) {
        _fixedIncomeNum = [[UILabel alloc]init];
        _fixedIncomeNum.textAlignment = NSTextAlignmentCenter;
        _fixedIncomeNum.textColor = [UIColor whiteColor];
        
    }
    return _fixedIncomeNum;
}
- (UIButton *)extBtn{
    if (!_extBtn) {
        _extBtn = [[UIButton alloc]init];
        [_extBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_extBtn setTitle:@"退出" forState:UIControlStateNormal];
        _extBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [[_extBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x){
            
            [UIApplication sharedApplication].keyWindow.rootViewController = [[LoginViewController alloc]init];
            
        }];
    }
    return _extBtn;
}
@end
