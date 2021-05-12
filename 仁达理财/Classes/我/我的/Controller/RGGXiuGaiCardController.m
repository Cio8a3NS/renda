//
//  RGGXiuGaiCardController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/26.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGXiuGaiCardController.h"

@interface RGGXiuGaiCardController ()


@property (weak, nonatomic) IBOutlet UITextField *bankAccountTextField;
@property (weak, nonatomic) IBOutlet UILabel *cikarenLable;

@end

@implementation RGGXiuGaiCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改";
    self.cikarenLable.text = _bankListModel.bank_username;
}
- (IBAction)quedingBtn:(id)sender {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"user_editbank";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
    parameters[@"equipment"] = [FactoryTool myuuid];
    parameters[@"id"] = _bankListModel.id;
    parameters[@"account"] = self.bankAccountTextField.text;
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.bankAccountTextField resignFirstResponder];
}
@end
