//
//  RGGSigmentScrollView.m
//  仁达理财
//
//  Created by yuanmc on 16/8/15.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGSigmentScrollView.h"
#import "RGGSigmentView.h"
@interface RGGSigmentScrollView()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *bgScrollView;
@property (strong,nonatomic)RGGSigmentView *segmentToolView;

@end

@implementation RGGSigmentScrollView


-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgScrollView];
        
        
        _segmentToolView=[[RGGSigmentView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44) titles:titleArray clickBlick:^void(NSInteger index) {
            NSLog(@"-----%ld",index);
            [_bgScrollView setContentOffset:CGPointMake(screenWidth*(index-1), 0)];
        }];
        [self addSubview:_segmentToolView];
        
        
        for (int i=0;i<contentViewArray.count; i++ ) {
            
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame=CGRectMake(screenWidth * i, _segmentToolView.bounds.size.height, screenWidth, _bgScrollView.frame.size.height-_segmentToolView.bounds.size.height);
            [_bgScrollView addSubview:contentView];
        }
        
        
    }
    
    return self;
}

-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, screenWidth, self.bounds.size.height-_segmentToolView.bounds.size.height)];
        _bgScrollView.contentSize=CGSizeMake(screenWidth*2, self.bounds.size.height-_segmentToolView.bounds.size.height);
        _bgScrollView.showsVerticalScrollIndicator=NO;
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.delegate=self;
        _bgScrollView.bounces=NO;
        _bgScrollView.pagingEnabled=YES;
    }
    return _bgScrollView;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_bgScrollView)
    {
        NSInteger p=_bgScrollView.contentOffset.x/screenWidth;
        _segmentToolView.defaultIndex=p+1;
        
    }
    
}


@end
