//
//  LoginViewController.h
//  仁达
//
//  Created by 杨方军 on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "FJRootViewController.h"

@interface LoginViewController : FJRootViewController

/**是否隐藏返回按钮*/
@property (assign,nonatomic)BOOL hide_return;

/**是否回到根控制器*/
@property (assign,nonatomic)BOOL return_RootVC;


/**登录完成跳回H5页面的Url地址*/
@property (strong,nonatomic)NSString *url;

@property (nonatomic, copy) void(^chooseBackBlock)(BOOL b);

@end
