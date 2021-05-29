//
//  RootWebViewController.m
//  HJLC_H5
//
//  Created by 小宸宸Dad on 16/7/13.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "RootWebViewController.h"
#import "injs.h"
#import "MJRefresh.h"
#import <JavaScriptCore/JavaScriptCore.h>
//#import "WXApi.h"
//#import "WXApiObject.h"
//#import "WebViewJavascriptBridge.h"
//#import "JWT.h"
//#import "JWTAlgorithmFactory.h"
//#import "HJLC_UserLoginViewController.h"
//#import "HJLC_CheckAccountViewController.h"
//#import "HJLC_SetBackCashAccountViewController.h"
//#import "HJLC_AccountMoreSettingViewController.h"
//#import "AccountViewController.h"

@interface RootWebViewController ()<UIAlertViewDelegate,UIWebViewDelegate,injsDelegate,UIGestureRecognizerDelegate>


@property (strong,nonatomic)UIWebView *webView;

@property (nonatomic, strong) JSContext *jsContext;

/**显示正在刷新*/
@property (strong,nonatomic)UILabel *refreshLabel;

//@property WebViewJavascriptBridge* bridge;

@end


@implementation RootWebViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = NO;
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) // 判断 用户是否安装微信
        
    {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];//监听一个通知
    }

    
    if (_needRefresh==YES) {
        _needRefresh = NO;
        
        //判断url
        [self judgeUrl];
        
        
    }
}

//移除通知
- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  判断url
 */
-(void)judgeUrl
{
    
//    NSDictionary *dic;
//    
//    UserInfo *user = [UserInfo sharedManager];
//    if(user.token.length > 0){
//        
//        dic = @{@"mobile":user.mobile,@"source":@"app"};
//        
//    }else{
//        
//        dic = @{@"source":@"app"};
//        
//    }
//
//    
//    self.url = [NSString AltUrl:self.url withDic:dic withType:_type];
//    
   
    NSURL *url = [NSURL URLWithString:self.url];
    
//    RootWebViewController *qweb = [[RootWebViewController alloc] init];
//    qweb.url = self.url;
//    qweb.type = self.type;
//    [self.navigationController pushViewController:qweb animated:YES];
//    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone; //view不需要拓展到整个屏幕
    self.navigationController.navigationBar.translucent = NO;
    self.webView.scrollView.header.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouchAction)];
//    tap.delegate = self;
//    [self.webView addGestureRecognizer:tap];
//    UISwipeGestureRecognizer *swipeTap = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(refreshStateChange)];
    
//    [swipeTap setDirection:UISwipeGestureRecognizerDirectionDown];
//    
//    [self.view addGestureRecognizer:swipeTap];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
////    self.tabBarController.tabBar.hidden = YES;
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    [self ininav];
    
//    [self weixinPay];
    

}


- (void)sssss{


}
- (void)refreshStateChange{
    
    [self.webView.scrollView.mj_header beginRefreshing];;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.webView setFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        
    } completion:^(BOOL finished) {
        
        [self.webView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.webView reload];
        [self.webView.scrollView.mj_header endRefreshing];;
    }];

    

}

//#pragma NavigationBarFunction
//- (void)goBack
//{
//    if ([self.webView canGoBack]) {
//        
//        [self.webView goBack];
//        
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }
//}


/**清除缓存和cookie*/
//- (void)cleanCacheAndCookie{
//    //清除cookies
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies]){
//        [storage deleteCookie:cookie];
//    }
//    //清除UIWebView的缓存
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    NSURLCache * cache = [NSURLCache sharedURLCache];
//    [cache removeAllCachedResponses];
//    [cache setDiskCapacity:0];
//    [cache setMemoryCapacity:0];
//}

//- (void)goBack{
//    
//    if ([self.title isEqualToString:@"产品购买"]||[self.title isEqualToString:@"收银台"]) {
//        
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否放弃本次操作?" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *queitAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
//        UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//             [self.navigationController popViewControllerAnimated:YES];
//            
////            if (self.webViewType == OtherTyReturnpepe) {
////                
////                
////                [self.navigationController popViewControllerAnimated:YES];
////            }else{
////                
////                
////                [self.navigationController FjPop];
////                
////            }
//            
//            
//        }];
//        [alertVC addAction:queitAction];
//        [alertVC addAction:agreeAction];
//        [self presentViewController:alertVC animated:YES completion:nil];
//        
//        return;
//        
//        
//    }
//    
//     [self.navigationController popViewControllerAnimated:YES];
//    
////    if (self.webViewType == OtherTyReturnpepe) {
////        
////        
////        [self.navigationController popViewControllerAnimated:YES];
////    }else{
////    
////     
////        [self.navigationController FjPop];
////    
////    }
//    
//}
//
//

- (void)ininav{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    [backItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    [backItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    //    backItem.backgroundColor = [UIColor whiteColor];
    [backView addSubview:backItem];
    
    UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"close"]];
    imv.frame = CGRectMake(45, 10, 24, 24);
    [backView addSubview:imv];
    
    UIButton *closeItem = [[UIButton alloc]initWithFrame:CGRectMake(45, 0, 40, 44)];
    //    [closeItem setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    //     [closeItem setImageEdgeInsets:UIEdgeInsetsMake(10, -10, 10, 10)];
    //    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    //    [closeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    closeItem.backgroundColor = [UIColor whiteColor];
    [closeItem addTarget:self action:@selector(clickedCloseItem) forControlEvents:UIControlEventTouchUpInside];
    //    closeItem.titleLabel.font = TEXT_FONT(15);
    [backView addSubview:closeItem];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backView];
    
}

