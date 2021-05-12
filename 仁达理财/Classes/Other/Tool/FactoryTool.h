//
//  FactoryTool.h
//  ControlSystem
//
//  Created by 小宸宸Dad on 16/3/8.
//  Copyright © 2016年 fj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactoryTool : NSObject

+ (UIButton *)factoryButton:(NSString *)title color:(UIColor *)color;


+ (UIButton *)factoryImageButton:(NSString *)imageStr width:(NSInteger)width;

+ (UILabel *)factoryLabel:(NSString *)text color:(UIColor *)color size:(NSInteger)size;

+ (UITextField *)factoryTextField:(NSString *)placeText color:(UIColor *)color size:(NSInteger)size;


+ (UIImageView *)factoryImageView:(NSString *)imageStr;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)predicatePassWord:(NSString *)passWord;
+ (NSString*)md532BitUpper:(NSString *)str;//32位大写
+ (NSString*)md532BitLower:(NSString *)str;//32位小写
+ (NSString*)rendeCode; //仁达理财sign


//生成唯一标识
+ (NSString *)getUniqueclientID;

//取出唯一标识

+ (NSString *)myuuid;


@end
