//
//  UIView+Category.m
//  仁达理财
//
//  Created by yuanmc on 16/6/20.
//  Copyright © 2016年 然哥哥. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
#pragma mark-获取所在控制器
//得到此view 所在的viewController
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
