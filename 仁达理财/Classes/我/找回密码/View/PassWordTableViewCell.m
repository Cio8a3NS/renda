//
//  PassWordTableViewCell.m
//  仁达理财
//
//  Created by 杨方军 on 16/7/30.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "PassWordTableViewCell.h"



@interface PassWordTableViewCell ()<UITextFieldDelegate>

@property (strong,nonatomic)UILabel *titleLabel;

@end

@implementation PassWordTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self loadViews];
        
    }
    
    return self;
    
    
}


#pragma mark - 加载UI
- (void)loadViews{
    
    float padding = 20;
    self.titleLabel = [FactoryTool factoryLabel:@"标题" color:[UIColor blackColor] size:16];
    self.inputField = [FactoryTool factoryTextField:@"预留" color:[UIColor blackColor] size:16];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.inputField];
    
    UIView *lineViewOne = [[UIView alloc] init];
    lineViewOne.backgroundColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.0f];
    [self.contentView addSubview:lineViewOne];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(padding);
        make.width.equalTo(@100);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.titleLabel);
        make.width.equalTo(self.contentView).multipliedBy(0.4);
        
    }];
    
 
    
    
    [lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView).offset(-1);
        make.height.equalTo(@0.5);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).offset(-padding);
        
    }];
    
    
    
    
}







- (void)setModel:(PassWordModel *)model{


    self.titleLabel.text = model.title;
    self.inputField.placeholder = model.placeStr;
    if (model.show_Code == 1) {
        
        [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-15);
            make.width.equalTo(@80);
            make.height.top.equalTo(self.inputField);
        }];
        
    }



}


- (AuthCodeView *)codeView{

    if (!_codeView) {
        
        _codeView = [[AuthCodeView alloc] init];
        _codeView.frame = CGRectMake(screenWidth-60-20, 10, 60, 29);
        _codeView.layer.cornerRadius = 5;
        _codeView.layer.masksToBounds = YES;
        _codeView.layer.borderWidth = 1;
        _codeView.layer.borderColor = dividingline.CGColor;
        [self.contentView addSubview:_codeView];
        
    }
    return _codeView;


}








@end
