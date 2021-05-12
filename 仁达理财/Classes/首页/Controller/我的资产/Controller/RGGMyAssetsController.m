//
//  RGGMyAssetsController.m
//  仁达理财
//
//  Created by wangdong on 16/8/21.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGMyAssetsController.h"
#import "LDProgressView.h"

#import "RGGMyAssetsViewModel.h"
#import "RGGAssetsModel.h"
#import "RGGFixedIncomeCell.h"
#import "RGGTYongjinIcomeCell.h"
#import "RGGFixedIncomeController.h"
#import "RGGYongjinController.h"
@interface RGGMyAssetsController ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, strong) NSMutableArray *progressViews;
@property (nonatomic, strong) RGGMyAssetsViewModel *assetsViewModel;
@property (nonatomic, strong) UITableView *myAssetTable;

@property(nonatomic, strong)RGGAssetsModel *assetsModel;
@end

@implementation RGGMyAssetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的资产";
    self.myAssetTable.backgroundColor = BackgroundColor;
    [self setUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self requestData];
}

- (void)setUI{
    [super viewDidLoad];
    [self.view addSubview:self.myAssetTable];
//    self.progressViews = [NSMutableArray array];
//    
//    // default color, animated
//    LDProgressView *progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 130, self.view.frame.size.width-40, 22)];
//    progressView.progress = 0.40;
//    progressView.color = GLOBALCOLOR(98, 165, 250);
//    progressView.background = [progressView.color colorWithAlphaComponent:0.4   ];
//    progressView.showBackgroundInnerShadow = @NO;
//    
//    progressView.showText = @NO;
//    progressView.showStroke = @NO;
//   
////    progressView.showBackground = @NO;
//    progressView.type = LDProgressSolid;
//    progressView.animate = @NO;
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];
    
    
    
   
    
    
//    // flat, green, animated
//    progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 160, self.view.frame.size.width-40, 22)];
//    progressView.color = [UIColor colorWithRed:0.00f green:0.64f blue:0.00f alpha:1.00f];
//    progressView.flat = @YES;
//    progressView.borderRadius = @4;
//    progressView.showBackgroundInnerShadow = @NO;
//    progressView.progress = 0.40;
//    progressView.animate = @YES;
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];
//    
//    // flat, purple, animated, opposite animate direction
//    progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 190, self.view.frame.size.width-40, 22)];
//    progressView.color = [UIColor purpleColor];
//    progressView.flat = @YES;
//    progressView.showBackgroundInnerShadow = @NO;
//    progressView.progress = 0.40;
//    progressView.animate = @YES;
//    progressView.animateDirection = LDAnimateDirectionBackward;
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];
//    
//    // progress gradient, red, animated
//    progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 220, self.view.frame.size.width-40, 22)];
//    progressView.color = [UIColor colorWithRed:0.73f green:0.10f blue:0.00f alpha:1.00f];
//    progressView.progress = 0.40;
//    progressView.animate = @YES;
//    progressView.type = LDProgressGradient;
//    progressView.background = [progressView.color colorWithAlphaComponent:0.8];
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];
//    
//    // solid style, default color, not animated, no text, less border radius
//    progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 250, self.view.frame.size.width-40, 22)];
//    progressView.color = [UIColor darkGrayColor];
//    progressView.showText = @NO;
//    progressView.progress = 0.40;
//    progressView.borderRadius = @5;
//    progressView.animate = @NO;
//    progressView.type = LDProgressSolid;
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];
//    
//    // stripe style, no border radius, default color, not animated
//    progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 280, self.view.frame.size.width-40, 22)];
//    progressView.progress = 0.40;
//    progressView.borderRadius = @0;
//    progressView.animate = @NO;
//    progressView.type = LDProgressStripes;
//    progressView.color = [UIColor orangeColor];
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 330, self.view.frame.size.width-40, 22)];
//    label.text = @"Outline Progress Views";
//    label.font = [UIFont boldSystemFontOfSize:20];
//    [self.view addSubview:label];
//    
//    // flat, green, no text, progress inset, outer stroke, solid
//    progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 360, self.view.frame.size.width-40, 22)];
//    progressView.color = [UIColor colorWithRed:0.00f green:0.64f blue:0.00f alpha:1.00f];
//    progressView.flat = @YES;
//    progressView.progress = 0.40;
//    progressView.animate = @YES;
//    progressView.showText = @NO;
//    progressView.showStroke = @NO;
//    progressView.progressInset = @5;
//    progressView.showBackground = @NO;
//    progressView.outerStrokeWidth = @3;
//    progressView.type = LDProgressSolid;
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];
//    
//    // flat, purple, progress inset, outer stroke, solid
//    progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(20, 420, self.view.frame.size.width-40, 22)];
//    progressView.color = [UIColor purpleColor];
//    progressView.flat = @YES;
//    progressView.progress = 0.40;
//    progressView.animate = @YES;
//    progressView.showStroke = @NO;
//    progressView.progressInset = @4;
//    progressView.showBackground = @NO;
//    progressView.outerStrokeWidth = @3;
//    progressView.type = LDProgressSolid;
//    
//    progressView.textAlignment = NSTextAlignmentCenter;
//    [progressView overrideProgressText:@"Cool!"];
//    [progressView overrideProgressTextColor:[UIColor grayColor]];
//    
//    [self.progressViews addObject:progressView];
//    [self.view addSubview:progressView];



}

- (RGGMyAssetsViewModel *)assetsViewModel{
    if (!_assetsViewModel) {
        _assetsViewModel = [[RGGMyAssetsViewModel alloc]init];
    }
    return _assetsViewModel;
}

- (void)requestData{
    [self.assetsViewModel getMyAssetsInfo:^(id json) {
        
       _assetsModel = json;
       [self.myAssetTable reloadData];
        NSLog(@"%@",_assetsModel.zongShouyi);
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        UITableViewCell  *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:@"总收益"];
        cell.textLabel.text = @"总收益";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",_assetsModel.zongShouyi];
        cell.detailTextLabel.textColor = [UIColor redColor];
        return cell;
    }
    
   else if (indexPath.section == 1) {
     RGGFixedIncomeCell *cell = [[RGGFixedIncomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.assetsModel = _assetsModel;
////    }
        return cell;

    }
    else{
        RGGTYongjinIcomeCell  *cell = [[RGGTYongjinIcomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.assetsModel = _assetsModel;
                    
        return cell;
    }
//    cell.rowDic = _meArray[indexPath.section][indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50.;
    }
    else if(indexPath.section == 1) {
        if (_assetsModel.productShouyi.count ==0) {
             return 50.;
        }
        else{ return 190.;}
       
    }
        
    else{
        if (_assetsModel.yongjinDaiShouyi.count ==0) {
            return 50.;
        }
        else{ return 90 + _assetsModel.yongjinDaiShouyi.count*25;}
       
    }
   
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        [self.navigationController pushViewController:[[RGGFixedIncomeController alloc]init] animated:YES];
    }
    else if (indexPath.section == 2){
    RGGYongjinController *yongjinVC = [[RGGYongjinController alloc]init];
        
    [self.navigationController pushViewController:yongjinVC animated:YES];
    }
    
}


- (UITableView *)myAssetTable{
    if (!_myAssetTable) {
        _myAssetTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _myAssetTable.delegate = self;
        _myAssetTable.dataSource = self;
        _myAssetTable.backgroundColor = BackgroundColor;
    }
    
    return _myAssetTable;
}

@end
