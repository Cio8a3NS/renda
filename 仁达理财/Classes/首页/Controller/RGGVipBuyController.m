//
//  RGGVipBuyController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/19.
//  Copyright © 2016年 六点科技. All rights reserved.
//



#import "RGGVipBuyController.h"
#import "RGGVipBuyCell.h"
#import "RGGVipBuyViewModel.h"

static NSString *const VipCellID = @"VipCell";
@interface RGGVipBuyController ()<UIAlertViewDelegate>
@property(strong, nonatomic)UITableView *vipTableView;
@property(strong, nonatomic)RGGVipBuyViewModel *vipBuyModel;
@property(strong, nonatomic)NSArray *vipBuyArray;
@property(assign, nonatomic) CGFloat money;

@end

@implementation RGGVipBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"VIP购买";
    
    [self.view addSubview:self.vipTableView];
    self.vipTableView.backgroundColor = GLOBALCOLOR(247, 249, 250);
    [self.vipTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RGGVipBuyCell class]) bundle:nil]  forCellReuseIdentifier:VipCellID];
    [self requestNewInfo];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshSecHeader) name:@"refreshSecHeader" object:nil];
    
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self wodeyue];

}

- (void)refreshSecHeader{
    [self wodeyue];
    
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
           NSString  *moneystring  = json[@"data"][@"money"];
            _money = moneystring.floatValue;
            [self.vipTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            
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

#pragma mark - getter and setter
- (RGGVipBuyViewModel *)vipBuyModel{
    if (_vipBuyModel == nil) {
    _vipBuyModel = [[RGGVipBuyViewModel alloc]init];
    }
    return _vipBuyModel;
}


- (void)requestNewInfo{
    
    @weakify(self);
    [self.vipBuyModel getVipBuyInfo:^(id json) {
        @strongify(self)
        NSLog(@"%@",json);
        _vipBuyArray = json;
        
        [self.vipTableView reloadData];
    }];
    
}

#pragma mark -
- (UITableView *)vipTableView{
    if (!_vipTableView) {
        _vipTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
        _vipTableView.delegate = self;
        _vipTableView.dataSource = self;
        _vipTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _vipTableView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _vipBuyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGGVipBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:VipCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_vipBuyArray.count!=0) {
        cell.vipBuyModel = _vipBuyArray[indexPath.section];
        cell.yuemoney = _money;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    if (section == 0) {
//        headView.backgroundColor = [UIColor redColor];
//        headView.backgroundColor = [UIColor clearColor];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 130, 30)];
        lable.text = @"账户余额为 ";
        UILabel *balanceLable = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 100, 30)];
        balanceLable.text = [NSString stringWithFormat:@"￥%.2lf",_money];
        balanceLable.adjustsFontSizeToFitWidth = YES;
        balanceLable.textColor = [UIColor redColor];
        balanceLable.textAlignment = NSTextAlignmentLeft;
        balanceLable.center = headView.center;
        
        UIButton *rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth - 100, 10, 80, 30)];
        [rechargeBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
        rechargeBtn.layer.cornerRadius = 10;
        [rechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.]];
        [rechargeBtn setTintColor:GLOBALCOLOR(52, 129, 228)];
        [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [rechargeBtn setTitleColor:GLOBALCOLOR(52, 129, 228) forState:UIControlStateNormal];
        rechargeBtn.layer.borderWidth = 2;
        rechargeBtn.layer.borderColor = GLOBALCOLOR(52, 129, 228).CGColor;
        [[rechargeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"请输入充值金额" message:nil delegate:self cancelButtonTitle:@"放弃充值" otherButtonTitles:@"立即充值",nil];
            [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
           
            [dialog show];
            
        }];
//        rechargeBtn.center = headView.center;
        [headView addSubview:rechargeBtn];
        [headView addSubview:balanceLable];
        [headView addSubview:lable];
    }
    return headView;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *txt = [alertView textFieldAtIndex:0];
    if (txt.text.length ==0) {
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"sign"] = [FactoryTool rendeCode];
//    parameters[@"qtime"] = qtime;
    parameters[@"money"] = txt.text;
    parameters[@"equipment"] = [FactoryTool myuuid];
    //    NSDictionary *payload = @{@"tel" : @"18628009366"};
    NSLog(@"%@",parameters);
    [HttpTool post:@"http://czhsj.com/Public/chongzhizhifuapi.html" params:parameters success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"status"]integerValue] == 1) {
          RootWebViewController *webVC = [[RootWebViewController alloc]init];
            webVC.url = json[@"data"][@"url"];
            [self.navigationController pushViewController:webVC animated:YES
             ];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"充值失败!"];
        NSLog(@"error%@",error);
    }];
    
}
- (void)recharge{
    NSLog(@"324234");
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
