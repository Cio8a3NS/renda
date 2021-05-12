//
//  RootViewController.h
//  仁达理财
//
//  Created by 杨方军 on 16/7/26.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController


/**加载页面的相关数据*/
- (void)initlizeDataSource;

/**加载页面的UI*/
- (void)initlizeAppance;

/**数据源*/
@property (strong,nonatomic)NSMutableArray *dataSource;

@end
