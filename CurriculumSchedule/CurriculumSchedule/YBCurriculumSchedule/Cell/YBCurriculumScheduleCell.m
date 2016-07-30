//
//  YBCurriculumScheduleCell.m
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/30.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "YBCurriculumScheduleCell.h"
#import "YBCurriculumScheduleConst.h"
#import "YBCourseView.h"

@interface YBCurriculumScheduleCell ()
/**
 *  当前月份(头)
 */
@property (nonatomic,strong) UIView * bgView;
/**
 *  当前月份(头)
 */
@property (nonatomic,strong) YBUILabel * currentMonthLabel;
/**
 *  当前日期(头)
 */
@property (nonatomic,strong) YBUILabel * currentTimeLabel;
/**
 *  蓝色圆背景
 */
@property (nonatomic,strong) UIView * RoundView;
/**
 *  课程视图
 */
@property (nonatomic,strong) YBCourseView * CourseView;
/**
 *  上午,Morning
 */
@property (nonatomic,strong) NSMutableArray * MorningArray;
/**
 *  中午,noon
 */
@property (nonatomic,strong) NSMutableArray * NoonArray;
/**
 *  下午,afternoon
 */
@property (nonatomic,strong) NSMutableArray * AfternoonArray;
/**
 *  滚动视图
 */
@property (nonatomic,strong) UIScrollView * scrollView;
/**
 *  页码指示器
 */
@property (nonatomic,strong) UIPageControl * pageCtl;
/**
 *  弹窗宽度
 */
@property (nonatomic,assign) NSInteger controlWidth;

@property (nonatomic,assign) NSInteger imageCount;  //图片个数

@end


@implementation YBCurriculumScheduleCell

+ (instancetype)curriculumScheduleCellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"CurriculumScheduleCell";
    YBCurriculumScheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YBCurriculumScheduleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //创建cell视图
        [self createCellView];
    }
    return self;
}
-(void)createCellView
{
    CGFloat viewHeight = (MytimeTable)/7;
    
    UIView * bgView = [YBControl createViewWithFrame:CGRectMake(0, 0, CSScreenWidth, viewHeight)];
    bgView.backgroundColor = RGBA(238, 238, 238, 1);
    self.bgView = bgView;
    //线条
    [bgView addLineWithType:BMLineTypeCustomDefault color:RGBA(208, 208, 208, 1) position:BMLinePostionCustomBottom];
    [self.contentView addSubview:bgView];
    
    
    //本周
    UIView * weekView = [YBControl createViewWithFrame:CGRectMake(0, 0, 60, viewHeight-1)];
    weekView.backgroundColor = RGBA(248, 248, 248, 1);
    
    [weekView addLineWithType:BMLineTypeCustomDefault color:RGBA(208, 208, 208, 1) position:BMLinePostionCustomRight];
    
    [bgView addSubview:weekView];
    //本周 圆背景
    UIView * RoundView = [YBControl createViewWithFrame:CGRectMake(4, 3, 52, 52)];
    RoundView.hidden = YES;
    RoundView.backgroundColor = RGBA(26, 156, 252, 1);
    RoundView.layer.cornerRadius = RoundView.frame.size.width/2;
    RoundView.layer.masksToBounds = YES;
    
    RoundView.center = CGPointMake(weekView.frame.size.width/2, weekView.frame.size.height/2);
    
    self.RoundView = RoundView;
    [weekView addSubview:RoundView];
    //月份或者本周
    self.currentMonthLabel = [[YBUILabel alloc]initWithFrame:CGRectMake(0, 5, 60, viewHeight/2+10)];
    self.currentMonthLabel.font = [UIFont systemFontOfSize:13];
    self.currentMonthLabel.text = @"星期一";
    self.currentMonthLabel.textColor = [UIColor blackColor];
    self.currentMonthLabel.textAlignment = NSTextAlignmentCenter;
    //居下对齐
    self.currentTimeLabel.verticalAlignment = VerticalAlignmentBottom;
    [weekView addSubview:self.currentMonthLabel];
    
    //日期
    self.currentTimeLabel = [[YBUILabel alloc]initWithFrame:CGRectMake(0, viewHeight/2 + 5, 60, viewHeight/2 - 5)];
    self.currentTimeLabel.text = @"12/18";
    self.currentTimeLabel.font = [UIFont systemFontOfSize:11];
    self.currentTimeLabel.textColor = RGBA(129, 129, 129, 1);
    self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    //居上对齐
    self.currentTimeLabel.verticalAlignment = VerticalAlignmentTop;
    [weekView addSubview:self.currentTimeLabel];
    
    YBCourseView * CourseView = [[YBCourseView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(weekView.frame), 0, CSScreenWidth - 60, viewHeight)];
    
    self.CourseView = CourseView;
    [self.bgView addSubview:CourseView];
}

@end
