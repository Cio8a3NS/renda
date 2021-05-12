//
//  RootWebViewController.h
//  HJLC_H5
//
//  Created by 小宸宸Dad on 16/7/13.
//  Copyright © 2016年 HJ. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^WXHander)(id);

typedef NS_ENUM(NSInteger,WebViewReturnType){

    DefaultReturnType = 0,//默认返回状态,会显示tabBar
    OtherTyReturnpepe = 1//不会对tabbar进行任何处理

};

@interface RootWebViewController : FJRootViewController

@property (strong,nonatomic)NSString *url;
@property (strong,nonatomic)NSString *tempUrl;
@property(nonatomic,assign)int type;

@property(nonatomic,assign)BOOL needRefresh;//是否需要刷新页面

/**webViewType 怎么返回到上一页*/
@property (assign,nonatomic)WebViewReturnType webViewType;

@property(nonatomic,copy) WXHander hander;


@end
