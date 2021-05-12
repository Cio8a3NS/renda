//
//  RGGGuanFangTongGaoContentController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/29.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGGuanFangTongGaoContentController.h"

@interface RGGGuanFangTongGaoContentController ()
@property(nonatomic,strong)UIWebView *webViewContent;
@end

@implementation RGGGuanFangTongGaoContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI{
    self.title = _fangGongGaoModel.title;
    _webViewContent = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _webViewContent.backgroundColor=[UIColor whiteColor];
    _webViewContent.scrollView.bounces = NO;
    _webViewContent.scrollView.showsHorizontalScrollIndicator = NO;
//    _webViewContent.scrollView.scrollEnabled = NO;
    [_webViewContent sizeToFit];
    [self.view addSubview:_webViewContent];
//    _webViewContent.delegate=self;
 
//    NSString *htmlString= [webviewText stringByAppendingFormat:@"%@",content];
    [_webViewContent loadHTMLString:_fangGongGaoModel.content baseURL:nil];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
