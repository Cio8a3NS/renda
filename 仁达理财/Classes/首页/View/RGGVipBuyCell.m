//
//  RGGVipBuyCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/19.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGVipBuyCell.h"
@interface RGGVipBuyCell()


@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *numLable;


@end
@implementation RGGVipBuyCell

- (void)setVipBuyModel:(RGGVipBuyModel *)vipBuyModel{
    _vipBuyModel = vipBuyModel;
    
    [self setCellUI];
    
}

- (void)setYuemoney:(CGFloat)yuemoney{
    _yuemoney = yuemoney;

}
- (IBAction)buyBtn:(id)sender {
//    if (_yuemoney < _vipBuyModel.price.floatValue) {
//        [SVProgressHUD showInfoWithStatus:@"余额不足,请先充值!"];
//        return;
//    }
    
    [SVProgressHUD showWithStatus:@"正在购买..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_buyvip";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
     parameters[@"vipid"] = _vipBuyModel.id;
//    parameters[@"money"] = @((NSInteger)_vipBuyModel.id);
//    parameters[@"product_id"] = @(50);
//    parameters[@"pay_password"] = @"123456";
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshSecHeader" object:nil];
             [SVProgressHUD showInfoWithStatus:@"购买成功"];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
         [SVProgressHUD dismiss];
         [SVProgressHUD showInfoWithStatus:@"购买失败"];
    }];
    
}


- (void)setCellUI{
    
    //价格
    NSString *pricestr = [NSString stringWithFormat:@"价格:￥%@",_vipBuyModel.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:pricestr];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,pricestr.length-3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.] range:NSMakeRange(3, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.] range:NSMakeRange(4,pricestr.length-4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.] range:NSMakeRange(pricestr.length-2,2)];
    _priceLable.attributedText = str;
    
    //vip
    if ([_vipBuyModel.name isEqual:@"VIP3"]) {
        _vipImageView.image = [UIImage imageNamed:@"vip3"];
    } else if([_vipBuyModel.name isEqual:@"VIP2"]){
        _vipImageView.image = [UIImage imageNamed:@"vip2"];
    }
    else if([_vipBuyModel.name isEqual:@"VIP1"]){
        _vipImageView.image = [UIImage imageNamed:@"vip1"];
    }
    //份额
    
    NSMutableAttributedString *numstr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"每天最多可投资:%@份",_vipBuyModel.xianzhi]];
    [numstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.] range:NSMakeRange(0, 7)];
    [numstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.] range:NSMakeRange(7, numstr.length-7)];
    
    _numLable.attributedText = numstr;
    

}
@end
