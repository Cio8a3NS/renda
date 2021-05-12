//
//  RGGMyInfoController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/17.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGMyInfoController.h"
#import "RGGEditInfoController.h"
@interface RGGMyInfoController ()
@property(nonatomic, copy)NSArray *nameArray;
@property(nonatomic, copy)NSArray *dataArray;
@end

@implementation RGGMyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestData];

}

- (void)requestData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"user_info";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
 
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            NSDictionary *dataDic = json[@"data"];
           NSString *timestring = [dataDic objectForKey:@"create_time"];
            _dataArray = @[[dataDic objectForKey:@"phone"],[NSString timeToDate:timestring.floatValue],[dataDic objectForKey:@"parent_user"],[dataDic objectForKey:@"wechat"],[dataDic objectForKey:@"email"]];
            [self.tableView reloadData];
            }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];

}


- (void)setUI{
    self.title = @"个人资料";
    self.tableView.scrollEnabled = NO;
//    UserInfo *userinfo = [UserInfo sharedManager];
    _nameArray = @[@"联系方式 :  ",@"注册时间 :  ",@"推荐人 :  ",@"微信 :  ",@"邮箱 :  "];
//    _dataArray = @[userinfo.phone ,[NSString timeToDate:userinfo.create_time.floatValue]  ,[userinfo.parent_user objectForKey:@"nickname"],[userinfo.parent_user objectForKey:@"wechat"],[userinfo.parent_user objectForKey:@"email"]];
    
    //table
     [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView setSeparatorColor:GLOBALCOLOR(247, 249, 250)];
    
    //nav
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
}

- (void)edit{
    RGGEditInfoController *EditInfoController =  [[RGGEditInfoController alloc]init];
    EditInfoController.dataArray = _dataArray;
    [self.navigationController pushViewController:EditInfoController animated:YES];

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
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 15, 200, 30)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  
    [label setText:_dataArray[indexPath.row]];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;

}


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
