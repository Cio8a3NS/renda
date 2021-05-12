//
//  HttpTool.h
//  仁达理财
//
//  Created by yuanmc on 16/6/6.
//  Copyright © 2016年 yuanmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HttpTool : NSObject
+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
//上传图片
+ (NSURLSessionUploadTask*)uploadTaskWithImage:(UIImage *)image withUploadURL:(NSString *)url completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock;
//上传多张图片
+ (void)requestWithUrl:(NSString *)url

      withPostedImages:(NSArray *)imagesArray

      WithSuccessBlock:(void (^)(NSArray * resultArray))successBlock

           WithNeebHub:(BOOL)needHub

              WithView:(UIView *)viewWithHub

              WithData:(NSDictionary *)dataDic;
@end
