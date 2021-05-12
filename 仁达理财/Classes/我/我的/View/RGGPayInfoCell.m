//
//  RGGPayInfoCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/18.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGPayInfoCell.h"
@interface RGGPayInfoCell()
@property(nonatomic, copy)UIImageView *backImgView;
@property(nonatomic, copy)UIImageView *iconImg;
@property(nonatomic, copy)UILabel  *nameLable;
@property(nonatomic, copy)UILabel  *numLable;
@end
@implementation RGGPayInfoCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subView in self.subviews) {
        
        NSLog(@"subViewsubView%@",NSStringFromClass([subView class]));
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1234"]];
        self.layer.cornerRadius = 10;
//        [self.contentView addSubview:self.backImgView];
        [self addSubview:self.iconImg];
        [self addSubview:self.nameLable];
        [self addSubview:self.numLable];
        [self loadContraints];
    }
    return self;
}

- (void)setBankListModel:(RGGBankListModel *)bankListModel{
    _bankListModel = bankListModel;
    [self refreshUI];

}

- (void)refreshUI{
    
    _nameLable.text = _bankListModel.bank_username;
    
    _numLable.text = _bankListModel.bank_account;
    
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:_bankListModel.icon] placeholderImage:LOAD_IMAGE(@"链接")];
}

#pragma mark - 懒加载
- (UIImageView *)backImgView{
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc]init];
        _backImgView.image = [UIImage imageNamed:@"1234"];
        _backImgView.layer.cornerRadius = 10;
        _backImgView.clipsToBounds = YES;
    }
    return _backImgView;
}
- (UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.image = [UIImage imageNamed:@"111"];
        
    }
    return _iconImg;
}
- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]init];
        _nameLable.textColor = [UIColor whiteColor];
        _nameLable.font = [UIFont systemFontOfSize:18.];
        _nameLable.text = @"中信银行";
    }
    return _nameLable;
}
- (UILabel *)numLable{
    if (!_numLable) {
        _numLable = [[UILabel alloc]init];
        _numLable.font = [UIFont systemFontOfSize:15.];
        _numLable.textColor = [UIColor whiteColor];
        _numLable.text = @"**** **** **** 1234";
    }
    return _numLable;
}

- (void)loadContraints{
//    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.trailing.equalTo(self);
//        make.top.equalTo(self).offset(5);
//        make.bottom.equalTo(self).offset(-5);
//    }];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(50);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@50);
    }];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImg.mas_top);
        make.left.equalTo(_iconImg.mas_right).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    [_numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLable.mas_left);
        make.width.equalTo(@200);
        make.height.equalTo(@25);
        make.bottom.equalTo(_iconImg);
    }];

}


@end
