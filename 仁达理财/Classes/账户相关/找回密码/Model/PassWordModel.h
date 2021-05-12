//
//  PassWordModel.h
//  仁达
//
//  Created by 杨方军 on 16/7/30.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassWordModel : NSObject

/**标题*/
@property (strong,nonatomic)NSString *title;

/**输入框缺省显示内容*/
@property (strong,nonatomic)NSString *placeStr;

/**显示验证码*/
@property (assign,nonatomic)NSInteger show_Code;



@end
