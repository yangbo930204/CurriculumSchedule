//
//  YBDateTools.m
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/29.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "YBDateTools.h"
#import "NSDate+YBTime.h"

@implementation YBDateTools

//NSDate转时间戳字符串
+ (NSString *)stringTimeSpFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    // 转化成时间戳
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return timeStamp;
}

#pragma mark - 计算一周的开始和结束时间
+(NSDictionary *)calculateTheStartAndEndTimesOfTheWeek
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:now];
    
    // 得到星期几
    // 1(星期一) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 9 - weekDay;
    }
    
//    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    // 这里本来不加1
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [firstDayComp setDay:day + firstDiff+1];
    
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //
    NSLog(@"星期一开始 ====== %@",[formater stringFromDate:firstDayOfWeek]);
    //开始时间
    NSString * starTime = [YBDateTools stringTimeSpFromDate:firstDayOfWeek];
    //    NSLog(@"当前 %@",[formater stringFromDate:now]);
    NSLog(@"星期天结束 ====== %@",[formater stringFromDate:lastDayOfWeek]);
    //结束时间
    NSString * endTime = [YBDateTools stringTimeSpFromDate:lastDayOfWeek];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:starTime,@"starTime",endTime,@"endTime", nil];
}
#pragma mark - 根据一个星期的最后一天返回一周的日历数组
+ (NSMutableArray *)calendarWithLastDay:(NSString *)lastDayStr{

    NSAssert(lastDayStr.length
             >= 10, @"%@ 不是正确的时间戳，请输入正确的时间戳，比如：1446739200", lastDayStr);
    
    NSString *startSp = [NSString stringWithFormat:@"%ld",(lastDayStr.integerValue - 86400 *7)];
    
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startSp.integerValue];
    
    NSInteger startTime = startSp.integerValue;
    NSInteger endTime = lastDayStr.integerValue;
    
    NSInteger days = 1;
    NSInteger weekStr = 0;
    NSInteger months = 0;
    
    NSCalendar *fcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *babyDueStartComponents = [fcalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:startDate]; // 周一
    
    NSMutableArray *babyCalList = [[NSMutableArray alloc] init];
    for (int i= 0; i < 7; i++) {
        
        NSMutableArray *weekM = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < 1; j++) {
            if (startTime > endTime) {
                break;
            }
            
            NSDate *startDueDate = [NSDate dateWithTimeIntervalSince1970:startTime];
            NSDateComponents *dayOfWeekComponents = [fcalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit fromDate:startDueDate];
            
            NSString * dateStr = [NSString stringWithFormat:@"%ld",startTime];
            
//            NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:startTime];
            // 时间判断
//            if ([postDate isToday] && ![HMCityStr sharedHMCityStr].isLoadNextWeek) {   //是今天
//                [HMCityStr sharedHMCityStr].isToDay = YES;
//                
//            }else if(![HMCityStr sharedHMCityStr].isToDay){
//                [HMCityStr sharedHMCityStr].isToDay = NO;
//                
//            }
            
            [weekM addObject:dateStr];
            
            days += 1;
            if (babyDueStartComponents.day == dayOfWeekComponents.day) {
                months += 1;
            }
            startTime += 86400;
            if (dayOfWeekComponents.weekday == 1) {
                break;
            }
        }
        weekStr += 1;
        
//        HMMytimeTableDateList *CalendarList = [[HMMytimeTableDateList alloc] init];
//        CalendarList.days = weekM;
//        
//        [babyCalList addObject:CalendarList];
    }
    return babyCalList;
}

+ (NSString *)stringDateFromTimeSp:(NSString *)timeSp{
    
    if (timeSp.integerValue < 1) {
        return @"未填写";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:timeSp.integerValue];
    // 时间判断
    if ([postDate isThisYear]) {   //是今年
        [dateFormatter setDateFormat:@"MM/dd"];
    }else{
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp.integerValue];
        //获取当前时间
        NSCalendar *calendar = [NSCalendar currentCalendar];
        //获取当前是几月份
        NSUInteger unitFlags = NSMonthCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
        NSInteger month = [dateComponent month];
        
        if (month == 1) {
            [dateFormatter setDateFormat:@"MM/dd"];
            //  当前时间对应的周是当前月中的第几周
            //            NSInteger Week =  [[NSCalendar currentCalendar] ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
            //
            //            NSLog(@"week === %ld",Week);
            
            //            [dateFormatter setDateFormat:@"MM/dd"];
            //            NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            //            NSDateComponents *dateComponents = [greCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit fromDate:date];
            //            NSLog(@"year(年份): %li", (long)dateComponents.year);
            //            NSLog(@"quarter(季度):%li", (long)dateComponents.quarter);
            //            NSLog(@"month(月份):%li", (long)dateComponents.month);
            //            NSLog(@"day(日期):%li", (long)dateComponents.day);
            //
            //            //  苹果官方不推荐使用week
            //            NSLog(@"weekOfYear(该年第几周):%li", (long)dateComponents.weekOfYear);
            //            NSLog(@"weekOfMonth(该月第几周):%li", (long)dateComponents.weekOfMonth);
            
        }else{
            [dateFormatter setDateFormat:@"MM/dd"];
        }
    }
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *datett = [NSDate dateWithTimeIntervalSince1970:timeSp.integerValue];
    NSString *resultString =[dateFormatter stringFromDate:datett];
    return resultString;
}

//计算几天前或者几天后的日期
+ (NSString *)CalculateTheDate:(NSString *)calculateTheDateStr OfADay:(NSInteger)days BeforeOrAfter:(BOOL)beforeOrAfter
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:calculateTheDateStr.integerValue];
    NSTimeInterval oneDay = 86400;
    NSDate *date2;
    
    if(days!=0)
    {
        if (beforeOrAfter) {
            date2 = [date dateByAddingTimeInterval:-oneDay * days];
        }else{
            date2 = [date dateByAddingTimeInterval:oneDay * days];
        }
    }
    else{
        date2 = [NSDate date];
    }
    return [self stringTimeSpFromDate:date2];
}
+ (NSInteger)stringTimeFromTimeSp:(NSString *)timeSp{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:timeSp.integerValue];
    
    // 时间判断
    if ([postDate isThisYear]) {
        
        if ([postDate isToday]) {
            NSDateComponents *cmp = [postDate deltaWithNow];
            if (cmp.hour >= 1) {
                return 1;
            }else if (cmp.minute > 1){
                return 1;
            }else{
                if (cmp.minute > 0) {
                    return 1;
                }else{
                    return 0;
                }
            }
        }else if ([postDate isYesterday]){
            return 1;
        }else{
            return 1;
        }
    }else{
        return 1;
    }
    return 0;
}

@end
