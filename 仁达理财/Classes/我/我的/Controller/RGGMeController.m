//
//  RGGMeController.m
//  仁达理财
//
//  Created by yuanmc on 16/7/25.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGMeController.h"
#import "RGGMeHeaderView.h"
#import "RGGMeTabelView.h"
#import "RGGMyInfoController.h"
#import "RGGLoginCodeController.h"
#import "RGGPayInfoController.h"
#import "RGGAssetsModel.h"
#import "RGGMeHeaderView.h"
#import "LoginViewController.h"
#import "RGGNavigationController.h"
@interface RGGMeController ()<jumpWebDelegate>
@property(nonatomic ,strong)RGGMeTabelView  *myTableView;
@property(nonatomic ,strong)RGGAssetsModel *assetsModel;
@end

@implementation RGGMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestMeData];
    

}

- (void)requestMeData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_mymoney";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMeHeader"object:[RGGAssetsModel mj_objectWithKeyValues:json[@"data"]]];
//            refreshMeHeader
//            RGGMeHeaderView *meHeaderView = [[RGGMeHeaderView alloc]init];
//            meHeaderView.assetsModel =  [RGGAssetsModel mj_objectWithKeyValues:json[@"data"]];
           
        }
        else{
           [SVProgressHUD showInfoWithStatus:json[@"msg"]];
        }
        //
    } failure:^(NSError *error) {
        NSLog(@"error%@",error);
    }];



}

//设置导航条
- (void)setupNavBar{
    self.navigationItem.title = @"我";
}
-(void)setUI{
    [self.view addSubview:self.myTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
}

- (void)exit{
    [[UIApplication sharedApplication].delegate window].rootViewController = [[RGGNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];

}

- (RGGMeTabelView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[RGGMeTabelView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _myTableView.jumpDelegate = self;
        //        _tabelView.tableHeaderView.backgroundColor = GLOBALCOLOR(239, 75, 41, 1);
        _myTableView.meArray = @[@[@{@"支付密码":@"支付密码"},@{@"支付信息":@"支付"},@{@"登录密码":@"密码登录"}],@[@{@"个人资料":@"我-(1)"}]];
    }
    return _myTableView;
}


#pragma mark - JumpDelegate
- (void)jumpWeb:(NSIndexPath *)indexPath{
    

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RGGLoginCodeController *lognCodeVc = [[RGGLoginCodeController alloc]init];
            lognCodeVc.title = @"支付密码修改";
            [self.navigationController pushViewController:lognCodeVc animated:YES];
        }
        else if (indexPath.row == 1){
            RGGPayInfoController *infoVC = [[RGGPayInfoController alloc]init];
            [self.navigationController pushViewController:infoVC animated:YES];
            
        }else if (indexPath.row == 2){
        RGGLoginCodeController *lognCodeVc = [[RGGLoginCodeController alloc]init];
        lognCodeVc.title = @"登录密码修改";
        [self.navigationController pushViewController:lognCodeVc animated:YES];
            
        }
        
    } else {
        RGGMyInfoController *infoVc = [[RGGMyInfoController alloc]init];
        [self.navigationController pushViewController:infoVc animated:YES];
        }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshMeHeader" object:nil];
    
}

@end
