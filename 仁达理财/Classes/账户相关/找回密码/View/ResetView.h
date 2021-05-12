//
//  ResetView.h
//  仁达
//
//  Created by wang dong on 16/8/2.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetView : UIView

@property(nonatomic,strong)UITextField *verifCodeField;//验证码
@property(nonatomic,strong)UILabel *codeLab;//发送验证码
@property(nonatomic,strong)UITextField *nPwdField;//新密码
@property(nonatomic,strong)UITextField *conPwdField;//确认密码

@property(nonatomic,strong)UIButton *confirmButton;//确认


@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)int timeCount;

-(void)startTimeCount;// 开始倒数记述

@end
