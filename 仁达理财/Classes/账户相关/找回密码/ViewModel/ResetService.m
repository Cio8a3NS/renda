//
//  ResetService.m
//  仁达
//
//  Created by wang dong on 16/8/2.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "ResetService.h"

@implementation ResetService

/**
 *  用户设置登录密码短信接口
 */
+(void)postSetPwdMobile:(NSString *)mobile Success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    NSString *url = [BaseURL stringByAppendingString:@"sms/findLoginPassword.json"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"mobile"] = mobile;
    
    
    [HttpTool post:url params:nil success:^(id json) {
        
        if ([json[@"code"] intValue]!=200) {
            
            
            
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            failure(nil);

          
        }else{
        
            success(json);
        
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
        //nslog(@"error%@",error);
        
    }];

    
}



/**
 *  确认重置按钮调用
 */
+(void)postConfirmReset:(NSDictionary *)dic Success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    NSString *url = [BaseURL stringByAppendingString:@"user/password/findPassword.json"];
    
    
    
    [HttpTool post:url params:nil success:^(id json) {
        
        
            success(json);
       
        
    } failure:^(NSError *error) {
        
        
        failure(error);
        
    }];

    
}


@end
