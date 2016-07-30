//
//  YBCurriculumScheduleController.m
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/29.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "YBCurriculumScheduleController.h"
#import "YBCurriculumScheduleConst.h"
#import "YBCurriculumScheduleCell.h"

@interface YBCurriculumScheduleController ()
<
UITableViewDataSource,
UITableViewDelegate
>

/**
 *  当前月份(头)
 */
@property (nonatomic,strong) UILabel * currentMonthLabel;
/**
 *  当前日期(头)
 */
@property (nonatomic,strong) UILabel * currentTimeLabel;
/**
 *  当前月份(尾)
 */
@property (nonatomic,strong) UILabel * currentMonthFooterLabel;
/**
 *  当前日期(尾)
 */
@property (nonatomic,strong) UILabel * currentTimeFooterLabel;

/**
 *  计算本周的开始和结束时间
 */
@property (nonatomic, strong) NSDictionary * currentWeekDict;
/**
 *  星期一开始时间
 */
@property (nonatomic,copy) NSString * starTime;
/**
 *  星期天结束时间
 */
@property (nonatomic,copy) NSString * endTime;
/**
 *  当前周日期数组
 */
@property (nonatomic,strong) NSMutableArray * currentWeekArray;
/**
 *  下周日期数组
 */
@property (nonatomic,strong) NSMutableArray * NextWeekArray;
@property (nonatomic,strong) UITableView * tableView;
/**
 *  Cell星期数组
 */
@property (nonatomic,strong) NSArray * cellWeekArray;

@end

@implementation YBCurriculumScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"课表";
    
    [self createCSHeaderView];
    [self createCSFooterView];
    
    //计算一周的开始和结束时间
    [self calculationCurrentWeek];
    
    //获取这一周的日期
//    [self getTheCurrentDateWeek];
    
    //初始化tableView
    [self createTableView];
    
    //加载数据
    //    [self loadData];
    //    self.isFirstTime = NO;
}
-(void)createTableView
{
    
//    self.cellHeight = (MytimeTable) / 7;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, CSScreenWidth, MytimeTable) style:UITableViewStylePlain];
    self.tableView.rowHeight = self.tableView.frame.size.height / 7;
    
    self.tableView.backgroundColor = RGBA(238, 238, 238, 1);

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //取消cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self pullToRefresh];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

#pragma mark - 创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YBCurriculumScheduleCell * CurriculumScheduleCell = [YBCurriculumScheduleCell curriculumScheduleCellWithTableView:tableView];
    
//    CurriculumScheduleCell.week = self.cellWeekArray[indexPath.row];
//    if (self.currentWeek == indexPath.row && [HMCityStr sharedHMCityStr].isToDay) {
//        myTimeCell.isCurrentWeek = YES;
//    }else{
//        myTimeCell.isCurrentWeek = NO;
//    }
    
//    myTimeCell.currentDate = [self stringDateFromTimeSp:self.currentWeekArray[indexPath.row]];
//    //    myTimeCell.myTimeTableModel = self.dataArray[];
//    myTimeCell.weekDataArray = [self isWeek:indexPath.row];
    
    //进入课堂
//    myTimeCell.courseBlock = ^(NSInteger courseID){
        //        HMNectarGroupDetailsController * cvc = [[HMNectarGroupDetailsController alloc]init];
        //        [self.navigationController pushViewController:cvc animated:YES];
//    };
    
    return CurriculumScheduleCell;
}

