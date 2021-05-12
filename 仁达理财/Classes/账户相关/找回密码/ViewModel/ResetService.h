//
//  ResetService.h
//  仁达
//
//  Created by wang dong on 16/8/2.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResetService : NSObject

/**
 *  用户设置登录密码短信接口
 */
+(void)postSetPwdMobile:(NSString *)mobile Success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


/**
 *  确认重置按钮调用
 */
+(void)postConfirmReset:(NSDictionary *)dic Success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
