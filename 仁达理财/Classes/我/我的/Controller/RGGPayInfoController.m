//
//  RGGPayInfoController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/18.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGPayInfoController.h"
#import "RGGPayInfoCell.h"
#import "RGGaAddCardController.h"
#import "RGGBankListModel.h"
#import "RGGXiuGaiCardController.h"
@interface RGGPayInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *payTableView;
@property(nonatomic ,strong)NSMutableArray *bankListModelArray;
@end

@implementation RGGPayInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addAccount)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview: self.payTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestBankData];
}

- (void)requestBankData{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"user_bank";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];;
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
          _bankListModelArray = [RGGBankListModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            [self.payTableView reloadData];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];

}

#pragma mark -

- (UITableView *)payTableView{

    if (_payTableView == nil) {
        _payTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
        _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _payTableView.backgroundColor = [UIColor whiteColor];
    }
    return _payTableView;
}


#pragma mark - 添加
- (void)addAccount{
    [self.navigationController pushViewController:[[RGGaAddCardController alloc]init] animated:YES];

}


#pragma mark - table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _bankListModelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"banklistcell";
    RGGPayInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[RGGPayInfoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.bankListModel = _bankListModelArray[indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"测试测发生率大幅减少到了放假了";
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:YES];
    [self.payTableView setEditing:editing animated:YES];

}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RGGBankListModel *bankListModel = _bankListModelArray[indexPath.section];
    
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"type"] = @"user_delbank";
        parameters[@"sign"] = [FactoryTool rendeCode];
        parameters[@"qtime"] = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
        parameters[@"equipment"] = [FactoryTool myuuid];
        parameters[@"id"] = bankListModel.id;
        // NSDictionary *payload = @{@"tel" : @"18628009366"};
        NSLog(@"%@",parameters);
        [HttpTool post:BaseURL params:parameters success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"status"]integerValue] == 1) {
                [self.payTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                [_bankListModelArray removeObject:_bankListModelArray[indexPath.section]];
            }
            else{
                [SVProgressHUD showInfoWithStatus:json[@"msg"]];
                
            }
            //
        } failure:^(NSError *error) {
            NSLog(@"error%@",error);
        }];

    }];//此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        RGGXiuGaiCardController *xiuGaiCardVC = [[RGGXiuGaiCardController alloc]init];
        xiuGaiCardVC.bankListModel = bankListModel;
        [self.navigationController pushViewController:xiuGaiCardVC animated:YES];
       
    }];
    
    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[deleteRoWAction, editRowAction];//最后返回这俩个RowAction 的数组
}

- (void)tableView :(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
