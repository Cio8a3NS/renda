//
//  RGGMyAssetsViewModel.h
//  仁达理财
//
//  Created by yuanmc on 16/8/23.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGGMyAssetsViewModel : NSObject
- (void)getMyAssetsInfo:(void (^)(id json))block;
@end
