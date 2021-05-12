//
//  RGGHomeCollectionViewCell.m
//  仁达理财
//
//  Created by yuanmc on 16/7/27.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGHomeCollectionViewCell.h"
@interface RGGHomeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *IconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation RGGHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self setUI];
}

- (void)setUI{
    self.IconImgView.image = [UIImage imageNamed:[[_dic allValues] lastObject]];
    self.nameLabel.text = [[_dic allKeys] lastObject];
}
//- (void)drawRect:(CGRect)rect{
//    for (int i = 0; i<2; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i*rect.size.height-1,(screenWidth - 2)/3.0, 1)];
//        view.backgroundColor = [UIColor redColor];
//        [self addSubview:view];
//    }
//    
//}
@end
