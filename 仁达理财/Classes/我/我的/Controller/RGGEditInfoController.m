//
//  RGGEditInfoController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/18.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGEditInfoController.h"

@interface RGGEditInfoController ()
@property(nonatomic, copy)NSArray *nameArray;

@property(nonatomic, copy)NSMutableArray *textfiledArray;
@property (strong,nonatomic)UIView *footerView;
@end

@implementation RGGEditInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.title = @"修改个人资料";
    self.tableView.scrollEnabled = NO;
    
    _textfiledArray = [NSMutableArray array];
    
//    UserInfo *userinfo = [UserInfo sharedManager];
    _nameArray = @[@"联系方式 :  ",@"注册时间 :  ",@"推荐人 :  ",@"微信 :  ",@"邮箱 :  "];
    _dataArray = self.dataArray;
    
    //table
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    

    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
//    self.tableView.tableFooterView = [[UIView alloc]init];
     self.tableView.tableFooterView = self.footerView;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shousuojianpan)];
    [self.view addGestureRecognizer:tapGes];
    
    [self.tableView setSeparatorColor:GLOBALCOLOR(247, 249, 250)];
    
}
- (UIView *)footerView{
    
    if (!_footerView) {
        
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, screenWidth - 2*30, 50)];
        
        [btn setBackgroundColor:mycolor];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [_footerView addSubview:btn];
        //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            UITextField *weixinFiled = _textfiledArray[1];
            UITextField *emailFiled = _textfiledArray[2];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"type"] = @"user_updateinfo";
            parameters[@"sign"] = [FactoryTool rendeCode];
            parameters[@"qtime"] = qtime;
            parameters[@"equipment"] = [FactoryTool myuuid];
            parameters[@"email"] = emailFiled.text;
            parameters[@"weixin"] = weixinFiled.text;;
            NSLog(@"%@",parameters);
            [HttpTool post:BaseURL params:parameters success:^(id json) {
                NSLog(@"%@",json);
                if ([json[@"status"]integerValue] == 1) {
                    [SVProgressHUD showInfoWithStatus:@"修改资料成功!"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:json[@"msg"]];
                    
                }
                //
            } failure:^(NSError *error) {
                [SVProgressHUD showInfoWithStatus:@"修改资料失败"];
            }];
            
        }];

        
    }
    return _footerView;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
         NSLog(@"%f",scrollView.contentOffset.y);
    
         CGFloat sectionHeaderHeight = 20;
    
         if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
                 scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
             }
    
         else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
                 scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
         
             }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    NSLog(@"textFieldDidBeginEditing");
    CGRect frame = textField.frame;
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y +220 + 21 - (SCREEN_HEIGHT - 216.0-35.0);//键盘高度216
    
    [UIView animateWithDuration:0.3 animations:^{
        if(offset > 0)
            
        {
            CGRect rect = CGRectMake(0.0f, -offset,SCREEN_WIDTH,SCREEN_HEIGHT);
            self.tableView.frame = rect;
        }
    }];
    
}


- (void)shousuojianpan{
        NSLog(@"touchesBegan");
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,SCREEN_HEIGHT);
    
            self.tableView.frame = rect;
            
        }];

}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//
//{
//    
//    
//    NSLog(@"touchesBegan");
//    [self.view endEditing:YES];
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,SCREEN_HEIGHT);
//        
//        self.view.frame = rect;
//        
//    }];
//    
//}
#pragma mark - 点击return收缩键盘并且使view向下移
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,SCREEN_HEIGHT);
        
        self.tableView.frame = rect;
        
    }];
    return YES;
}


#pragma mark - table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//
//
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    //    cell.separatorInset = UIEdgeInsetsZero;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 80, 30)];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [nameLabel setText:_nameArray[indexPath.row]];
    nameLabel.font = [UIFont systemFontOfSize:17];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:nameLabel];
    
    if (indexPath.row == 1 || indexPath.row == 2) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(155, 15, 100, 30)];
        
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [label setText:_dataArray[indexPath.row]];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
    }
    
    else if (indexPath.row == 0|| indexPath.row == 3 || indexPath.row == 4){
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(155, 15, 180, 30)];
        if (indexPath.row == 0) {
//            [textField becomeFirstResponder];
            textField.enabled = NO;
            textField.textColor = [UIColor grayColor];
        }
        
        [textField setText:_dataArray[indexPath.row]];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = [UIColor blackColor];
        textField.textAlignment = NSTextAlignmentLeft;
        textField.backgroundColor = [UIColor clearColor];
        [_textfiledArray addObject:textField];
        
        [cell.contentView addSubview:textField];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
    
}




//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 50, screenWidth - 2*30, 50)];
//    
//    [btn setBackgroundColor:mycolor];
//    [btn setTitle:@"提交" forState:UIControlStateNormal];
//    
////    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        UITextField *weixinFiled = _textfiledArray[1];
//        UITextField *emailFiled = _textfiledArray[2];
//        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//        parameters[@"type"] = @"user_updateinfo";
//        parameters[@"sign"] = [FactoryTool rendeCode];
//        parameters[@"qtime"] = qtime;
//        parameters[@"equipment"] = [FactoryTool myuuid];
//        parameters[@"email"] = emailFiled.text;
//        parameters[@"weixin"] = weixinFiled.text;;
//        NSLog(@"%@",parameters);
//        [HttpTool post:BaseURL params:parameters success:^(id json) {
//            NSLog(@"%@",json);
//            if ([json[@"status"]integerValue] == 1) {
//                [SVProgressHUD showInfoWithStatus:@"修改资料成功!"];
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//            else{
//                [SVProgressHUD showInfoWithStatus:json[@"msg"]];
//                
//            }
//            //
//        } failure:^(NSError *error) {
//            [SVProgressHUD showInfoWithStatus:@"修改资料失败"];
//        }];
//     
//    }];
//    
////    [view addSubview:btn];
//    return (UIView *)btn;
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


@end
