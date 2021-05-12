//
//  RGGTabBar.m
//  仁达理财
//
//  Created by yuanmc on 16/5/25.
//  Copyright © 2016年 然哥哥 All rights reserved.
//

#import "RGGTabBar.h"

@implementation RGGTabBar

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //设置tabbar的文字颜色
        UITabBarItem *appearance = [UITabBarItem appearance];
        [appearance setTitleTextAttributes:@{
                                             NSForegroundColorAttributeName : GLOBALCOLOR(48, 126, 232)}
                                  forState:UIControlStateSelected];
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        [self setBarTintColor:GLOBALCOLOR(34, 37, 43)];//设置tabBar背景颜色
    }
    return self;
}

@end
