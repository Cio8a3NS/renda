//
//  PassWordTableViewCell.h
//  仁达
//
//  Created by 杨方军 on 16/7/30.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassWordModel.h"
#import "AuthCodeView.h"


@interface PassWordTableViewCell : UITableViewCell

/**动态验证码*/
@property (strong,nonatomic)AuthCodeView *codeView;

@property (strong,nonatomic)PassWordModel *model;

@property (strong,nonatomic)UITextField *inputField;


@end
