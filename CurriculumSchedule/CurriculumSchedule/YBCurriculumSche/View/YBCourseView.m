//
//  YBCourseView.m
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/30.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "YBCourseView.h"
#import "YBCourseDetailsView.h"
#import "YBCurriculumScheduleConst.h"

@implementation YBCourseView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = (CSScreenWidth - 60)/3;
        CGFloat Height = (MytimeTable) / 7;
        // 初始化3个子控件
        for (int i = 0; i<3; i++) {
            YBCourseDetailsView * courseView = [[YBCourseDetailsView alloc]initWithFrame:CGRectMake(i * width, 0, width, Height)];
            courseView.userInteractionEnabled = YES;
            courseView.hidden = YES;
            [self addSubview:courseView];
        }
    }
    return self;
}

@end
