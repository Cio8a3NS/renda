//
//  NSString+MD5.h
//  仁达理财
//
//  Created by yuanmc on 16/6/16.
//  Copyright © 2016年 然哥哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
/**字符串md5加密*/
- (NSString *)MD5;
-(BOOL)isValidateEmail;
+ (NSString *) uuid;
+ (NSString *)timeToDate:(CGFloat)time;
@end
