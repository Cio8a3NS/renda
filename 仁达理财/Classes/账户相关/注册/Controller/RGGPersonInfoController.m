//
//  RGGPersonInfoController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/23.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGPersonInfoController.h"
#import "RGGPaySetController.h"
@interface RGGPersonInfoController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *wenxinLable;

@end

@implementation RGGPersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    
}


- (IBAction)next:(id)sender {
    //
    
    
    NSDictionary *dic = @{@"name":self.nameField.text,@"weixin":_wenxinLable.text};
    
    [self.dictionary addEntriesFromDictionary:dic];
    
    RGGPaySetController *paySetController = [[RGGPaySetController alloc]init];
    paySetController.dictionary = self.dictionary;
    [self.navigationController pushViewController:paySetController animated:YES];
}

@end
