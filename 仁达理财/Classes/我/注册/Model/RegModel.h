//
//  RegModel.h
//  金惠家
//
//  Created by 杨方军 on 16/7/29.
//  Copyright © 2016年 金惠家. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger,RightType){

    DefaultType = 0,//默认类型
    ImageType   = 1,//显示图标
    HideIcoType = 2,//隐藏图标

};


@interface RegModel : NSObject


/**标题*/
@property (strong,nonatomic)NSString *title;

/**输入框缺省显示内容*/
@property (strong,nonatomic)NSString *placeStr;

/**右边的按钮的图标的名称或者是按钮的名称*/
@property (strong,nonatomic)NSString *rightBtnStr;

/**右边的按钮类型*/
@property (assign,nonatomic)RightType btnType;

/**是否显示密文*/
@property (assign,nonatomic)NSInteger is_Show;




@end
