//
//  FJRootViewController.h
//  仁达
//
//  Created by 杨方军 on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJRootViewController : UIViewController


/**加载页面的相关数据*/
- (void)initlizeDataSource;

/**加载页面的UI*/
- (void)initlizeAppance;

/**数据源*/
@property (strong,nonatomic)NSMutableArray *dataSource;


@end
