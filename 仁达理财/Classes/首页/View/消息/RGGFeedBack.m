//
//  RGGFeedBack.m
//  仁达理财
//
//  Created by yuanmc on 16/8/17.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGFeedBack.h"
#import "DzyImgPicker.h"


#define margin 20
#define textW 50

@interface RGGFeedBack()<DzyImgDelegate>

@property(nonatomic ,copy)UILabel *titleLable;
@property(nonatomic ,copy)UILabel *contentLable;
@property(nonatomic ,copy)UILabel *imageLable;

@property(nonatomic ,copy)UITextField *titleTextFied;
@property(nonatomic ,copy)UITextView *contentTextView;
@property(nonatomic ,copy)UIButton *submitBtn;
@property(nonatomic ,copy)NSArray *imgeArray;
@property(nonatomic ,copy) DzyImgPicker *DzyView;
@end
@implementation RGGFeedBack
- (void)layoutSubviews{
  [super layoutSubviews];
    [self addSubview:self.titleLable];
    [self addSubview:self.contentLable];
    [self addSubview:self.imageLable];
    [self addSubview:self.titleTextFied];
    [self addSubview:self.contentTextView];
    [self addSubview:self.submitBtn];
    
    
    _DzyView = [[DzyImgPicker alloc] initWithFrame:CGRectMake(margin+textW, 180, screenWidth-(2*margin+textW), 150) andParentV:[self viewController] andMaxNum:6];
    _DzyView.dzyImgDelegate = self;
    //        _DzyView.backgroundColor = [UIColor orangeColor];
    //    __weak typeof(self)weakSelf = self;
    [_DzyView setDzyImgs:^(NSArray *data) {
        //此处返回的是选择图片的数组
    }];
    
    [self addSubview:_DzyView];
    
    
    [self loadConstraint];

}
#pragma mark -  加载约束
- (void)loadConstraint{
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(margin);
        make.size.mas_equalTo(CGSizeMake(textW,30));
    }];
    [_titleTextFied mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLable.mas_right);
        make.trailing.mas_equalTo(-margin);
        make.height.mas_equalTo (textW);
        //        make.size.mas_equalTo(CGSizeMake(screenWidth-2*margin,40));
        make.centerY.mas_equalTo(_titleLable.mas_centerY);
    }];
    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLable);
        make.top.mas_equalTo(_titleLable).offset(textW);
        make.size.mas_equalTo(_titleLable);
    }];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLable);
        make.left.trailing.mas_equalTo(_titleTextFied);
        make.height.mas_equalTo (100);
    }];
    [_imageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLable);
        make.size.mas_equalTo(CGSizeMake(50,30));
        make.top.mas_equalTo(_contentLable).offset(100);
    }];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLable);
        make.size.mas_equalTo(CGSizeMake(screenWidth - 2*margin,50));
        make.top.mas_equalTo(_imageLable.mas_bottom).offset(160);
    }];
    
}

#pragma mark - 懒加载

- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.text = @"标题 : ";
        
    }
    return _titleLable;
}

- (UILabel *)contentLable{
    if (_contentLable == nil) {
        _contentLable = [[UILabel alloc]init];
        _contentLable.text = @"内容 : ";
    }
    return _contentLable;
}
- (UILabel *)imageLable{
    if (_imageLable == nil) {
        _imageLable = [[UILabel alloc]init];
        _imageLable.text = @"图片 : ";
    }
    return _imageLable;
}

- (UITextField *)titleTextFied{
    if (_titleTextFied == nil) {
        _titleTextFied = [[UITextField alloc]init];
        _titleTextFied.layer.borderWidth = 1;
        _titleTextFied.layer.cornerRadius = 5;
        _titleTextFied.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
    }
    return _titleTextFied;
}

- (UITextView *)contentTextView{
    if (_contentTextView == nil) {
        _contentTextView = [[UITextView alloc]init];
        _contentTextView.layer.borderWidth = 1;
        _contentTextView.layer.cornerRadius = 5;
        _contentTextView.layer.borderColor = GLOBALCOLOR(236, 237, 239).CGColor;
    }
    return _contentTextView;
}

