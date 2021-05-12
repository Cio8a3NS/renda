//
//  AuthCodeView.m
//  AppSetting
//
//  Created by yindaofu on 16/3/17.
//  Copyright © 2016年 yindaofu. All rights reserved.
//


#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define KLineCount 4
#define KLineWidth 1.0
#define KCharCount 4
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]



#import "AuthCodeView.h"

@implementation AuthCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 2.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self getAuthcode];
        
    }
    return self;
}


- (void)getAuthcode
{
    _dataArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    
    _authCodeStr = [[NSMutableString alloc] initWithCapacity:KCharCount];
    for (int i = 0; i < KCharCount; i++) {
        
        NSInteger index = arc4random() % (_dataArray.count-1);
        NSString *tempStr = [_dataArray objectAtIndex:index];
        _authCodeStr = (NSMutableString *)[_authCodeStr stringByAppendingString:tempStr];
        
    }

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self getAuthcode];
    
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.backgroundColor = [UIColor whiteColor];
    NSString *text = [NSString stringWithFormat:@"%@",_authCodeStr];
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];

    int width = rect.size.width/text.length - cSize.width;
    int height = rect.size.height - cSize.height;
    
    CGPoint  point;
    
    float pX,pY;
    
    for (int i = 0; i < text.length; i++)
    {
        pX = arc4random() % width + rect.size.width/text.length*i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%c",c];
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
        
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, KLineWidth);
    
    for (int i = 0; i < KLineCount; i++) {
        UIColor *color = kRandomColor;
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        
        CGContextStrokePath(context);
        
    }
    
}


@end
