//
//  RGGMeCell.m
//  仁达
//
//  Created by yuanmc on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "RGGMeCell.h"

@implementation RGGMeCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect imgFrame =  self.imageView.frame;
    imgFrame.origin.x = 20;
    self.imageView.frame = imgFrame;
    
    CGRect titleFrame =  self.textLabel.frame;
    titleFrame.origin.x = 32.5+17;
    self.textLabel.frame = titleFrame;
    
    CGRect accessoryFrame =  self.accessoryView.frame;
    accessoryFrame.origin.x = SCREEN_WIDTH - 100;
    self.accessoryView.frame = accessoryFrame;
    
    self.imageView.image = [UIImage imageNamed:[[_rowDic allValues]lastObject]];
    //nslog(@"%@",NSStringFromCGRect(self.imageView.bounds));
    self.textLabel.text = [[_rowDic allKeys]lastObject];
    self.textLabel.font = [UIFont fontWithName:@"PingFang SC" size:15];
    self.textLabel.textColor = GLOBALCOLOR(51, 51, 51);
//    self.textLabel.backgroundColor = [UIColor redColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setRowDic:(NSDictionary *)rowDic{
    _rowDic = rowDic;

}
- (void)drawRect:(CGRect)rect
{
    //取消每个分组最后一个cell的分割线
    if ([[[_rowDic allValues]lastObject] isEqual:@"密码登录"]||[[[_rowDic allValues]lastObject] isEqual:@"我-(1)"]) {
        return;
    }
    _fengeCell = [[UIView alloc]initWithFrame:CGRectMake(32.5+17, rect.size.height, SCREEN_WIDTH-(32.5+17), 0.5)];
    _fengeCell.backgroundColor = GLOBALCOLOR(217, 217, 217);
  
    [self addSubview:_fengeCell];
}
@end
