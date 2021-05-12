//
//  NSString+MD5.m
//  仁达理财
//
//  Created by yuanmc on 16/6/16.
//  Copyright © 2016年 然哥哥. All rights reserved.
//

#import "NSString+Category.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (Category)
- (NSString *)MD5
{
    return [NSString MD5ByAStr:self];
}
+ (NSString *)MD5ByAStr:(NSString *)aSourceStr {
    const char* cStr = [aSourceStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    
    return ret;
}

-(BOOL)isValidateEmail

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}

+ (NSString *) uuid {
    
    CFUUIDRef puuid = CFUUIDCreate( nil );
    
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    
    
    return result;
    
}

//时间戳转日期

+ (NSString *)timeToDate:(CGFloat)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *theday = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *day = [dateFormatter stringFromDate:theday];
    return day;
}



@end
