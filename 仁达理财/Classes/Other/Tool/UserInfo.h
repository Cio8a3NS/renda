//
//  UserInfo.h
//  仁达
//
//  Created by 杨方军 on 16/8/1.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

/**用户是否禁用（true禁用，false正常）*/
@property (assign,nonatomic)BOOL cate_id;

/**手机唯一标示*/
@property (strong,nonatomic)NSString *create_time;

/**手机号*/
@property (strong,nonatomic)NSString *dongjie_jinniubi;

/**登录id*/
@property (strong,nonatomic)NSString *email;

/**用户唯一id*/
@property (strong,nonatomic)NSString *head_img;
/**用户唯一id*/
@property (strong,nonatomic)NSString *hongbao_money;
@property (strong,nonatomic)NSString *huiyuan_daoqi;
/**用户唯一id*/
@property (strong,nonatomic)NSString *id;
/**用户唯一id*/
@property (strong,nonatomic)NSString *id_card;
/**用户唯一id*/
@property (strong,nonatomic)NSString *is_admin;
@property (strong,nonatomic)NSString *is_hongbao;
@property (strong,nonatomic)NSString *jinniubi;
@property (strong,nonatomic)NSString *nickname;
@property (strong,nonatomic)NSString *parent_id;
@property (strong,nonatomic)NSString *parent_list;
@property (strong,nonatomic)NSMutableDictionary *parent_user;
@property (strong,nonatomic)NSString *phone;
@property (strong,nonatomic)NSString *status;
@property (strong,nonatomic)NSString *tuiguang_token;
@property (strong,nonatomic)NSString *username;
@property (strong,nonatomic)NSString *wechat;
@property (strong,nonatomic)NSString *yu_money;
@property (strong,nonatomic)NSString *payPassWord;

/**是否设置了登录密码*/
@property (assign,nonatomic)BOOL existPassord;

/**用户是否开启手势密码*/
@property (assign,nonatomic)BOOL openLock;


+ (instancetype)sharedManager;

/**
 *  存储用户数据
 *
 *  @param dic 用户基本数据
 */
- (void)saveUserInfoData:(NSDictionary *)dic;

/**获取用户数据*/
- (void)getserInfoData;

/**移除用户的数据*/
- (void)removeUserInfo;

/**开启手势密码对本地数据进行处理*/
- (void)openLockAction;


/**关闭手势密码对本地数据进行处理*/
- (void)closeLockAction;



@end
