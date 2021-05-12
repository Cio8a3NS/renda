//
//  RGGFixedIncomeController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/23.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGFixedIncomeController.h"
#import "RGGFixedCell.h"
#import "RGGFixIncomeModel.h"
static NSString *const fixedshouyiCellID = @"fixedshouyiCellID";
@interface RGGFixedIncomeController ()
@property(nonatomic, strong)UITableView *fixedTable;
@property(nonatomic, strong)NSArray *incomeModelArray;
@end

@implementation RGGFixedIncomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"固定收益";
    [self.view addSubview:self.fixedTable];
    self.fixedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestData];

}

- (void)requestData{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_myproductlists";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    parameters[@"page"] = @(1);
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            _incomeModelArray = [RGGFixIncomeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.fixedTable reloadData];
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
- (UITableView *)fixedTable{
    if (_fixedTable == nil) {
        _fixedTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, screenHeight) style:UITableViewStyleGrouped];
        _fixedTable.delegate = self;
        _fixedTable.dataSource = self;
        _fixedTable.backgroundColor = BackgroundColor;
    }
    return _fixedTable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _incomeModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGGFixedCell *cell = [tableView dequeueReusableCellWithIdentifier:fixedshouyiCellID];
    if (!cell) {
        
        cell = [[RGGFixedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fixedshouyiCellID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_incomeModelArray.count != 0) {
        
        RGGFixIncomeModel *fixIncomeModel = _incomeModelArray[indexPath.section];
        cell.fixIncomeModel = fixIncomeModel;
    }
    
//    if (_vipBuyArray.count!=0) {
//        cell.vipBuyModel = _vipBuyArray[indexPath.section];
//    }
    
    return cell;
//    RGGFixedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tradingCell"];
//    if (cell == nil) {
//        cell = [[RGGFixedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tradingCell"];
//    }
//    cell.tradingModel = _tradingModelArray[indexPath.section];
//    //    cell.rowDic = _tradingModelArray[indexPath.section][indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 190;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

@end
