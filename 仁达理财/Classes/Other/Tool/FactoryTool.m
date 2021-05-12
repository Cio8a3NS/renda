//
//  FactoryTool.m
//  ControlSystem
//
//  Created by 小宸宸Dad on 16/3/8.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "FactoryTool.h"
#import <CommonCrypto/CommonCrypto.h>
#import "KeychainItemWrapper.h"
@implementation FactoryTool


+ (UIButton *)factoryButton:(NSString *)title color:(UIColor *)color{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;
    return button;
    
    
}


+ (UIButton *)factoryImageButton:(NSString *)imageStr width:(NSInteger)width{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *titleimage = [UIImage imageNamed:imageStr];
    [button setContentMode:UIViewContentModeScaleAspectFit];
    [button setImage:titleimage forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    return button;

}



+ (UILabel *)factoryLabel:(NSString *)text color:(UIColor *)color size:(NSInteger)size{


    UILabel *label = [[UILabel alloc]init];
    label.textColor = color;
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    return label;

}

+ (UITextField *)factoryTextField:(NSString *)placeText color:(UIColor *)color size:(NSInteger)size{
    
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = placeText;
    textField.textColor = color;
    textField.font = [UIFont systemFontOfSize:size];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;

}

+ (UIImageView *)factoryImageView:(NSString *)imageStr{

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageStr]];
    return imageView;

}

//检测是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    
    NSString * MOBILE = @"^1[0-9]{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)){
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 检查密码是否符合规则
+ (BOOL)predicatePassWord:(NSString *)passWord{
    
    NSString * passWordPre = @"([A-Za-z0-9]+[A-Za-z0-9]{5,16})";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordPre];
    
    if (([regextestmobile evaluateWithObject:passWord] == YES)){
        return YES;
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"密码不符合规则"];
        return NO;
    }
    
}

+ (NSString*)rendeCode{
    
    NSString *codeString = [NSString stringWithFormat:@"%ldldcjld",(long)[[NSDate date] timeIntervalSince1970]];
    
    return [[FactoryTool md532BitUpper:codeString] uppercaseString];
}

+ (NSString*)md532BitLower:(NSString *)str

{
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    
    CC_MD5( cStr,[num intValue], result );
    
    
    return [[NSString stringWithFormat:
             
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             
             result[0], result[1], result[2], result[3],
             
             result[4], result[5], result[6], result[7],
             
             result[8], result[9], result[10], result[11],
             
             result[12], result[13], result[14], result[15]
             
             ] lowercaseString];
    
}

+ (NSString*)md532BitUpper:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [NSString stringWithFormat:
             
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             
             result[0], result[1], result[2], result[3],
             
             result[4], result[5], result[6], result[7],
             
             result[8], result[9], result[10], result[11],
             
             result[12], result[13], result[14], result[15]
             
             ] ;
    
}

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getUniqueclientID
{
    NSString *currentDate = [FactoryTool getCurrentSystemTime]; //获得当前日期
    
    NSString *randomNumber1 = [FactoryTool getRandomNumber:100000 to:1000000]; //100W以内的随机数
    
    NSString *randomNumber2 = [FactoryTool getRandomNumber:100000 to:1000000]; //100W以内的随机数
    
    NSString *clientId = [NSString stringWithFormat:@"IOS_jhj%@%@%@", currentDate, randomNumber1, randomNumber2];
    
    return clientId;
}

+ (NSString *)getRandomNumber: (int)from to:(int)to
{
    NSString *str = [NSString stringWithFormat:@"%d", (int)(from + (arc4random() % (to - from + 1)))];
    return str;
}

+ (NSString *)getCurrentSystemTime
{
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}


+ (NSString *)myuuid{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"kUUID" accessGroup:nil];
    NSString *aliaStr = [wrapper objectForKey:(id)CFBridgingRelease(kSecValueData)];
    
    return aliaStr;
}





@end
