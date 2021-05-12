//
//  RGGHomeController.m
//  仁达理财
//
//  Created by yuanmc on 16/7/25.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGHomeController.h"
#import "WTImageScroll.h"
#import "RGGHomeCollectionView.h"
#import "RGGMegController.h"
#define  pageViewH 170

@interface RGGHomeController ()
/** 分页控件 */
//@property (nonatomic, strong) RGGPageView *pageView;
/**图标scroller*/

@property (nonatomic, strong) RGGHomeCollectionView *collectionView;
@property (nonatomic, strong) UIButton *mesBtn;

@end

@implementation RGGHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    [self setupNavBar];
//    [self setupPageView];
    [self setupScrollView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.translucent = YES;
    
}
//设置导航条
- (void)setupNavBar{
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo-0"]];
    
    NSArray *array = @[@"img_00",@"img_01",@"img_02"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.mesBtn];
    UIView *imageScorll=[WTImageScroll ShowLocationImageScrollWithFream:CGRectMake(0, 0, screenWidth, ip6p?pageViewH * 1.1:ip6?pageViewH:pageViewH/1.3) andImageArray:array andBtnClick:^(NSInteger tagValue) {
        NSLog(@"点击的图片----%@",@(tagValue));
    }];
    [self.view addSubview:imageScorll];
}

//// 设置轮播view
//- (void)setupPageView{
//    _pageView = [RGGPageView pageView];
//    _pageView.contentMode = UIViewContentModeScaleToFill;
//    _pageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ip5?190:pageViewH);
//    _pageView.imageNames = @[@"img_00", @"img_01", @"img_02"];
//    _pageView.otherColor = [UIColor grayColor];
//    _pageView.currentColor = [UIColor orangeColor];
//    [self.view addSubview:_pageView];
//    self.pageView = _pageView;
//}

//设置主页面上的图标
- (void)setupScrollView{
    [self.view addSubview:self.collectionView];
}

#pragma mark - 懒加载
- (RGGHomeCollectionView *)collectionView{
    if (!_collectionView) {
        //创建一个layout布局类
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小为100*100
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-2)/3.0f, (SCREEN_WIDTH-2)/3.0f);
        _collectionView = [[RGGHomeCollectionView alloc]initWithFrame:CGRectMake(0, ip6p?pageViewH * 1.1:ip6?pageViewH:pageViewH/1.3, SCREEN_WIDTH, SCREEN_HEIGHT-(ip6p?pageViewH * 1.1:ip6?pageViewH:pageViewH/1.3)) collectionViewLayout:layout];
   
        _collectionView.backgroundColor = GLOBALCOLOR(239, 240, 241);
    }
            
    return _collectionView;
}


- (UIButton *)mesBtn{
    if (!_mesBtn) {
        _mesBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        [_mesBtn setBackgroundImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
//        _mesBtn.size = _mesBtn.currentBackgroundImage.size;
        
        [[_mesBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            RootWebViewController *webView = [[RootWebViewController alloc]init];
            webView.url = @"http://59.63.178.159:8803/Activity/index.html?mobile=1&equipment=IOS_jhj20161029220513532280974595909";
            [self.navigationController pushViewController:webView animated:YES];
//            [self.navigationController pushViewController:[[RGGMegController alloc]init] animated:YES];
        }];
       
    }
    
    return _mesBtn;

}

@end
