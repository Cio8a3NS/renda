//
//  HttpTool.m
//  仁达理财
//
//  Created by yuanmc on 16/6/6.
//  Copyright © 2016年 yuanmc. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
@implementation HttpTool
+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    //显示状态栏的网络指示器
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *mgr = [self manager]; 
    //设置加载时间
    mgr.requestSerializer.timeoutInterval = 10.0f;
    
    [mgr GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(error);
        
    }];
    
}
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    //显示状态栏的网络指示器
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *mgr = [self manager];
    //设置加载时间
    mgr.requestSerializer.timeoutInterval = 10.0f;
//     mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(error);
    }];
}

- (NSURLSessionUploadTask*)uploadTaskWithImage:(UIImage*)image withUploadURL:(NSString *)url  completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {
    // 构造 NSURLRequest
    NSError* error = NULL;
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = myUserid;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.png" mimeType:@"multipart/form-data"];
    } error:&error];
    
    // 可在此处配置验证信息
    
    // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
    } completionHandler:completionBlock];
    
    return uploadTask;
}
 
+ (AFHTTPSessionManager *)manager {
    static AFHTTPSessionManager *manager = nil;
    if (manager == nil) {
        manager = [AFHTTPSessionManager manager];
    }
    return manager;
}

+ (void)requestWithUrl:(NSString *)url

      withPostedImages:(NSArray *)imagesArray

      WithSuccessBlock:(void (^)(NSArray * resultArray))successBlock

           WithNeebHub:(BOOL)needHub

              WithView:(UIView *)viewWithHub

              WithData:(NSDictionary *)dataDic

{
    [SVProgressHUD showWithStatus:@"上传图片中..."];
    if (imagesArray.count > 0) {
        
        
        
        //创建一个临时的数组，用来存储回调回来的结果
        
        NSMutableArray *temArray = [NSMutableArray array];
        
        
        
        for (int i = 0;  i < imagesArray.count; i++) {
            
            UIImage *imageObj = imagesArray[i];
            
            //截取图片
            
            NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
            
            
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            
            NSLog(@"%@",dataDic);
            // 访问路径
            
            [manager POST:url parameters:dataDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                
                
                // 上传文件
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                
                formatter.dateFormat = @"yyyyMMddHHmmss";
                
                NSString *str = [formatter stringFromDate:[NSDate date]];
                
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                
                
                
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
                
                
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                
                
                
                [temArray addObject:dic];
                
                [SVProgressHUD dismiss];
                [SVProgressHUD showInfoWithStatus:@"上传图片成功!"];
                //当所有图片上传成功后再将结果进行回调
                
                if (temArray.count == imagesArray.count) {
                    
                    successBlock(temArray);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showInfoWithStatus:@"上传图片失败!"];

                
            }];
            
        }
        
    }
    
}

@end
