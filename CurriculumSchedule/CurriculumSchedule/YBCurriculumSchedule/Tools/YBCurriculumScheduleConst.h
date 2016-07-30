//
//  YBCurriculumScheduleConst.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/29.
//  Copyright © 2016年 YB. All rights reserved.
//  常量

#import <UIKit/UIKit.h>
#import "UIView+BMLine.h"
#import "YBControl.h"
#import "NSDate+YBTime.h"
#import "YBDateListModel.h"
#import "YBDateTools.h"
#import "YBUILabel.h"
#import "YBCourseModel.h"

#define CSScreenWidth  [UIScreen mainScreen].bounds.size.width

#define CSScreenHeight [UIScreen mainScreen].bounds.size.height

//课表tableView高度
#define MytimeTable    [UIScreen mainScreen].bounds.size.height - 154

//蓝色
#define CSMainColor [UIColor colorWithRed:0/255.f green:153/255.f blue:255/255.f alpha:1]

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