- (UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = mycolor;
        [[_submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSString *imgStr = @"";
            for (int i = 0; i<_imgeArray.count; i++) {
                
                imgStr = [imgStr stringByAppendingString:[[_imgeArray[i][@"data"] objectForKey:@"imgurl"] stringByAppendingString:@","]];
            }
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            [SVProgressHUD showWithStatus:@"正在提交反馈..."];
           parameters[@"type"] = @"feedback_add";
            parameters[@"sign"] = [FactoryTool rendeCode];
            parameters[@"qtime"] = qtime;
            parameters[@"title"] = _titleLable.text;
            parameters[@"equipment"] = [FactoryTool myuuid];
            parameters[@"content"] = _contentLable.text;
            parameters[@"imgs"] = imgStr;
            //    NSDictionary *payload = @{@"tel" : @"18628009366"};
            NSLog(@"%@",parameters);
            [HttpTool post:BaseURL params:parameters success:^(id json) {
                NSLog(@"%@",json);
                [SVProgressHUD dismiss];
                if ([json[@"status"]integerValue] == 1) {
                    [SVProgressHUD showInfoWithStatus:@"提交成功!"];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:json[@"msg"]];
                    
                }
                //
            } failure:^(NSError *error) {
                 [SVProgressHUD dismiss];
                [SVProgressHUD showInfoWithStatus:@"提交失败!"];
                NSLog(@"error%@",error);
            }];

            
        }];
    }
    return _submitBtn;
}

//- (DzyImgPicker *)DzyView{
////    if (_DzyView == nil) {
//        _DzyView = [[DzyImgPicker alloc] initWithFrame:CGRectMake(margin+textW, 180, screenWidth-(2*margin+textW), 200) andParentV:self andMaxNum:6];
//        _DzyView.dzyImgDelegate = self;
//        //        _DzyView.backgroundColor = [UIColor orangeColor];
//        //    __weak typeof(self)weakSelf = self;
//        [_DzyView setDzyImgs:^(NSArray *data) {
//            //此处返回的是选择图片的数组
//        }];
////    }
//    return _DzyView;
//
//}




#pragma - DzyImgDelegate
- (void)getImages:(NSArray *)imgData{
    //此处返回的是选择图片的数组
    if (imgData.count <= 0) {
        return;
    }
    
    [HttpTool requestWithUrl:@"http://czhsj.com/Public/uploads.html" withPostedImages:imgData WithSuccessBlock:^(NSArray *resultArray) {
        _imgeArray = resultArray;
    } WithNeebHub:YES WithView:self WithData:@{@"equipment":[FactoryTool myuuid]}];
    
    
   
    //顺道提一嘴  图片上传的   因为一般到这都是为了上传图片所以我顺道给下实现代码  没有导入AF 所以就用注释的形式实现下
    //写一个数组存储 图片转化成2进制后的数据  _imageDataArray
    
//     _imageDataArray = [NSMutableArray array];//存储二进制
//     if (imageArray.count>0) {
//     for (int i=0; i<imageArray.count; i++) {
//     UIImage *image = imageArray[i];
//     imageData = UIImagePNGRepresentation(image);
//     NSString * newImageName = [NSString stringWithFormat:@"%@%zi%@", @"Send_image_Name", i, @".jpg"];
//     NSString  *jpgPath = NSHomeDirectory();
//     jpgPath = [jpgPath stringByAppendingPathComponent:@"Documents"];
//     jpgPath = [jpgPath stringByAppendingPathComponent:newImageName];
//     [_imageDataArray writeToFile:jpgPath atomically:YES];
//     NSLog(@"%@",jpgPath);
//     [_imageDataArray addObject:imageData];
//     }
    
     //上传的话用的是  AF3.0   的这个函数
//     - (NSURLSessionDataTask *)POST:(NSString *)URLString
//     parameters:(id)parameters
//     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
//     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
//    {
     //多张图片上传  简历一个  网络请求类  然后我这里写的是 直接用
//     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//     
//     [manager POST:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//     // 上传 多张图片
//     for(NSInteger i = 0; i < _imageDataArray.count; i++)
//     {
//     NSData * imageData = [_imageDataArray objectAtIndex: i];
//     // 上传的参数名
//     NSString * Name = [NSString stringWithFormat:@"%@%zi", @"Send_image_Name", i+1];
//     // 上传filename
//     NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
//     NSLog(@"%@",fileName);
//     
//     //  ********** 此处需要注意的是需要传输的数据名称是要和后台的名称一样  Name   fileName
//     
//     [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpeg"];
//     
//     }
//     } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//     
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//     
//     }];
    
     
    
    
}
@end
