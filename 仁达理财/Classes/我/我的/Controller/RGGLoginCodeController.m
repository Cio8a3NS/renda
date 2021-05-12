//
//  RGGLoginCodeController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/18.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGLoginCodeController.h"

@interface RGGLoginCodeController ()
@property (weak, nonatomic) IBOutlet UITextField *yuanmimatextFiled;

@property (weak, nonatomic) IBOutlet UITextField *NewTextField;
@property (weak, nonatomic) IBOutlet UITextField *chongfumimaLable;

@end

@implementation RGGLoginCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)submitBtn:(id)sender {
    
    NSLog(@"%@",self.title);

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"user_updatepass";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    parameters[@"ypass"] = [FactoryTool  md532BitLower: self.yuanmimatextFiled.text];
    parameters[@"npass"] = [FactoryTool  md532BitLower: self.NewTextField.text];
    parameters[@"uptype"] = [self.title isEqual:@"支付密码修改"]?@(2):@(1);
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            [SVProgressHUD showInfoWithStatus:@"修改成功!"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.NewTextField resignFirstResponder];
    [self.yuanmimatextFiled resignFirstResponder];
    [self.chongfumimaLable resignFirstResponder];
}

@end
