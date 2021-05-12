//
//  injs.m
//  HJLC_H5
//
//  Created by 小宸宸Dad on 16/7/13.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "injs.h"

@implementation injs



//#pragma mark - 获取UserId
//- (NSString *)getUserId{
//
//
//    return [UserInfo sharedManager].uid;
//
//}

#pragma mark - 获取Token
//- (NSString *)getToken{
//
//
//    return [UserInfo sharedManager].token;
//
//}

#pragma mark - 获取电话号码

//- (NSString *)getMobile{
//   return [UserInfo sharedManager].mobile;
//}

#pragma mark - 获取sign
- (NSString *)getSign:(id)json{

//    if (![json isKindOfClass:[NSDictionary class]]) {
    
        //H5数据格式错误.返回空
        return @"";
//    }
//    return [NSDictionary code:json];
    

}
#pragma mark - 登录状态
//- (BOOL)isLogin{
//    if ([UserInfo sharedManager].token.length==0) {
//         return NO;
//    }
//    else{return YES;}
//}
#pragma mark - 关闭当前页面
- (void)closeThisActivity{

    if (self.delegate && [self.delegate respondsToSelector:@selector(closeThisActivity)]) {
        
        [self.delegate closeThisActivity];
        
    }

}

#pragma mark - 转调到个人中心
- (void)toPersonActivity{

    if (self.delegate && [self.delegate respondsToSelector:@selector(toPersonActivity)]) {
        
        [self.delegate toPersonActivity];
        
    }


}



/**车险调用的跳转*/
- (void)passUrl:(NSString *)url{

    if (self.delegate && [self.delegate respondsToSelector:@selector(passUrl:)]) {
        
        [self.delegate passUrl:url];
        
    }
    


}


#pragma mark - 转调到登录页面
- (void)toLoginActivity{

    if (self.delegate && [self.delegate respondsToSelector:@selector(toLoginActivity)]) {
        
        [self.delegate toLoginActivity];
        
    }


}


#pragma mark - 账户中心数据回调
- (void)accountDataCallBack{

    if (self.delegate && [self.delegate respondsToSelector:@selector(accountDataCallBack)]) {
        
        [self.delegate accountDataCallBack];
        
    }
    

}


#pragma mark - 绑卡成功数据回调
- (void)bankDataCallBack:(id)json{

//    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
//    
//    [UserAccountInfo sharedManager].bankCardInfo = dic;
//    
//    return;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(bankDataCallBack:)]) {
//        
//        [self.delegate bankDataCallBack:json];
//        
//    }

}


#pragma mark -  关闭webview，跳转到短期选项
- (void)toShortProductItem{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toShortProductItem)]) {
        
        [self.delegate toShortProductItem];
        
    }

}


#pragma mark - 跳转到设置回款账户页面
- (void)toSetBackAccountActivity{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toSetBackAccountActivity)]) {
        
        [self.delegate toSetBackAccountActivity];
        
    }


}


#pragma mark - 设置本地webview的title
- (void)setWebViewTitle:(NSString *)title{

    if (self.delegate && [self.delegate respondsToSelector:@selector(setWebViewTitle:)]) {
        
        [self.delegate setWebViewTitle:title];
        
    }

}




@end