- (void)clickedCloseItem{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    


}
//微信支付
//- (void)weixinPay {
//    
//    if (_bridge) { return; }
//    
//    [WebViewJavascriptBridge enableLogging];
//    
//    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
//    [_bridge setWebViewDelegate:self];
//    
//    [_bridge registerHandler:@"sudiyiclientCallWechatPay" handler:^(NSDictionary *data, WVJBResponseCallback responseCallback) {
//        //nslog(@"data: %@", data);
//        //nslog(@"callback:%@",responseCallback);
//        
//        _hander = responseCallback;
//        //nslog(@"hander:%@",_hander);
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
//        {
//            //[[HudShow shareHudShow]showTextHudWithText:@"正在为您支付..."];
//            [self WXPayRequest:data[@"order"][@"appid"] nonceStr:data[@"order"][@"noncestr"] package:data[@"order"][@"package"] partnerId:data[@"order"][@"partnerid"] prepayId:data[@"order"][@"prepayid"] timeStamp:data[@"order"][@"timestamp"] sign:data[@"order"][@"sign"]];
//            
//            
//        } else {
//            [SVProgressHUD showInfoWithStatus:@"您未安装微信"];
//        }
//
//        
////        if ([WXApi isWXAppInstalled]) {
////            
////            //[[HudShow shareHudShow]showTextHudWithText:@"正在为您支付..."];
////            [self WXPayRequest:data[@"order"][@"appid"] nonceStr:data[@"order"][@"noncestr"] package:data[@"order"][@"package"] partnerId:data[@"order"][@"partnerid"] prepayId:data[@"order"][@"prepayid"] timeStamp:data[@"order"][@"timestamp"] sign:data[@"order"][@"sign"]];
////            
////            
////        } else {
////            [SVProgressHUD showInfoWithStatus:@"您未安装微信"];
////        }
//     
//    }];
//    
//    
//}

//#pragma mark - 发起支付请求 -
//- (void)WXPayRequest:(NSString *)appId nonceStr:(NSString *)nonceStr package:(NSString *)package partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId timeStamp:(NSString *)timeStamp sign:(NSString *)sign {
//    //调起微信支付
//    PayReq *wxreq = [[PayReq alloc] init];
//    wxreq.openID              = appId;
//    //nslog(@"appid:%@",appId);
//    wxreq.partnerId           = partnerId;
//    wxreq.prepayId            = prepayId;
//    wxreq.nonceStr            = nonceStr;
//    wxreq.timeStamp           = [timeStamp intValue];
//    wxreq.package             = package;
//    wxreq.sign                = sign;
//    
//    //向微信注册
//    [WXApi registerApp:appId withDescription:@"bigPlatform"];
//    [WXApi sendReq:wxreq];
//    //nslog(@"------>openID:%@",wxreq.openID);
//    
//}

