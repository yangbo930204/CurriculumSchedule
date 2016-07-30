//
//  YBCurriculumScheduleCell.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/30.
//  Copyright © 2016年 YB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBCurriculumScheduleCell : UITableViewCell
/**
 *  创建cell
 */
+ (instancetype)curriculumScheduleCellWithTableView:(UITableView *)tableView;
/**
 *  星期
 */
@property (nonatomic,copy) NSString * weekStr;
/**
 *  当前日期
 */
@property (nonatomic,copy) NSString * currentDate;
/**
 *  是否是当前星期
 */
@property (nonatomic,assign) BOOL isCurrentWeek;

@end
