//
//  RGGBillingRecordCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/19.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGBillingRecordCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface RGGBillingRecordCell()
@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *comonLable1;
@property (weak, nonatomic) IBOutlet UILabel *comonLable2;
@property (weak, nonatomic) IBOutlet UILabel *comonLable3;

@property (weak, nonatomic) IBOutlet UILabel *comonLable4;
@property (weak, nonatomic) IBOutlet UIButton *chakanpinzhengBtn;


@end


@implementation RGGBillingRecordCell


- (void)refreshUI{
    
    self.dateLabel.text =  [NSString timeToDate:_zhangdanjiluModel.create_time.floatValue];
    
    self.comonLable1.text = [NSString stringWithFormat:@"状态:%@",_zhangdanjiluModel.status.integerValue == 1?@"成功":@"处理中"];
    self.comonLable2.text = [NSString stringWithFormat:@"金额:¥%ld元",(long)_zhangdanjiluModel.money.integerValue];
    self.comonLable3.text = [NSString stringWithFormat:@"类型:%@",_zhangdanjiluModel.shouzhi];
    self.comonLable4.textColor = mycolor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    self.comonLable4.userInteractionEnabled = YES;
    [self.comonLable4 addGestureRecognizer:tap];
    
    if ([_zhangdanjiluModel.typeCode integerValue] == 14 &&_zhangdanjiluModel.pingzheng.length!=0) {
        self.chakanpinzhengBtn.hidden = NO;
    }
    else{ self.chakanpinzhengBtn.hidden = YES;}
    
}

- (void)tapAction{
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ ¥%@",_zhangdanjiluModel.shouzhi,_zhangdanjiluModel.money] message:[NSString stringWithFormat:@"状态:%@\n类型:%@\n时间:%@\n详情:%@\n",_zhangdanjiluModel.status.integerValue == 1?@"成功":@"处理中",_zhangdanjiluModel.shouzhi,[NSString timeToDate:_zhangdanjiluModel.create_time.floatValue],_zhangdanjiluModel.intro] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [dialog setAlertViewStyle:UIAlertViewStyleDefault];
//    [[dialog label:0] setKeyboardType:UIKeyboardTypeNumberPad];
//    [[dialog textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeDefault];
//    [[dialog textFieldAtIndex:0] setPlaceholder:@"请输入购买份数"];
//    [[dialog textFieldAtIndex:1] setPlaceholder:@"请输入交易密码"];
    [dialog show];

}

- (void)setZhangdanjiluModel:(RGGzhangdanjiluModel *)zhangdanjiluModel{
    _zhangdanjiluModel = zhangdanjiluModel;
    [self refreshUI];

}

- (IBAction)chakanpinzheng:(id)sender {
     NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString:_zhangdanjiluModel.pingzheng]; // 图片路径
    [photos addObject:photo];
// 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

@end