#pragma mark - 通知信息
- (void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"])
    {
        [self alert:@"支付结果" msg:@"您已成功支付!"];
        NSDictionary *dictM = @{
                                @"code":@0,
                                //@"msg":@"asd",
                                @"err_msg":@"get_brand_wcpay_request:ok"
                                };
        
        
        _hander(dictM);
    }
    else
    {
        
        [self alert:@"支付结果" msg:@"取消支付!"];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    
    [alter show];
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    
    //nslog(@"%@",error.localizedDescription);
    
//}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    injs *jsClass = [[injs alloc]init];
    jsClass.delegate = self;
    self.jsContext[@"injs"] = jsClass;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        
        context.exception = exceptionValue;
        //nslog(@"异常信息：%@", exceptionValue);
    };
//    //nslog(@"%@",self.url);
//    //nslog(@"%@",request.mainDocumentURL);
//    NSString *jumpUrl = [request.mainDocumentURL absoluteString];
//    
//    if ([self.title isEqualToString:@"产品购买"]||[self.title isEqualToString:@"收银台"]||[self.title isEqualToString:@"交易详情"]) {
//        
//        return YES;
//    }
//    
//    if (![self.url isEqualToString:jumpUrl]) {
//        
//        RootWebViewController *jumpVC = [[RootWebViewController alloc]init];
//        jumpVC.url = jumpUrl;
//        jumpVC.webViewType = OtherTyReturnpepe;
//        [self.navigationController pushViewController:jumpVC animated:YES];
//        return NO;
//    }
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    injs *jsClass = [[injs alloc]init];
    jsClass.delegate = self;
    self.jsContext[@"injs"] = jsClass;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        
        context.exception = exceptionValue;
        //nslog(@"异常信息：%@", exceptionValue);
    };
    
    
    

}





#pragma mark - injsDelegate

/**关闭当前页面*/
- (void)closeThisActivity{
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    NSInteger number = 0;
    
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        
//        if ([controller isKindOfClass:[HJLC_CheckAccountViewController class]]) {
//            
//            HJLC_CheckAccountViewController *revise =(HJLC_CheckAccountViewController *)controller;
//            [self.navigationController popToViewController:revise animated:YES];
//            break;
//        }
//        if ([controller isKindOfClass:[HJLC_AccountMoreSettingViewController class]]) {
//            
//            HJLC_AccountMoreSettingViewController *revise =(HJLC_AccountMoreSettingViewController *)controller;
//            [self.navigationController popToViewController:revise animated:YES];
//            break;
//        }
//        
//        if ([controller isKindOfClass:[AccountViewController class]]) {
//            
//            AccountViewController *revise =(AccountViewController *)controller;
//            [self.navigationController popToViewController:revise animated:YES];
//            break;
//        }
//        
//        if ([controller isKindOfClass:[RootWebViewController class]]) {
//            
//            RootWebViewController *revise =(RootWebViewController *)controller;
//            [self.navigationController popToViewController:revise animated:YES];
//            break;
//        }
//        
//        
//    }
    
}

/**转调到个人中心*/
- (void)toPersonActivity{

    

}


- (void)passUrl:(NSString *)url{

    _needRefresh = YES;//需要登录后再刷新页面
    
    self.url = url;

    //nslog(@"%@",url);
    

}



/**转调到登录页面*/
- (void)toLoginActivity{

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    loginVC.chooseBackBlock = ^(BOOL b){
        
        //点击返回 不刷新
        _needRefresh = NO;
        
    };

    loginVC.url = @"url";
    [self.navigationController pushViewController:loginVC animated:YES];


}


///**账户中心数据回调 */
//- (void)accountDataCallBack;
//
//
///**绑卡成功数据回调 */
//- (void)bankDataCallBack:(id)json;
//
/** 关闭webview，跳转到短期选项*/
- (void)toShortProductItem{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"com.hjlc.selectIndex" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];

}





/** 设置本地webview的title */
- (void)setWebViewTitle:(NSString *)title{


    self.title = title;

}


- (void)toSetBackAccountActivity{

//    [self.navigationController pushViewController:[[HJLC_SetBackCashAccountViewController alloc]init] animated:YES];

}


- (void)tapTouchAction{


    [self.webView endEditing:YES];

}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    
    return YES;
}




- (void)dealloc{

    _webView.delegate = nil;
    [_webView removeFromSuperview];
    _webView = nil;
    self.tabBarController.tabBar.hidden = NO;


}



- (UILabel *)refreshLabel{

    if (!_refreshLabel) {
        
        _refreshLabel = [FactoryTool factoryLabel:@"正在刷新" color:[UIColor colorWithRed:1.000 green:0.273 blue:0.552 alpha:1.000] size:14];
        _refreshLabel.textAlignment = NSTextAlignmentCenter;
        _refreshLabel.frame = CGRectMake(0, -30, SCREEN_WIDTH, 30);
        [self.view addSubview:_refreshLabel];
    }
    return _refreshLabel;


}


- (UIWebView *)webView {
    
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _webView.scalesPageToFit = YES;
        _webView.userInteractionEnabled = YES;
        _webView.scrollView.bounces = NO;
        _webView.keyboardDisplayRequiresUserAction = NO;
        NSURL *url = [NSURL URLWithString:self.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        _webView.delegate = self;
    }
    
    return _webView;
}



@end
