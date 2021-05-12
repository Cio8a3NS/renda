//
//  RGGHomeScrollView.m
//  仁达理财
//
//  Created by yuanmc on 16/7/26.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGHomeCollectionView.h"
#import "RGGHomeCollectionViewCell.h"
#import "RGGVipBuyController.h"
#import "RGGMyAssetsController.h"
#import "RGGTradingFloorController.h"
#import "RGGFixedIncomeController.h"
#import "RGGXianJinChongZhiController.h"
#import "RGGTransactionManagementController.h"
#import "RGGMyInfoController.h"
@interface RGGHomeCollectionView()
@property(nonatomic, copy)NSArray *array;
@end
@implementation RGGHomeCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.array = @[@{@"理财管理":@"理财"},@{@"VIP购买":@"vip"},@{@"理财中心":@"理财中心"},@{@"交易管理":@"交易管理"},@{@"我的资产":@"资产-拷贝"},@{@"现金充值":@"现金"},@{@"红包领取":@"红包"},@{@"邀请链接":@"链接"},@{@"个人资料":@"待开发"}];
        
        self.delegate = self;
        self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([RGGHomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    }
    return self;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RGGHomeCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.dic = self.array[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}
//设定指定区内Cell的最小行距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;

}

//设定指定区内Cell的最小间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RGGVipBuyController *vipVc = [[RGGVipBuyController alloc]init];
    RGGMyAssetsController *assetsVc = [[RGGMyAssetsController alloc]init];
    RGGTradingFloorController *tradingFloorVC = [[RGGTradingFloorController alloc]init];
    RGGFixedIncomeController *fixedIncomeVC = [[RGGFixedIncomeController alloc]init];
    RGGXianJinChongZhiController *XianJinChongZhiVC = [[RGGXianJinChongZhiController alloc]init];
    
    RGGTransactionManagementController  *TransactionManagement = [[RGGTransactionManagementController alloc]init];
     RGGMyInfoController *myInfo = [[RGGMyInfoController alloc]init];
//    RGGVipBuyController *vipVc = [[RGGVipBuyController alloc]init];
//    RGGVipBuyController *vipVc = [[RGGVipBuyController alloc]init];
    switch (indexPath.row) {
        case 0:
            [[self viewController].navigationController pushViewController:fixedIncomeVC animated:YES];
            break;
        case 1:
           
            [[self viewController].navigationController pushViewController:vipVc animated:YES];
            
            break;
        case 2:
            [[self viewController].navigationController pushViewController:tradingFloorVC animated:YES];
            break;
        case 3:
             [[self viewController].navigationController pushViewController:TransactionManagement animated:YES];
            
            break;
        case 4:
            [[self viewController].navigationController pushViewController:assetsVc animated:YES];
            break;
        case 5:
//            [[self viewController].navigationController pushViewController:XianJinChongZhiVC animated:YES];
            
            [self chongzhi];
            break;
        case 6:
            [self lingquhongbao];
            
            break;
        case 7:
            [self requestyaoqingLink];
            
            break;
        case 8:
            [[self viewController].navigationController pushViewController:myInfo animated:YES];
            
            break;
        default:
            break;
    }
    
}

- (void)lingquhongbao{
    [SVProgressHUD showWithStatus:@"正在领取红包..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_hongbao";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];
    
    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            [SVProgressHUD showInfoWithStatus:@"领取红包成功!"];
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"领取红包失败!"];
        NSLog(@"error%@",error);
    }];

}

- (void)requestyaoqingLink{
    [SVProgressHUD showWithStatus:@"正在获取邀请链接..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @"jinniubi_yaoqinglink";
    parameters[@"sign"] = [FactoryTool rendeCode];
    parameters[@"qtime"] = qtime;
    parameters[@"equipment"] = [FactoryTool myuuid];

    NSLog(@"%@",parameters);
    [HttpTool post:BaseURL params:parameters success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        if ([json[@"status"]integerValue] == 1) {
            [SVProgressHUD showInfoWithStatus:@"获取邀请链接成功,链接已复制到剪切板!"];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = json[@"data"][@"link"];
            
        }
        else{
            [SVProgressHUD showInfoWithStatus:json[@"msg"]];
            
        }
        //
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"获取邀请链接失败!"];
        NSLog(@"error%@",error);
    }];

}

- (void)chongzhi{
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"请输入充值金额" message:nil delegate:self cancelButtonTitle:@"放弃充值" otherButtonTitles:@"立即充值",nil];
    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    
    [dialog show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        
        [SVProgressHUD show];
        UITextField *txt = [alertView textFieldAtIndex:0];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        //    parameters[@"sign"] = [FactoryTool rendeCode];
        //    parameters[@"qtime"] = qtime;
        parameters[@"money"] = txt.text;
        parameters[@"equipment"] = [FactoryTool myuuid];
        //    NSDictionary *payload = @{@"tel" : @"18628009366"};
        NSLog(@"%@",parameters);
        [HttpTool post:@"http://czhsj.com/Public/chongzhizhifuapi.html" params:parameters success:^(id json) {
            NSLog(@"%@",json);
            [SVProgressHUD dismiss];
            if ([json[@"status"]integerValue] == 1) {
                
                RootWebViewController *webVC = [[RootWebViewController alloc]init];
                webVC.url = json[@"data"][@"url"];
                [self.viewController.navigationController pushViewController:webVC animated:YES
                 ];
            }
            else{
                [SVProgressHUD showInfoWithStatus:json[@"msg"]];
                
            }
            //
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            NSLog(@"error%@",error);
        }];

    }
    
}
@end
