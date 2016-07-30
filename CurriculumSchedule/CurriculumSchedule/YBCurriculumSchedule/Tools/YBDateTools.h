//
//  YBDateTools.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/29.
//  Copyright © 2016年 YB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBDateTools : NSObject
/**
 *  NSDate转时间戳字符串
 */
+ (NSString *)stringTimeSpFromDate:(NSDate *)date;

/**
 *  计算一周的开始和结束时间
 *
 *  @return 返回一个字典：包含开始@"starTime"和结束时间and @"endTime"
 */
+(NSDictionary *)calculateTheStartAndEndTimesOfTheWeek;
/**
 *  根据一个星期的最后一天返回一周的日历数组
 *
 *  @param duedaySp 最后一天的日期
 *
 *  @return 返回一周的日历数组
 */
+ (NSMutableArray *)calendarWithLastDay:(NSString *)lastDayStr;
+ (NSString *)stringDateFromTimeSp:(NSString *)timeSp;

/**
 *  计算几天前或者几天后的日期
 *
 *  @param CalculateTheDate 计算的日期
 *  @param days 前后的天数
 @param beforeOrAfter Y前，N后
 *
 *  @return 返回这天的详细内容
 */
+ (NSString *)CalculateTheDate:(NSString *)calculateTheDateStr OfADay:(NSInteger)days BeforeOrAfter:(BOOL)beforeOrAfter;
/**
 *  用来判断当前时间返回值 为正则是大于当前时间，为负则是小于当前时间
 */
+ (NSInteger)stringTimeFromTimeSp:(NSString *)timeSp;

@end
