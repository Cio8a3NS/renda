//
//  RGGTransactionDetailsController.m
//  仁达理财
//
//  Created by yuanmc on 16/7/25.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGYongjinController.h"
#import "RGGYongjinCell.h"
#import "RGGYongjinshouyiModel.h"
static NSString *const yongjinshouyiCellID = @"yongjinshouyiCell";
@interface RGGYongjinController ()
@property(strong, nonatomic)UITableView *billingRecordTableView;
@property(strong, nonatomic)NSArray *yongjinshouyiModelArray;
@end

@implementation RGGYongjinController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}

//设置导航条
- (void)setupNavBar{

    self.title = @"佣金收益";
    [self.view addSubview:self.billingRecordTableView];
   
    self.billingRecordTableView.backgroundColor = GLOBALCOLOR(247, 249, 250);
    [self.billingRecordTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGGYongjinCell class]) bundle:nil]  forCellReuseIdentifier:yongjinshouyiCellID];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestData];

}


- (void)requestData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_yongjin";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            
            _yongjinshouyiModelArray = [RGGYongjinshouyiModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.billingRecordTableView reloadData];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
    
    
}
#pragma mark -
- (UITableView *)billingRecordTableView{
    if (!_billingRecordTableView) {
        _billingRecordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
        _billingRecordTableView.delegate = self;
        _billingRecordTableView.dataSource = self;
        _billingRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _billingRecordTableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _yongjinshouyiModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGGYongjinCell *cell = [tableView dequeueReusableCellWithIdentifier:yongjinshouyiCellID];
    cell.yongjinshouyiModel = _yongjinshouyiModelArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    if (section == 0) {
        
       
    }
    return headView;
    
}



@end
