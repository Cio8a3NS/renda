//
//  RGGTransactionManagementController.m
//  仁达理财
//
//  Created by yuanmc on 16/7/25.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGTransactionManagementController.h"
#import "RGGZhangHuTiXianView.h"
#import "RGGYiJinTiXianTableView.h"
#import "RGGSigmentScrollView.h"
#import "RGGyinjitixianModel.h"
@interface RGGTransactionManagementController ()
@property(nonatomic, strong)NSMutableArray *yijitixianModelArray;
@property(nonatomic, strong)RGGYiJinTiXianTableView *yiJinTiXianTableView;
@property(nonatomic, strong)NSMutableArray *guolvyinjitixianArray;
@property(nonatomic, strong)RGGZhangHuTiXianView *zhangHuTiXianView;
@end

@implementation RGGTransactionManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setUI];
    
}

- (void)setupNavBar{
    self.title = @"交易管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestData];
    [self wodeyue];
    
}

- (void)setUI{
    
    self.view.backgroundColor=[UIColor whiteColor];
    //iOS7新增属性
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSMutableArray *array=[NSMutableArray array];
    _zhangHuTiXianView=[[RGGZhangHuTiXianView alloc] init];
    
    _zhangHuTiXianView.backgroundColor=[UIColor whiteColor];
    [array addObject:_zhangHuTiXianView];
    _yiJinTiXianTableView=[[RGGYiJinTiXianTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
//    yiJinTiXianTableView.delegate=self;
//    yiJinTiXianTableView.dataSource=self;
//    yiJinTiXianTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    yiJinTiXianTableView.rowHeight=150;
    
    [array addObject:_yiJinTiXianTableView];
   
    RGGSigmentScrollView *scView=[[RGGSigmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) titleArray:@[@"账户提现",@"应急提现"] contentViewArray:array];
    [self.view addSubview:scView];
}

- (NSMutableArray *)guolvyinjitixianArray{
    if (_guolvyinjitixianArray == nil) {
        _guolvyinjitixianArray = [NSMutableArray array];
    }
    return _guolvyinjitixianArray;
}

- (void)wodeyue{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_myyue";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            _zhangHuTiXianView.zhanghuyue = json[@"data"][@"money"];
            
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
            [self.guolvyinjitixianArray removeAllObjects];
            _yijitixianModelArray = [RGGyinjitixianModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            for (int i=0; i<_yijitixianModelArray.count;i++) {
                RGGyinjitixianModel  *yinjitixianModel = _yijitixianModelArray[i];
                if (yinjitixianModel.status.integerValue == 0) {
                    [self.guolvyinjitixianArray addObject:yinjitixianModel];
                   
                }
                 _yiJinTiXianTableView.yijitixianModelArray = self.guolvyinjitixianArray;
            }
            
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

@end
