//
//  FJRootViewController.m
//  仁达
//
//  Created by 杨方军 on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "FJRootViewController.h"

@interface FJRootViewController ()




@end

@implementation FJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self initlizeAppance];
}

- (void)initlizeAppance{

    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
     

- (void)initlizeDataSource{
    
    
    
    
    
}

#pragma NavigationBarFunction
- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //nslog(@"日啊...内存警告了");
}



- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
    
}




@end
