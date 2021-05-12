//
//  RGGMeTabelView.m
//  仁达
//
//  Created by yuanmc on 16/7/28.
//  Copyright © 2016年 仁达. All rights reserved.
//

#import "RGGMeTabelView.h"
#import "RGGMeHeaderView.h"
#import "RGGMeCell.h"


@interface RGGMeTabelView()

@end
@implementation RGGMeTabelView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;

        [self loadMeView];
    }
    return self;
}

- (void)setMeArray:(NSArray *)meArray{
    _meArray = meArray;
}


- (void)loadMeView{
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    RGGMeHeaderView *meHeaerView = [[RGGMeHeaderView alloc]initWithFrame:CGRectMake(0, 100, screenWidth, 200)];
    meHeaerView.backgroundColor = GLOBALCOLOR(87, 158, 244);
   
    self.tableHeaderView = meHeaerView;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _meArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    NSArray *numRows = _meArray[section];
    return numRows.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RGGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
    if (cell == nil) {
        cell = [[RGGMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
    }
    
    cell.rowDic = _meArray[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ip6p?55*1.29:ip6?63 :ip4?46:55;
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
    if ([self.jumpDelegate respondsToSelector:@selector(jumpWeb:)]) {
        [self.jumpDelegate jumpWeb:indexPath];
    }
}

@end
