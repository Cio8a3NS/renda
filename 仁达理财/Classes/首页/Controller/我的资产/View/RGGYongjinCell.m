//
//  RGGBillingRecordCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/19.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGYongjinCell.h"
@interface RGGYongjinCell()
@property (weak, nonatomic) IBOutlet UIImageView *dateImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;

@property (weak, nonatomic) IBOutlet UILabel *lable4;

@end


@implementation RGGYongjinCell

- (void)setYongjinshouyiModel:(RGGYongjinshouyiModel *)yongjinshouyiModel{
    _yongjinshouyiModel = yongjinshouyiModel;

    [self refreshUI];
}


- (void)refreshUI{
    self.label1.text = [NSString stringWithFormat:@"获得佣金:%@元",_yongjinshouyiModel.money];
    self.lable2.text = [NSString stringWithFormat:@"等级:%@级",_yongjinshouyiModel.dai];
    self.lable3.text = [NSString stringWithFormat:@"收益额度:%@元",_yongjinshouyiModel.touzimoney];
    self.lable4.text = [NSString stringWithFormat:@"账号:%@",_yongjinshouyiModel.phone];
    self.dateLable.text = [NSString timeToDate:_yongjinshouyiModel.create_time.floatValue];
}
@end
