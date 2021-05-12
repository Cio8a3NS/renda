//
//  ResetView.m
//  仁达
//
//  Created by wang dong on 16/8/2.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "ResetView.h"

#define BALCK_COLOR GLOBALCOLOR(51,51,51)

@implementation ResetView

-(id)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        
        [self addView];
        
    }
    
    return self;
}



/**
 *  添加子视图
 */
-(void)addView
{
    
    _timeCount = 60;
    
    UILabel *noticeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 20)];
    noticeLab.textAlignment = 1;
    noticeLab.textColor = BALCK_COLOR;
    noticeLab.text = @"已发送短信验证码，请注意查收。";
    [self addSubview:noticeLab];
    
    
    int height1 = 90-17;
    int height2 = 54;
    for (int i = 0; i<4; i++) {
        
        if (i==1) {
            height2 = 42;
            height1 = height1+54;
        }else if(i==2){
            height2 = 54;
            height1 = height1+42;
        }else if(i==3){
            height2 = 54;
            height1 = height1+54;
        }
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, height1, SCREEN_WIDTH-40, height2)];
        [self addSubview:view];
        
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, height2-1,SCREEN_WIDTH-40 , 1)];
        lineview.backgroundColor = GLOBALCOLOR(232, 232, 232);
        [view addSubview:lineview];
        
        
        
        UILabel *leftLab = [[UILabel alloc] init];
        if (i==1) {
            
            leftLab.textColor = GLOBALCOLOR(102, 102, 102);
            leftLab.font = [UIFont systemFontOfSize:14];
            leftLab.frame = CGRectMake(0, 20, 200, 15);
            leftLab.text = @"请设置新的登录密码";
            [view addSubview:leftLab];
            
        }else{
            
            leftLab.textColor = BALCK_COLOR;
            leftLab.frame = CGRectMake(0, 17, 200, 20);
            [view addSubview:leftLab];
            
            
            UITextField *textField = [[UITextField alloc] init];
            [view addSubview:textField];
            textField.clearButtonMode = UITextFieldViewModeAlways;
            
            
           
            
            if (i==0) {
                
                [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(CGSizeMake(130, 30));
                    make.top.equalTo(view).offset(12);
                    make.left.equalTo(view).offset(90);
                    
                }];
                
                leftLab.text = @"验证码";
                textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: GLOBALCOLOR(176, 176, 176)}];
                textField.keyboardType = UIKeyboardTypeNumberPad;
                
                _verifCodeField = textField;
                
                
                _codeLab = [[UILabel alloc] init];
                _codeLab.userInteractionEnabled = YES;
                _codeLab.textColor = GLOBALCOLOR(53, 153, 238);
                _codeLab.text = @"60s";
                _codeLab.font = [UIFont systemFontOfSize:14];
                _codeLab.textAlignment = 1;
                [view addSubview:_codeLab];
                [_codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(view).offset(0);
                    make.top.equalTo(view).offset(17);
                    make.height.mas_equalTo(20);
                    
                }];
                
                
                
                
            }else{
                
                [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(CGSizeMake(screenWidth - 90 -35, 30));
                    make.top.equalTo(view).offset(12);
                    make.left.equalTo(view).offset(90);
                    
                }];
                
                UIView *eyeView = [[UIView alloc] init];
                [view addSubview:eyeView];
                
                [eyeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.right.equalTo(view).offset(0);
                    make.top.equalTo(view).offset(0);
                    make.size.mas_equalTo(CGSizeMake(54, 54));
                    
                }];
                
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(34, 17, 20, 20)];
                imgView.contentMode = 1;
                [eyeView addSubview:imgView];
                

                
                
            if (i==2){
                imgView.image = LOAD_IMAGE(@"eye2");
                leftLab.text = @"新密码";
                textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"组合字母、数字或符号" attributes:@{NSForegroundColorAttributeName: GLOBALCOLOR(176, 176, 176)}];
                textField.secureTextEntry = YES;
                _nPwdField = textField;
                
                
                eyeView.userInteractionEnabled = YES;
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
                [eyeView addGestureRecognizer:tap];
                [[tap rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
                    
                    _nPwdField.secureTextEntry = !_nPwdField.secureTextEntry;
                    
                    if (_nPwdField.secureTextEntry==YES) {
                        
                        imgView.image = LOAD_IMAGE(@"eye2");
                        
                    }else{
                        imgView.image = LOAD_IMAGE(@"eye1");

                    }
                    
                }];
                
                
            }else{
                
                imgView.image = LOAD_IMAGE(@"eye2");
                leftLab.text = @"确认密码";
                textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入密码" attributes:@{NSForegroundColorAttributeName: GLOBALCOLOR(176, 176, 176)}];
                
                textField.secureTextEntry = YES;
                _conPwdField = textField;
                
                eyeView.userInteractionEnabled = YES;
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
                [eyeView addGestureRecognizer:tap];
                [[tap rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
                    
                    _conPwdField.secureTextEntry = !_conPwdField.secureTextEntry;
                    
                    if (_conPwdField.secureTextEntry==YES) {
                        
                        imgView.image = LOAD_IMAGE(@"eye2");
                        
                    }else{
                        imgView.image = LOAD_IMAGE(@"eye1");
                        
                    }
                    
                }];
                
                
            }
            
            }
            
        
        }
        
        
        
    }
    
    
    _confirmButton = [[UIButton alloc] init];
    _confirmButton.layer.cornerRadius = 4;
    _confirmButton.layer.masksToBounds = YES;
    _confirmButton.backgroundColor = mycolor;
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确认重置" forState:UIControlStateNormal];
    [self addSubview:_confirmButton];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(310);
        make.height.mas_equalTo(44);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        
    }];
    
    
    [self startTimeCount];
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}





/**
 *  开始倒数记述
 */
-(void)startTimeCount
{
    _codeLab.userInteractionEnabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountAction) userInfo:nil repeats:YES];
    [_timer fire];
}

/**
 *  定时器
 */
-(void)timeCountAction
{
    _codeLab.text = [NSString stringWithFormat:@"%d秒重试",_timeCount];
    _timeCount--;
    if (_timeCount<0) {
        
        _codeLab.text = @"发送验证码";
        _timeCount = 60;
        [_timer invalidate];
        _timer = nil;
        _codeLab.userInteractionEnabled = YES;
        
    }
}


@end