#pragma mark - 获取这一周的日期
-(void)getTheCurrentDateWeek
{
    self.currentWeekArray = [YBDateTools calendarWithLastDay:self.endTime];
    //重置头视图的日期间隔
    [self resetHeaderViewCurrentTimeLabel];
    //下一周的数据
    [self getNextDateWeek];
}
#pragma mark - 获取下一周的日期
-(void)getNextDateWeek
{
//    [HMCityStr sharedHMCityStr].isLoadNextWeek = YES;
    
    NSString * nextWeekStr = [YBDateTools CalculateTheDate:self.endTime OfADay:7 BeforeOrAfter:NO];
    self.NextWeekArray = [self getDateWeekEndTime:nextWeekStr];
    
    NSString * startWeekTime = [YBDateTools stringDateFromTimeSp:[self.NextWeekArray firstObject]];
    NSString * endWeekTime = [YBDateTools stringDateFromTimeSp:[self.NextWeekArray lastObject]];
    
    NSArray *arrayStartStr = [startWeekTime componentsSeparatedByString:@"/"]; //从字符中分隔成2个元素的数组
    NSArray *arrayEndStr = [endWeekTime componentsSeparatedByString:@"/"]; //从字符中分隔成2个元素的数组
    
    self.currentMonthFooterLabel.text = [NSString stringWithFormat:@"%@月",arrayStartStr[0]];
    
    self.currentTimeFooterLabel.text = [NSString stringWithFormat:@"%@~%@",arrayStartStr[1],arrayEndStr[1]];
    
//    [HMCityStr sharedHMCityStr].isLoadNextWeek = NO;
}
#pragma mark - 获取某一周的日期
-(NSMutableArray *)getDateWeekEndTime:(NSString *)endTime
{
    NSMutableArray * array = [YBDateTools calendarWithLastDay:endTime];
    NSMutableArray * dateArray = [NSMutableArray arrayWithCapacity:7];
    
//    for (HMMytimeTableDateList *babyList in array) {
//        for (NSString * dateStr in babyList.days) {
//            [dateArray addObject:dateStr];
//        }
//    }
    return dateArray;
}

//重置头视图的日期间隔
-(void)resetHeaderViewCurrentTimeLabel
{
    NSString * startWeekTime = [YBDateTools stringDateFromTimeSp:[self.currentWeekArray firstObject]];
    
    NSString * endWeekTime = [YBDateTools stringDateFromTimeSp:[self.currentWeekArray lastObject]];
    
    NSArray *arrayStartStr = [startWeekTime componentsSeparatedByString:@"/"]; //从字符中分隔成2个元素的数组
    NSArray *arrayEndStr = [endWeekTime componentsSeparatedByString:@"/"]; //从字符中分隔成2个元素的数组
    
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%@~%@",arrayStartStr[1],arrayEndStr[1]];
}

/**
 *  计算一周的开始和结束时间
 */
-(void)calculationCurrentWeek
{
    //计算一周的开始和结束时间
    NSDictionary * WeekDict = [YBDateTools calculateTheStartAndEndTimesOfTheWeek];
    //记录下当前周的数据（返回本周来用）
    self.currentWeekDict = WeekDict;
    
    //开始时间
    self.starTime = [self.currentWeekDict objectForKey:@"starTime"];
    
    //结束时间
    self.endTime = [self.currentWeekDict objectForKey:@"endTime"];
}

#pragma mark - 课表尾视图
-(void)createCSFooterView
{
    //背景
    UIView * footerView = [YBControl createViewWithFrame:CGRectMake(0, self.view.frame.size.height - 54, CSScreenWidth, 54)];
    footerView.userInteractionEnabled = YES;
    footerView.backgroundColor = [UIColor whiteColor];
    
    //灰线
    [footerView addLineWithType:BMLineTypeCustomDefault color:RGBA(208, 208, 208, 1) position:BMLinePostionCustomTop];
    
    [self.view addSubview:footerView];
    
    //本周
    UIView * footerWeekView = [YBControl createViewWithFrame:CGRectMake(0, 0, 60, 54)];
    footerWeekView.backgroundColor = [UIColor clearColor];
    [footerView addSubview:footerWeekView];
    
    //月份或者本周
    self.currentMonthFooterLabel = [YBControl createLabelWithFrame:CGRectMake(0, 5, 60, 27) Text:@"10月" font:13];
    self.currentMonthFooterLabel.textColor = CSMainColor;
    
    self.currentMonthFooterLabel.textAlignment = NSTextAlignmentCenter;
    
    [footerWeekView addSubview:self.currentMonthFooterLabel];
    //日期
    self.currentTimeFooterLabel = [YBControl createLabelWithFrame:CGRectMake(0, 22, 60, 27) Text:@"19~25" font:11];
    self.currentTimeFooterLabel.textColor = CSMainColor;
    self.currentTimeFooterLabel.textAlignment = NSTextAlignmentCenter;
    [footerWeekView addSubview:self.currentTimeFooterLabel];
    
    //回到本周
    UIButton * backCurrentWeekBtn = [YBControl createButtonWithFrame:CGRectMake(0, 0, CSScreenWidth, 54) Text:@"回到本周" ImageName:nil bgImagename:nil Target:self Method:@selector(backCurrentWeekBtn:)];
    [backCurrentWeekBtn setTitleColor:CSMainColor forState:UIControlStateNormal];
    backCurrentWeekBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:backCurrentWeekBtn];
    
    CGSize imageSize = [YBControl sizeWithText:backCurrentWeekBtn.titleLabel.text font:[UIFont systemFontOfSize:14] maxH:54];
    
    UIImageView * backImageView = [YBControl createImageViewWithFrame:CGRectMake(CSScreenWidth/2 + imageSize.width/2+5, 54/2-7, 27/2, 28/2) ImageName:@"curriculum_shuaxin_nor"];
    
    [footerView addSubview:backImageView];
}

