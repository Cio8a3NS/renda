//
//  RGGYiJinTiXianTableView.m
//  仁达理财
//
//  Created by wangdong on 16/8/26.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGYiJinTiXianTableView.h"

#import "RGGyinjitixianModel.h"
#import "RGGyinjitixianCell.h"
static NSString *const yinjitixianCellID = @"yinjitixianCellID";
@implementation RGGYiJinTiXianTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([RGGyinjitixianCell class]) bundle:nil]  forCellReuseIdentifier:yinjitixianCellID];
        self.backgroundColor = BackgroundColor;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshYinjiTixianCell:) name:@"refreshYinjiTixianCell" object:nil];
        _yijitixianModelArray = [NSMutableArray array];
    }
    return self;
}

- (void)refreshYinjiTixianCell:(NSNotification*) notification

{
    NSString *strid = [notification object];//通过这个获取到传递的对象
    for (int i=0; i<_yijitixianModelArray.count; i++) {
       RGGyinjitixianModel *yinjitixianModel = _yijitixianModelArray[i];
        if ([yinjitixianModel.id isEqual:strid]) {
            [_yijitixianModelArray removeObject:yinjitixianModel];
           
        }
    }
     [self reloadData];
}
- (void)setYijitixianModelArray:(NSMutableArray *)yijitixianModelArray{
    _yijitixianModelArray = yijitixianModelArray;
    [self reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _yijitixianModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGGyinjitixianCell *cell = [tableView dequeueReusableCellWithIdentifier:yinjitixianCellID];
    RGGyinjitixianModel *yinjitixianModel = _yijitixianModelArray[indexPath.section];
    
    cell.yinjitixianModel = yinjitixianModel;

//    [cell.tikuanBtn setTitle:yinjitixianModel.status.integerValue==0?@"提现":yinjitixianModel.status.integerValue==1?@"已发放收益":@"已提现"forState:UIControlStateNormal];
//    if (yinjitixianModel.status.integerValue) {
//        cell.tikuanBtn.enabled = NO;
//    }
//    else{
//         cell.tikuanBtn.enabled = YES;
//    
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (_incomeModelArray.count != 0) {
//        
//        RGGFixIncomeModel *fixIncomeModel = _incomeModelArray[indexPath.section];
//        cell.fixIncomeModel = fixIncomeModel;
//    }
//    
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
    
    return 130;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (void)dealloc{
 [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"refreshYinjiTixianCell" object:nil];
}
@end
