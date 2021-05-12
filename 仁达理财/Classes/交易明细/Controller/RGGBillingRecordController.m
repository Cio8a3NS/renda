//
//  RGGTransactionDetailsController.m
//  仁达理财
//
//  Created by yuanmc on 16/7/25.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGBillingRecordController.h"
#import "RGGBillingRecordCell.h"
#import "RGGzhangdanjiluModel.h"
static NSString *const billingCellID = @"billingCell";
@interface RGGBillingRecordController ()
@property(strong, nonatomic)UITableView *billingRecordTableView;
@property(strong, nonatomic)NSArray *zhangdanjiluModelArray;
@end

@implementation RGGBillingRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}

//设置导航条
- (void)setupNavBar{

    self.title =  @"账单记录";
    [self.view addSubview:self.billingRecordTableView];
   
    self.billingRecordTableView.backgroundColor = GLOBALCOLOR(247, 249, 250);
    [self.billingRecordTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGGBillingRecordCell class]) bundle:nil]  forCellReuseIdentifier:billingCellID];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestzhangdandata];


}

- (void)requestzhangdandata{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_myaccountlist";
        parameters[@"sign"] = [FactoryTool rendeCode];
        parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            _zhangdanjiluModelArray = [RGGzhangdanjiluModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.billingRecordTableView reloadData];
            }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"获取数据失败!"];
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
    
    return _zhangdanjiluModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGGBillingRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:billingCellID];
   
    RGGzhangdanjiluModel *zhangdanjiluModel = _zhangdanjiluModelArray[indexPath.section];
    cell.zhangdanjiluModel = zhangdanjiluModel;
    
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
