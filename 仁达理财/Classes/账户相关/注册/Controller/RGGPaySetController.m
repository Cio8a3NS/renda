//
//  RGGPaySetController.m
//  仁达理财
//
//  Created by yuanmc on 16/8/23.
//  Copyright © 2016年 六点科技. All rights reserved.
//

#import "RGGPaySetController.h"
#import "HcdActionSheet.h"
#import "MMPickerView.h"
@interface RGGPaySetController ()
@property (weak, nonatomic) IBOutlet UILabel *payTypeLable;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UILabel *selectBankLable;
@property (nonatomic, strong) NSArray *banksArray;
@property (nonatomic, strong) NSString * selectedString;
@property (nonatomic, strong) NSArray *objectsArray;
@property (nonatomic, assign) NSInteger selectedBankid;

@property (nonatomic, assign) id selectedObject;

@end

@implementation RGGPaySetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付设置";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPayTypeLable:)];
//    self.payTypeLable.userInteractionEnabled = YES;
    [self.payTypeLable addGestureRecognizer:tap];
    UITapGestureRecognizer *tapSelectBankLable = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelectBankLable:)];
    self.selectBankLable.userInteractionEnabled = YES;
    [self.selectBankLable addGestureRecognizer:tapSelectBankLable];
    
    self.banksArray = @[@"中国工商银行",@"中国农业银行",@"中国建设银行",@"中国银行",@"民生银行",@"广发银行",@"浦发银行",@"交通银行",@"中信银行",@"北京银行",@"渤海银行",@"其他银行"];
    _objectsArray = [NSArray arrayWithObjects: @"hello", @14, @13.3, @"Icecream", @1,  nil];
    
    _selectedObject = [_objectsArray objectAtIndex:0];
     _selectedString = [_banksArray objectAtIndex:0];
    
   }

- (void)tapSelectBankLable:(UITapGestureRecognizer *)tap{

    [MMPickerView showPickerViewInView:self.view
                           withStrings:_banksArray
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:_selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                
                              _selectBankLable.text = [NSString stringWithFormat:@"%@",selectedString];
                                _selectedString = selectedString;
                                for (int i=0; i<self.banksArray.count; i++) {
                                    if ([_selectedString isEqualToString:self.banksArray[i]]) {
                                        _selectedBankid = i+1;
                                    }
                                }
                            }];

}

//- (void)tapPayTypeLable:(UITapGestureRecognizer *)tap{
//    HcdActionSheet *sheet = [[HcdActionSheet alloc] initWithCancelStr:@"取消"
//                                                    otherButtonTitles:@[@"银行卡"]
//                                                          attachTitle:nil];
//    sheet.selectButtonAtIndex = ^(NSInteger index) {
//        if (index) {
//         self.payTypeLable.text = index == 1?@"支付宝":@"银行卡";
//            if (index == 2) {
//                
////                [UIView animateWithDuration:4 animations:^{
////                    self.accountField.frame = CGRectMake(21, 250, SCREEN_WIDTH-41, 40);
////                }];
//               
////                [UIView animateWithDuration:0.4 animations:^{
////                    self.accountField.frame = CGRectMake(21, 250, SCREEN_WIDTH-41, 40);
////                } completion:^(BOOL finished) {
////                   
////                    [UIView animateWithDuration:0.4 animations:^{
//                
//                       CGRect titleFrame =  self.accountField.frame;
//                        titleFrame.origin.y = 250;
//                        self.accountField.frame = titleFrame;
//                        CGRect downBtnFrame =  self.downBtn.frame;
//                        downBtnFrame.origin.y = 320;
//                        self.downBtn.frame = downBtnFrame;
//                         _selectBankLable.hidden = NO;
////                    }];
////                }];
//            }
//            else {
//             _selectBankLable.hidden = YES;
//            
//            }
//            
//        }
//
//    };
//    [[UIApplication sharedApplication].keyWindow addSubview:sheet];
//    [sheet showHcdActionSheet];
//}

- (IBAction)done:(id)sender {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在注册,请稍后..."];
    NSDictionary *dic = @{
                          @"banktype":@(2),
                          @"account" : self.accountField.text,
                          
                          @"bankid":@(_selectedBankid)
                          };
    [self.dictionary addEntriesFromDictionary:dic];
    [self.dictionary addEntriesFromDictionary:@{@"type":@"login_register",@"sign":[FactoryTool rendeCode],@"qtime":qtime}];
    NSLog(@"dictionary%@",self.dictionary);
    [HttpTool post:BaseURL params:self.dictionary success:^(id json) {
            NSLog(@"%@",json);
            if (![json isKindOfClass:[NSDictionary class]]) {
                          
                    [SVProgressHUD showInfoWithStatus:@"数据异常"];
            }
            [SVProgressHUD dismiss];
            NSInteger code = [json[@"status"] integerValue];
            switch (code) {
                case 1:
                [SVProgressHUD showInfoWithStatus:@"注册成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
                break;
                default:
                //失败了
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"注册失败!\n失败原因:%@",json[@"msg"]]];
                    break;
                }
                                  
            } failure:^(NSError *error) {
              [SVProgressHUD dismiss];
            [SVProgressHUD showInfoWithStatus:@"网络不给力，请检查网络设置!"];
                                  
            }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountField resignFirstResponder];

}


@end
