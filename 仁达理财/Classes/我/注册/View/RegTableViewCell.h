//
//  RegTableViewCell.h
//  金惠家
//
//  Created by 杨方军 on 16/7/29.
//  Copyright © 2016年 金惠家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegModel.h"
typedef void (^ResultBlock)();
@protocol RegTableViewCellDelegate <NSObject>

/**获取验证码*/
- (void)getCodeAction:(ResultBlock )block;


@end
@interface RegTableViewCell : UITableViewCell


@property (strong,nonatomic)RegModel *regModel;
@property (strong,nonatomic)UITextField *inputField;

@property (assign,nonatomic)id<RegTableViewCellDelegate> delegate;


@end
