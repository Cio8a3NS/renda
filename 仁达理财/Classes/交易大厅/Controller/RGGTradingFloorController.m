//
//  RGGTradingFloorController.m
//  仁达理财
//
//  Created by yuanmc on 16/7/25.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGTradingFloorController.h"
#import "RGGTradingModel.h"
#import "RGGTradingCell.h"

@interface RGGTradingFloorController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tradingCenterTableView;

@property(nonatomic, strong)NSArray *tradingArray;
@property(nonatomic, strong)NSArray *tradSecArray;
@property(nonatomic, strong)NSArray *tradingModelArray;
@property(nonatomic, strong)NSArray *productArray;
@end

@implementation RGGTradingFloorController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requetData];

}
- (void)requetData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"user_dats";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            _productArray = json[@"data"];
            [self.tradingCenterTableView reloadData];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
        }
        //
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"请求数据失败"];
        NSLog(@"error%@",error);
    }];

}
//设置导航条
- (void)setUI{
    
    self.navigationItem.title = @"理财中心";
    self.tradingArray = @[
                          
                          @{@"numtitle":@"100起投 随时可退（新手理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"1",@"ratio":@"6%",@"newpersontag":@"1"},
                          
                          @{@"numtitle":@"100起投 随时可退（新手理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"1",@"ratio":@"8%",@"newpersontag":@"1"},
                          
                          @{@"numtitle":@"100起投 随时可退（新手理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"12%",@"newpersontag":@"0"},
                          @{@"numtitle":@"100起投 随时可退（休闲理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"15%",@"newpersontag":@"0"},
                          @{@"numtitle":@"100起投 随时可退（休闲理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"18%",@"newpersontag":@"0"},
                          @{@"numtitle":@"100起投 随时可退（白领理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"22%",@"newpersontag":@"0"},
                          @{@"numtitle":@"100起投 随时可退（白领理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"27%",@"newpersontag":@"0"},
                          @{@"numtitle":@"100起投 随时可退（自由理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"30%",@"newpersontag":@"0"},
                          @{@"numtitle":@"100起投 随时可退（自由理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"35%",@"newpersontag":@"0"},
                          @{@"numtitle":@"100起投 随时可退（自由理财）",@"contentArray":@[@{@"num":@"100元起投"},@{@"num":@"次日起息，周期收益到账保障"},@{@"num":@"随时加入，次日后随时退出"},@{@"num":@"本息保障机制"}],@"buytag":@"0",@"ratio":@"45%",@"newpersontag":@"0"},
                          
                          ];
    
    
    self.tradSecArray = @[
                          @{@"secTitle":@"u计划-A(3天)"},
                          @{@"secTitle":@"u计划-B(6天)"},
                          @{@"secTitle":@"u计划-C(10天)"},
                          @{@"secTitle":@"u计划-A(11天)"},
                          @{@"secTitle":@"u计划-C(14天)"},
                          @{@"secTitle":@"u计划-C(15天)"},
                          @{@"secTitle":@"u计划-D(20天)"},
                          @{@"secTitle":@"u计划-D(24天)"},
                          @{@"secTitle":@"u计划-D(30天)"},
                          @{@"secTitle":@"u计划-D(18天)"}];
    _tradingModelArray = [RGGTradingModel mj_objectArrayWithKeyValuesArray:self.tradingArray];
    
    [self.view addSubview:self.tradingCenterTableView];
}


- (UITableView *)tradingCenterTableView{
    
    if (_tradingCenterTableView == nil) {
        _tradingCenterTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tradingCenterTableView.delegate = self;
        _tradingCenterTableView.dataSource = self;
        _tradingCenterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tradingCenterTableView.backgroundColor = GLOBALCOLOR(247, 249, 250);
    }
    return _tradingCenterTableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.tradSecArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RGGTradingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tradingCell"];
    if (cell == nil) {
        cell = [[RGGTradingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tradingCell"];
    }
    cell.tradingModel = _tradingModelArray[indexPath.section];
    
    cell.productDic = _productArray[indexPath.section];
//    cell.rowDic = _tradingModelArray[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RGGTradingModel *tradingModel = _tradingModelArray[indexPath.section];
    NSLog(@"%lu",(unsigned long)tradingModel.contentArray.count);
    return 80+ 40 *tradingModel.contentArray.count;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = self.tradSecArray[section];
    return dic[@"secTitle"];
}
@end
