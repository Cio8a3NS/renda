//
//  RGGYiJinTiXianTableView.h
//  仁达理财
//
//  Created by wangdong on 16/8/26.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGGYiJinTiXianTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)NSMutableArray *yijitixianModelArray;
@end
