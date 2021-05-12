//
//  RGGSigmentScrollView.h
//  仁达理财
//
//  Created by yuanmc on 16/8/15.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGGSigmentScrollView : UIView<UIScrollViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray;

@end
