//
//  UserInfo.m
//  仁达
//
//  Created by 杨方军 on 16/8/1.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "UserInfo.h"
#import "CoreArchive.h"

@implementation UserInfo


+ (instancetype)sharedManager
{
    static UserInfo *info = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        info = [[self alloc] init];
    });
    return info;
}




-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([UserInfo class], &count);
        
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        
        free(ivars);
    }
    return self;
}



- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UserInfo class], &count);
    
    for (int i = 0; i<count; i++) {
        
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 解档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}


- (void)saveUserInfoData:(NSDictionary *)dic{
    
    UserInfo *userInfo    = [UserInfo sharedManager];

    userInfo.cate_id    = dic[@"data"][@"cate_id"];
    userInfo.create_time          = dic[@"data"][@"create_time"];
    userInfo.dongjie_jinniubi       = dic[@"data"][@"dongjie_jinniubi"];
    userInfo.email        = dic[@"data"][@"email"];
    userInfo.head_img          = dic[@"data"][@"head_img"];
    userInfo.hongbao_money = dic[@"data"][@"hongbao_money"];
     userInfo.huiyuan_daoqi = dic[@"data"][@"huiyuan_daoqi"];
     userInfo.id = dic[@"data"][@"id"];
     userInfo.id_card = dic[@"data"][@"id_card"];
     userInfo.is_admin = dic[@"data"][@"is_admin"];
     userInfo.is_hongbao = dic[@"data"][@"is_hongbao"];
     userInfo.jinniubi = dic[@"data"][@"jinniubi"];
     userInfo.nickname = dic[@"data"][@"nickname"];
    userInfo.parent_id = dic[@"data"][@"parent_id"];
    userInfo.parent_user = dic[@"data"][@"parent_user"];
    userInfo.parent_list = dic[@"data"][@"parent_list"];
    userInfo.phone = dic[@"data"][@"phone"];
    userInfo.status = dic[@"data"][@"status"];
    userInfo.tuiguang_token = dic[@"data"][@"tuiguang_token"];
    userInfo.username = dic[@"data"][@"username"];
    userInfo.wechat = dic[@"data"][@"wechat"];
    userInfo.yu_money = dic[@"data"][@"yu_money"];
   
    //存档用户数据
    [[NSUserDefaults standardUserDefaults]setValue:[NSKeyedArchiver archivedDataWithRootObject:userInfo]forKey:[NSString stringWithFormat:@"userInfo"]];
}

- (void)getserInfoData{
    
    UserInfo *userInfo = [UserInfo sharedManager];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"userInfo"]];
    UserInfo *tempInfo    = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    userInfo.cate_id    = tempInfo.cate_id;
    userInfo.create_time          = tempInfo.create_time;
    userInfo.dongjie_jinniubi       = tempInfo.dongjie_jinniubi;
    userInfo.email        = tempInfo.email;
    userInfo.head_img          = tempInfo.head_img;
    userInfo.hongbao_money = tempInfo.hongbao_money;
    userInfo.huiyuan_daoqi = tempInfo.huiyuan_daoqi;
    userInfo.id = tempInfo.id;
    userInfo.id_card = tempInfo.id_card;
    userInfo.is_admin = tempInfo.is_admin;
    userInfo.is_hongbao = tempInfo.is_hongbao;
    userInfo.jinniubi = tempInfo.jinniubi;
    userInfo.nickname = tempInfo.nickname;
    userInfo.parent_id = tempInfo.parent_id;
    userInfo.parent_list = tempInfo.parent_list;
    userInfo.phone = tempInfo.phone;
    userInfo.status = tempInfo.status;
    userInfo.tuiguang_token = tempInfo.tuiguang_token;
    userInfo.username = tempInfo.username;
    userInfo.wechat = tempInfo.wechat;
    userInfo.yu_money = tempInfo.yu_money;

}



- (void)removeUserInfo{
    
    UserInfo *userInfo = [UserInfo sharedManager];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
//    userInfo.isDisable    = NO;
//    userInfo.mac          = nil;
//    userInfo.token        = nil;
//    userInfo.uid          = nil;
//    userInfo.existPassord = NO;
    //[CoreArchive removeStrForKey:@"CoreLockPWDKey"];

}

- (void)closeLockAction{

    [UserInfo sharedManager].openLock = NO;
    [CoreArchive removeStrForKey:@"CoreLockPWDKey"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];

}

- (void)openLockAction{

    //nslog(@"%@",[UserInfo sharedManager].mobile);
    [UserInfo sharedManager].openLock = YES;
    //存档用户数据
    [[NSUserDefaults standardUserDefaults]setValue:[NSKeyedArchiver archivedDataWithRootObject:[UserInfo sharedManager]]forKey:[NSString stringWithFormat:@"userInfo"]];


}



@end
