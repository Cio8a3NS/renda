//
//  RGGAssetsModel.m
//  仁达理财
//
//  Created by yuanmc on 16/8/24.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGAssetsModel.h"

@implementation RGGAssetsModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
            @"productShouyi":@"RGGProductShouyiModel",
            @"yongjinDaiShouyi":@"RGGYongjinDaiShouyiModel"
            };

}
@end
