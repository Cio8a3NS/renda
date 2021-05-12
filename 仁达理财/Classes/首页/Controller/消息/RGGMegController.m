//
//  RGGMegController.m
//  仁达理财
//
//  Created by yuanmc on 16/7/27.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGMegController.h"

#import "RGGSigmentScrollView.h"
#import "RGGFeedBack.h"
#import "RGGGuanFangTongGaoViewCell.h"
#import "RGGGuanFangGongGaoModel.h"
#import "RGGGuanFangTongGaoContentController.h"
@interface RGGMegController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) RGGSigmentScrollView * SingmentScrollView;
@property (nonatomic, strong) NSArray *guanFangGongGaoModelModelArray;
@property (nonatomic, strong)UITableView *tbale;

@end

@implementation RGGMegController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setUI];
    
}

- (void)setupNavBar{
    self.title = @"消息";
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestData];
    
}

- (void)setUI{
   
    self.view.backgroundColor=[UIColor whiteColor];
    //iOS7新增属性
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSMutableArray *array=[NSMutableArray array];
    _tbale=[[UITableView alloc] init];
    _tbale.delegate=self;
    _tbale.dataSource=self;
    _tbale.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbale.rowHeight=150;
    [array addObject:_tbale];
    RGGFeedBack *view=[[RGGFeedBack alloc] init];
    
    view.backgroundColor=[UIColor whiteColor];
    [array addObject:view];
    
    
    
    RGGSigmentScrollView *scView=[[RGGSigmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) titleArray:@[@"官方通告",@"反馈"] contentViewArray:array];
    [self.view addSubview:scView];
}

- (void)requestData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"feedback_notice";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
     parameters[@"page"] = @(1);
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
          _guanFangGongGaoModelModelArray = [RGGGuanFangGongGaoModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"data"]];
            [self.tbale reloadData];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _guanFangGongGaoModelModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"guancell";
    RGGGuanFangTongGaoViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[RGGGuanFangTongGaoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.guanFangGongGaoModel = _guanFangGongGaoModelModelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text=@"dkdk";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RGGGuanFangTongGaoContentController  *tongGaoContentVC = [[RGGGuanFangTongGaoContentController alloc]init];
    tongGaoContentVC.fangGongGaoModel = _guanFangGongGaoModelModelArray[indexPath.row];
    [self.navigationController pushViewController:tongGaoContentVC animated:YES];
}


#pragma mark - 懒加载




@end
