//
//  RGGFixedIncomeCell.m
//  仁达理财
//
//  Created by wangdong on 16/8/22.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGFixedIncomeCell.h"
#import "CustomPieChart.h"
#import "RGGProductShouyiModel.h"
#define kNavBarH 64.f
#define kTabBarH 49.f
#define kScreenW     [UIScreen mainScreen].bounds.size.width
#define kScreenH     [UIScreen mainScreen].bounds.size.height
//相对高度
#define kRelativeH ((kScreenH -  kNavBarH) / (568 - kNavBarH))
//相对宽度
#define kRelativeW (kScreenW / 320)

#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define margin 20
@interface RGGFixedIncomeCell()

@property (nonatomic, strong)CustomPieChart *pieChart;
@property (nonatomic, strong)UILabel *fixdIncomeLable;
@property (nonatomic, strong)UILabel *fixdIncomeNumLable;
@property (nonatomic, strong)UIView *fengeView;
@property (nonatomic, strong)UIImageView *arrowImageView;

@property (nonatomic, strong)NSMutableArray *items;

@property (nonatomic, assign)CGFloat totalProductShouyi;
@end
@implementation RGGFixedIncomeCell
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
        _fixdIncomeLable.text = @"固定收益";
    }
    return _fixdIncomeLable;
}

- (UILabel *)fixdIncomeNumLable{
    if (!_fixdIncomeNumLable) {
        _fixdIncomeNumLable = [[UILabel alloc]init];
        _fixdIncomeNumLable.text = @"固定收益";
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
    _fixdIncomeNumLable.text = [NSString stringWithFormat:@"%@元",_assetsModel.gudingShouyi];
    if (_assetsModel.productShouyi.count != 0) {
        [self loadView];
    }
    
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
//    NSArray *items = @[
//                       [PNPieChartDataItem dataItemWithValue:40 color:HexColor(0Xb96bc6) description:@"自取件"],
//                       [PNPieChartDataItem dataItemWithValue:10 color:HexColor(0Xf1b870) description:@"派件"],
//                       [PNPieChartDataItem dataItemWithValue:10 color:HexColor(0Xef415f) description:@"取件"],
//                       [PNPieChartDataItem dataItemWithValue:40 color:HexColor(0X6041b7) description:@"自存件"],
//                       
//                       ];
    
    _items = [[NSMutableArray alloc]init];
    
    NSArray *colorArray = @[GLOBALCOLOR(247, 222, 131),GLOBALCOLOR(249, 122, 128),GLOBALCOLOR(242, 110, 159),GLOBALCOLOR(95, 197, 162),GLOBALCOLOR(80, 160, 162),GLOBALCOLOR(80, 59, 60)];
    
    for (int i = 0; i<_assetsModel.productShouyi.count; i++) {
         RGGProductShouyiModel *productShouyiModel = _assetsModel.productShouyi[i];
        [_items addObject: [PNPieChartDataItem dataItemWithValue:[productShouyiModel.m floatValue] color:colorArray[i] description:[NSString stringWithFormat:@"%@天",productShouyiModel.day]]];
    }
    _pieChart = [[CustomPieChart alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 183 * kRelativeH) / 2.0, 70, 100, 100) items:_items];
    _pieChart.inCircleRadius = 20;
    _pieChart.descriptionTextColor = [UIColor whiteColor];
    _pieChart.showOnlyValues = YES;
    _pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:10];
    [_pieChart strokeChart];
    _pieChart.legendFontColor = [UIColor lightGrayColor];
    _pieChart.legendFont = [UIFont systemFontOfSize:10 * kRelativeW];
    UIView *legend = [_pieChart getLegendWithMaxWidth:200];
    [legend setFrame:CGRectMake(screenWidth -legend.frame.size.width-2*margin, (_pieChart.center.y - legend.frame.size.height / 2.0), legend.frame.size.width, legend.frame.size.height)];
    [self.contentView addSubview:legend];
    [self addSubview:_pieChart];

}

@end
