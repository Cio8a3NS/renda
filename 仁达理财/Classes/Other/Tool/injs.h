//
//  injs.h
//  HJLC_H5
//
//  Created by 小宸宸Dad on 16/7/13.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol injsDelegate <JSExport,NSObject>



/**获取UserId*/
- (NSString *)getUserId;

/**获取UserId*/
- (NSString *)getMobile;

/**获取Token*/
- (NSString *)getToken;

/**获取sign */
- (NSString *)getSign:(id)json;

/**判断是否登录 */
- (BOOL)isLogin;
/**关闭当前页面*/
- (void)closeThisActivity;

/**转调到个人中心*/
- (void)toPersonActivity;


/**转调到登录页面*/
- (void)toLoginActivity;


/**账户中心数据回调 */
- (void)accountDataCallBack;


/**绑卡成功数据回调 */
- (void)bankDataCallBack:(id)json;

/** 关闭webview，跳转到短期选项*/
- (void)toShortProductItem;

/** 设置本地webview的title */
- (void)setWebViewTitle:(NSString *)title;

/**跳转到设置回款账户页面*/
- (void)toSetBackAccountActivity;


/**车险调用的跳转*/
- (void)passUrl:(NSString *)url;

@end




@interface injs : NSObject<injsDelegate>


@property (assign,nonatomic)id<injsDelegate> delegate;


@end
