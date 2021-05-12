//
//  RGGTYongjinIcomeCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/24.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGTYongjinIcomeCell.h"
#import "LDProgressView.h"
#import "RGGYongjinDaiShouyiModel.h"
#define margin 20

@interface RGGTYongjinIcomeCell()

@property (nonatomic, strong)UILabel *fixdIncomeLable;
@property (nonatomic, strong)UILabel *fixdIncomeNumLable;
@property (nonatomic, strong)UIView *fengeView;
@property (nonatomic, strong)UIImageView *arrowImageView;
@end

@implementation RGGTYongjinIcomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.fixdIncomeLable];
        [self.contentView addSubview:self.fixdIncomeNumLable];
        [self.contentView addSubview:self.fengeView];
        [self.contentView addSubview:self.arrowImageView];
        [self loadContraint];
        
        
    }
    return self;
}

#pragma mark - 懒加载
- (UILabel *)fixdIncomeLable{
    if (!_fixdIncomeLable) {
        _fixdIncomeLable = [[UILabel alloc]init];
        _fixdIncomeLable.text = @"佣金收益";
    }
    return _fixdIncomeLable;
}

- (UILabel *)fixdIncomeNumLable{
    if (!_fixdIncomeNumLable) {
        _fixdIncomeNumLable = [[UILabel alloc]init];
        
    }
    return _fixdIncomeNumLable;
}

- (UIView *)fengeView{
    if (!_fengeView) {
        _fengeView = [[UIView alloc]init];
        _fengeView.backgroundColor = BackgroundColor;
    }
    return _fengeView;
}
- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"前进"];
    }
    return _arrowImageView;
}

#pragma mark - getter and setter
- (void)setAssetsModel:(RGGAssetsModel *)assetsModel{
    _assetsModel = assetsModel;
    
    [self refreshUI];
    
}
- (void)refreshUI{
    _fixdIncomeNumLable.text = [NSString stringWithFormat:@"%@元",_assetsModel.yongjinShouyi];
    [self loadView];
    
}
#pragma mark - 约束加载

- (void)loadContraint{
    [_fixdIncomeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(margin);
        make.size.mas_equalTo(CGSizeMake(80,50));
    }];
    [_fixdIncomeNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_fixdIncomeLable.mas_right);
        make.size.mas_equalTo(CGSizeMake(130,50));
    }];
    [_fengeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fixdIncomeLable.mas_bottom);
        make.left.equalTo(_fixdIncomeLable.mas_left);
        make.size.mas_equalTo(CGSizeMake(screenWidth - 2*margin,0.5));
    }];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_fixdIncomeLable.mas_centerY);
        make.trailing.equalTo(self).offset(-margin);
        make.size.mas_equalTo(CGSizeMake(7.5,14));
    }];
}
- (void)loadView{
//    self.progressViews = [NSMutableArray array];
    
    CGFloat totalyongjin = 0;
    for (int i=0; i<_assetsModel.yongjinDaiShouyi.count; i++) {
        RGGYongjinDaiShouyiModel *yongjinDaiShouyiModel = _assetsModel.yongjinDaiShouyi[i];
        totalyongjin = totalyongjin + yongjinDaiShouyiModel.m.floatValue;
    
    }
    // default color, animated
    for (int i=0; i<_assetsModel.yongjinDaiShouyi.count; i++) {
         RGGYongjinDaiShouyiModel *yongjinDaiShouyiModel = _assetsModel.yongjinDaiShouyi[i];
         ;
        LDProgressView *progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(2*margin+25, 70 + i*25 , screenWidth-3*margin-25, 22)];
        UILabel *jiLable = [[UILabel alloc]initWithFrame:CGRectMake(margin, 70 + i*25, 25, 22)];
        jiLable.textColor = [UIColor lightGrayColor];
        jiLable.text = [NSString stringWithFormat:@"%d级",i+1];
        progressView.progress = [NSString stringWithFormat:@"%.2lf",yongjinDaiShouyiModel.m.floatValue/totalyongjin].floatValue;
        progressView.color = GLOBALCOLOR(98, 165, 250);
        progressView.background = [progressView.color colorWithAlphaComponent:0.4];
        progressView.showBackgroundInnerShadow = @NO;
        
        progressView.showText = @YES;
        progressView.showStroke = @NO;
        
        //    progressView.showBackground = @NO;
        progressView.type = LDProgressSolid;
        progressView.animate = @NO;
        //    [self.progressViews addObject:progressView];
        [self.contentView addSubview:jiLable];
        [self.contentView addSubview:progressView];
    }
    
}
@end
