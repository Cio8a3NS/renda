//
//  RGGVipBuyModel.h
//  仁达理财
//
//  Created by yuanmc on 16/8/22.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGGVipBuyViewModel : NSObject
- (void)getVipBuyInfo:(void (^)(id json))block;
@end
