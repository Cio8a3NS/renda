//
//  RGGMyAssetsViewModel.m
//  仁达理财
//
//  Created by yuanmc on 16/8/23.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGMyAssetsViewModel.h"
#import "RGGAssetsModel.h"
@implementation RGGMyAssetsViewModel
- (void)getMyAssetsInfo:(void (^)(id json))block{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_mymoney";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            block([RGGAssetsModel mj_objectWithKeyValues:json[@"data"]]);
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];

}
@end
