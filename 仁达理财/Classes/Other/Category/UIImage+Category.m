//
//  UIImage+Category.m
//  仁达理财
//
//  Created by yuanmc on 16/9/1.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
- (UIImage *)rescaleImageToSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];  // scales image to rect
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
    
}
@end
