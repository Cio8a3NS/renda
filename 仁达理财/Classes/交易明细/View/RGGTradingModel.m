//
//  RGGTradingModel.m
//  仁达理财
//
//  Created by yuanmc on 16/8/22.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGTradingModel.h"
#import "RGGTradingContentModel.h"
@implementation RGGTradingModel

+(NSDictionary *)mj_objectClassInArray{

    return @{
                @"contentArray" : @"RGGTradingContentModel"
                };
}

@end