#pragma mark - 返回本周
-(void)backCurrentWeekBtn:(UIButton *)btn
{
//    //是否是本周
//    [HMCityStr sharedHMCityStr].isToDay = YES;
//    [self CurrentMonthLabel:[HMCityStr sharedHMCityStr].isToDay];
//    
//    self.isFirstTime = YES;
//    //计算一周的开始和结束时间
//    [self calculationWeek];
//    
//    //获取这一周的日期
//    [self getTheCurrentDateWeek];
//    
//    [self.tableView reloadData];
}

#pragma mark - 课表头视图
-(void)createCSHeaderView
{
    //背景
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CSScreenWidth, 40)];
    headerView.backgroundColor = RGBA(248, 248, 248, 1);
    //灰线
    [headerView addLineWithType:BMLineTypeCustomDefault color:RGBA(208, 208, 208, 1) position:BMLinePostionCustomBottom];
    
    [self.view addSubview:headerView];
    
    //本周
    UIView * weekView = [YBControl createViewWithFrame:CGRectMake(0, 0, 60, 40)];
    weekView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:weekView];
    //月份或者本周
    self.currentMonthLabel = [YBControl createLabelWithFrame:CGRectMake(0, 5, 60, 20) Text:@"本周" font:13];
//    self.currentMonthLabel.text =  ([HMCityStr sharedHMCityStr].isToDay)?@"本周":@"1月";
    
    self.currentMonthLabel.textColor = CSMainColor;
    self.currentMonthLabel.textAlignment = NSTextAlignmentCenter;
    [weekView addSubview:self.currentMonthLabel];
    //日期
    self.currentTimeLabel = [YBControl createLabelWithFrame:CGRectMake(0, 20, 60, 20) Text:@"12~18" font:11];
    self.currentTimeLabel.textColor = CSMainColor;
    self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    [weekView addSubview:self.currentTimeLabel];
    
    //上午，中午，下午
    NSArray * MorningArray = @[@"上午",@"中午",@"下午"];
    NSArray * timeArray = @[@"06:00~13:00",@"13:00~19:00",@"19:00~24:00"];
    CGFloat width = (CSScreenWidth - 60)/3;
    for (int i = 0; i < 3; i++) {
        //灰线

        [weekView addSubview:[YBControl createLineViewWithFrame:CGRectMake(i*width+60, 0, 0.5, 40) color:RGBA(208, 208, 208, 1)]];
        
        UILabel * morningLabel = [YBControl createLabelWithFrame:CGRectMake(i*width+60, 5, width, 20) Text:MorningArray[i] font:13];
        morningLabel.textAlignment = NSTextAlignmentCenter;
        morningLabel.textColor = [UIColor blackColor];
        [weekView addSubview:morningLabel];
        
        //时间
        UILabel * timeLabel = [YBControl createLabelWithFrame:CGRectMake(i*width+60, 20, width, 20) Text:timeArray[i] font:13];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = RGBA(128, 128, 128, 1);
        [weekView addSubview:timeLabel];
    }
}
#pragma mark - 懒加载

-(NSArray *)cellWeekArray
{
    if (_cellWeekArray == nil) {
        _cellWeekArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",];
    }
    return _cellWeekArray;
}
@end
