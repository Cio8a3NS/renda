//
//  RGGNavigationController.m
//  仁达理财
//
//  Created by yuanmc on 16/5/25.
//  Copyright © 2016年 然哥哥 All rights reserved.
//
#import "RGGNavigationController.h"

@interface RGGNavigationController ()
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation RGGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//只初始化一次
+ (void)initialize
{
//    UIImage *background = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
    //设置导航条
    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:background forBarMetrics:UIBarMetricsDefault];
    [bar setBarTintColor:GLOBALCOLOR(18, 35, 52)];
    
    if (ip4) {
        
    }
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

//拦截push进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //如果在控制器有设置，就可以让后面设置的按钮可以覆盖它
    [super pushViewController:viewController animated:animated];
}

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
//        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
//        [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_backBtn sizeToFit];
//        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self popViewControllerAnimated:YES];
        }];
    }
    return _backBtn;
}

//- (void)back{
// [self popViewControllerAnimated:YES];
//}

- (UIStatusBarStyle )preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
