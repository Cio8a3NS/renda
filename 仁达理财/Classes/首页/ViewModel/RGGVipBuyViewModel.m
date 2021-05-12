//
//  RGGVipBuyModel.m
//  仁达理财
//
//  Created by yuanmc on 16/8/22.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGVipBuyViewModel.h"
#import "RGGVipBuyModel.h"
@implementation RGGVipBuyViewModel
- (void)getVipBuyInfo:(void (^)(id json))block{

        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"type"] = @"jinniubi_viplist";
        parameters[@"sign"] = [FactoryTool rendeCode];
        parameters[@"qtime"] = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
        parameters[@"equipment"] = [FactoryTool myuuid];
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
        NSLog(@"%@",parameters);
        [HttpTool post:BaseURL params:parameters success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"status"]integerValue] == 1) {
                 block([RGGVipBuyModel mj_objectArrayWithKeyValuesArray:json[@"data"]]);
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
