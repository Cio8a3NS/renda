//
//  RGGyinjitixianCell.m
//  仁达理财
//
//  Created by yuanmc on 16/8/30.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGyinjitixianCell.h"
@interface RGGyinjitixianCell()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *yinjitixianImageView;
@property (weak, nonatomic) IBOutlet UILabel *touzieduLabel;
@property (weak, nonatomic) IBOutlet UILabel *leijishijianLable;
@property (weak, nonatomic) IBOutlet UILabel *leijishouyiLable;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;

@end

@implementation RGGyinjitixianCell

- (void)setYinjitixianModel:(RGGyinjitixianModel *)yinjitixianModel{
    _yinjitixianModel = yinjitixianModel;
    [self refreshUI];

}
-(void)refreshUI{
    //天数图片显示
    
    switch ([_yinjitixianModel.product_id integerValue]) {
        case 1:
            self.yinjitixianImageView.image = [UIImage imageNamed:@"6天"];
            break;
        case 2:
            self.yinjitixianImageView.image = [UIImage imageNamed:@"10"];
            break;
        case 3:
            self.yinjitixianImageView.image = [UIImage imageNamed:@"14"];
            break;
        case 4:
            self.yinjitixianImageView.image = [UIImage imageNamed:@"18"];
            break;
        default:
           
            break;
    }
    
    
    self.touzieduLabel.text = [NSString stringWithFormat:@"￥%@",_yinjitixianModel.money];
    self.leijishijianLable.text =[NSString stringWithFormat:@"%@天",_yinjitixianModel.day];
    self.leijishouyiLable.text = [NSString stringWithFormat:@"￥%@",[NSString stringWithFormat:@"%.2lf",_yinjitixianModel.shouyi.floatValue]];
}
- (IBAction)tixianBtn:(id)sender {
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
        parameters[@"id"] = _yinjitixianModel.id;
        NSLog(@"%@",parameters);
        [HttpTool post:BaseURL params:parameters success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"status"]integerValue] == 1) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"notifacation"object:_yinjitixianModel.id];
                [self.tixianBtn setTitle:@"已提现" forState:UIControlStateNormal];
                [SVProgressHUD showInfoWithStatus:@"提现成功,请等待审核!!"];
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
