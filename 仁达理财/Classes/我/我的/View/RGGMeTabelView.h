//
//  RGGMeTabelView.h
//  仁达
//
//  Created by yuanmc on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol jumpWebDelegate<NSObject>

-(void)jumpWeb:(NSIndexPath*) indexPath;

@end

@interface RGGMeTabelView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) id <jumpWebDelegate> jumpDelegate;

@property(nonatomic, strong) NSArray *meArray;
@end
