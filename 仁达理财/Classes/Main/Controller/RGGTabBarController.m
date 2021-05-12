//
//  RGGTabBarController.m
//  仁达理财
//
//  Created by yuanmc on 16/5/25.
//  Copyright © 2016年 然哥哥 All rights reserved.
//

#import "RGGTabBarController.h"
#import "RGGHomeController.h"
#import "RGGTransactionManagementController.h"
#import "RGGTradingFloorController.h"
#import "RGGBillingRecordController.h"
#import "RGGMeController.h"
#import "RGGNavigationController.h"
#import "RGGTabBar.h"
#import "LoginViewController.h"

@interface RGGTabBarController ()

@end
@implementation RGGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialControllers];
    //替换系统tabbar
    [self setValue:[[RGGTabBar alloc] init] forKeyPath:@"tabBar"];
}

//初始化子控制器
-(void)initialControllers {
    [self setupController:[[RGGHomeController alloc]init] image:@"tar_shouye" selectedImage:@"首页" title:@"首页"];
    [self setupController:[[RGGTransactionManagementController alloc]init] image:@"交易管理-拷贝" selectedImage:@"tar_jiaoyiguanli_select" title:@"交易管理"];
    [self setupController:[[RGGTradingFloorController alloc]init] image:@"交易-拷贝" selectedImage:@"tar_licaizhongxin_select" title:@"理财中心"];
    [self setupController:[[RGGBillingRecordController alloc]init] image:@"明细数据" selectedImage:@"tar_zhangdanjilu_select" title:@"账单记录"];
    
    
    [self setupController:[[RGGMeController alloc]init] image:@"我"  selectedImage:@"tar_me_select" title:@"我"];
}

//设置控制器
-(void)setupController:(UIViewController *)childVc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    UIViewController *viewVc = childVc;
    viewVc.tabBarItem.image = [UIImage imageNamed:image];
//    viewVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //不进行渲染  解决image是蓝色的问题
    viewVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewVc.tabBarItem.title = title;
    RGGNavigationController *navi = [[RGGNavigationController alloc]initWithRootViewController:viewVc];
    [self addChildViewController:navi];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
