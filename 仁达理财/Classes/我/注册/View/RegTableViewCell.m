//
//  RegTableViewCell.m
//  金惠家
//
//  Created by 杨方军 on 16/7/29.
//  Copyright © 2016年 金惠家. All rights reserved.
//

#import "RegTableViewCell.h"

@interface RegTableViewCell ()

@property (strong,nonatomic)UILabel *titleLabel;


@property (strong,nonatomic)UIButton *rightBtn;

@property (strong,nonatomic)NSTimer *timer;


@end


@implementation RegTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self loadViews];
        
    }
    
    return self;


}


#pragma mark - 加载UI
- (void)loadViews{

    float padding = 20;
    self.titleLabel = [FactoryTool factoryLabel:@"标题" color:[UIColor blackColor] size:14];
    self.inputField = [FactoryTool factoryTextField:@"预留" color:[UIColor blackColor] size:14];
    
    self.rightBtn = [FactoryTool factoryImageButton:@"" width:20];
    [self.rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.inputField];
    [self.contentView addSubview:self.rightBtn];
    
    UIView *lineViewOne = [[UIView alloc] init];
    lineViewOne.backgroundColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f];
    [self.contentView addSubview:lineViewOne];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(padding);
        make.width.equalTo(self.contentView).multipliedBy(0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.titleLabel);
        make.width.equalTo(self.contentView).multipliedBy(0.45);
        
    }];
    
    [lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.contentView).offset(-1);
        make.height.equalTo(@0.5);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).offset(-padding);
        
    }];
    

    

}



- (void)setRegModel:(RegModel *)regModel{

    _regModel                       = regModel;
    self.titleLabel.text            = regModel.title;
    self.inputField.placeholder     = regModel.placeStr;
    self.inputField.secureTextEntry = regModel.is_Show == 1 ? YES:NO;

   
    if (regModel.btnType == ImageType) {
        
        UIImage *titleImage = [UIImage imageNamed:regModel.rightBtnStr];
        [self.rightBtn setImage:titleImage forState:UIControlStateNormal];
          [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateSelected];
    
        
        [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-20);
            make.height.equalTo(@30);
            make.centerY.equalTo(self.inputField);
            
        }];
        return;
    }
    
    if (regModel.btnType == DefaultType) {
        
        [self.rightBtn setTitle:regModel.rightBtnStr forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithRed:53/255.0 green:153/255.0 blue:238/255.0 alpha:1.000] forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-2);
            make.height.equalTo(@30);
            make.left.equalTo(self.inputField.mas_right);
            make.centerY.equalTo(self.inputField);
            
        }];
        return;
    }
    
    if (regModel.btnType == HideIcoType) {
    
        [self.inputField mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.titleLabel.mas_right);
            make.top.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView).offset(-20);
            
        }];
    
    
    }
    

}

- (void)rightAction:(UIButton *)sender{
    
//    if (self.regModel.is_Show != 1&&self.delegate && [self.delegate respondsToSelector:@selector(getCodeAction:)]) {
         ResultBlock block = ^(){
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        self.timer.fireDate = [NSDate distantPast];
        sender.enabled = NO;
              };
        
        
        [self.delegate getCodeAction:block];
        return;
//    }
    sender.enabled = YES;
    sender.selected = !sender.selected;
      self.inputField.secureTextEntry = !self.inputField.secureTextEntry;

}


- (void)codeAction{

    static NSInteger time = 60;
    [self.rightBtn setTitle:[NSString stringWithFormat:@"%ld秒重试",(long)time--] forState:UIControlStateNormal];
    if (time <= 0 ) {
        self.rightBtn.enabled = YES;
        self.timer.fireDate = [NSDate distantFuture];
        [self.rightBtn setTitle:self.regModel.rightBtnStr forState:UIControlStateNormal];
        time = 60;
        
    }

}


- (NSTimer *)timer{

    if (!_timer) {
   
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(codeAction) userInfo:nil repeats:YES];
    }
    return _timer;

}






@end
