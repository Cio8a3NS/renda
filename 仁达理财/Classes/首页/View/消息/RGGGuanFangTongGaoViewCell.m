//
//  RGGGuanFangTongGaoViewCell.m
//  仁达理财
//
//  Created by wangdong on 16/8/24.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGGuanFangTongGaoViewCell.h"
#define margin 20
#define IMAGE_WIGHT 80
#define IMAGE_HIGHT 60
#define TEXT_HIGHT 50
@interface RGGGuanFangTongGaoViewCell()
@property(nonatomic, strong)UILabel *titleLable;
@property(nonatomic, strong)UILabel *detailLable;
@property(nonatomic, strong)UILabel *timeLable;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UIView *fengeView;
@end
@implementation RGGGuanFangTongGaoViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.detailLable];
        [self.contentView addSubview:self.timeLable];
        [self.contentView addSubview:self.imgView];
        [self loadContraint];
    }
    return self;
}

- (void)setGuanFangGongGaoModel:(RGGGuanFangGongGaoModel *)guanFangGongGaoModel{
    _guanFangGongGaoModel = guanFangGongGaoModel;
    [self refreshUI];
}

- (void)refreshUI{
    _titleLable.text = _guanFangGongGaoModel.title;
    _detailLable.text = _guanFangGongGaoModel.content;
    _timeLable.text =  [NSString timeToDate:_guanFangGongGaoModel.create_time.doubleValue] ;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_guanFangGongGaoModel.img] placeholderImage:[UIImage imageNamed:@"guanfangdefault"]];
}

- (void)loadContraint{
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(margin);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - IMAGE_WIGHT-3*margin, TEXT_HIGHT));
    }];
    
    [_detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_bottom);
        make.left.width.mas_equalTo(_titleLable);
        make.height.equalTo(@30);

    }];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.left.width.height.equalTo(_detailLable);
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_top);
        make.trailing.equalTo(self).offset(-margin);
        make.size.mas_equalTo(CGSizeMake(IMAGE_WIGHT,IMAGE_HIGHT));
    }];
}

#pragma mark - 

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLable.numberOfLines = 0;
        
    }
    return _titleLable;
}
- (UILabel *)detailLable{
    if (!_detailLable) {
        _detailLable = [[UILabel alloc]init];
        _detailLable.font = [UIFont systemFontOfSize:14.0f];
        _detailLable.textColor = [UIColor lightGrayColor];
        _detailLable.text = @"俄日我而IP热尔维片";
    }
    return _detailLable;
}
- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc]init];
        _timeLable.font = [UIFont systemFontOfSize:12.0f];
        _timeLable.textColor = [UIColor lightGrayColor];
        _timeLable.text = @"2013-09-09";
    }
    return _timeLable;
}
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"12313"];
    }
    return _imgView;
}

- (void)drawRect:(CGRect)rect{
    _fengeView = [[UIView alloc]initWithFrame:CGRectMake(margin, rect.size.height-0.5, SCREEN_WIDTH-2*margin, 0.5)];
    _fengeView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_fengeView];
}

@end
