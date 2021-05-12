//
//  ResetPwdViewController.m
//  仁达
//
//  Created by wang dong on 16/8/2.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "ResetView.h"

#import "ResetService.h"


@interface ResetPwdViewController ()
{
    ResetView *resetView;

}

@end

@implementation ResetPwdViewController




- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"找回密码";
//    [self.navigationController.navigationBar setTranslucent:NO];
//     [self.navigationController.navigationBar setBarTintColor:GLOBALCOLOR(245, 98, 54)];
    resetView = [[ResetView alloc] init];
    [self.view addSubview:resetView];
    
    
    
    
    //发送密码点击事件
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    [resetView.codeLab addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
        
        [resetView startTimeCount];
        
        [self getVerifyCode];
        
        
        
    }];
    
    
    
    //确认重置
    [[resetView.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.view endEditing:YES];
        
        NSString *vCode = resetView.verifCodeField.text;
        NSString *nPwd  = resetView.nPwdField.text;
        NSString *oPwd  = resetView.conPwdField.text;
        
        if ([vCode isEqualToString:@""]||[nPwd isEqualToString:@""]||[oPwd isEqualToString:@""]) {
            
          
            [SVProgressHUD showInfoWithStatus:@"信息不完整"];
            
            return;
        }
        
        if (![nPwd isEqualToString:oPwd]) {
            
             [SVProgressHUD showInfoWithStatus:@"密码不一致"];
            
            
            return;
        }
        
        
        
        if ([FactoryTool predicatePassWord:nPwd]==NO) {
            return;
        }
        
        UserInfo *user = [UserInfo sharedManager];
        
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setObject:user.mobile forKey:@"phone"];
        [dic setObject:[FactoryTool md532BitLower:nPwd]forKey:@"password"];
        [dic setObject:vCode forKey:@"code"];
        [dic setObject:qtime forKey:@"qtime"];
        [dic setObject:user.phone forKey:@"phone"];
        [dic setObject:[FactoryTool rendeCode] forKey:@"sign"];
        [dic setObject:@"login_updatepass" forKey:@"type"];
        [self confirmResetPwd:dic];
       
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  获取验证码
 */
-(void)getVerifyCode
{
    
    UserInfo *user = [UserInfo sharedManager];
    
//
//    [ResetService postSetPwdMobile:user.mobile Success:^(id json) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
}


/**
 *  确认重置密码
 */
-(void)confirmResetPwd:(NSMutableDictionary *)dic
{
    
//   [SVProgressHUD show];
    
//    [ResetService postConfirmReset:dic Success:^(id json) {
//        
//        [SVProgressHUD dismiss];
//        
//        
//        if ([json[@"code"] intValue]!=200) {
//            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
//        }else{
//            
//            [SVProgressHUD showInfoWithStatus:@"密码重置成功"];
//            
//            
//            int index = (int)self.navigationController.viewControllers.count-1;
//            index = index-2;
//            if (index<0) {
//                index = 0;
//                
//            }
//            
//            [self.navigationController popToViewController:self.navigationController.viewControllers[index] animated:YES];
//            
//            
//        }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在重新设置密码..."];
    [HttpTool post:BaseURL params:dic success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                [SVProgressHUD showInfoWithStatus:json[@"msg"]];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
            }];

}



@end
