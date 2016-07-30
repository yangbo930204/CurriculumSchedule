//
//  NSDate+YBTime.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/29.
//  Copyright © 2016年 YB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YBTime)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  是否同一年
 */
- (BOOL)isSameYearWithDate:(NSDate *)endDate;
/**
 *  是否同一月
 */
- (BOOL)isSameMonthWithDate:(NSDate *)endDate;
/**
 *  是否同一天
 */
- (BOOL)isSamedayWithDate:(NSDate *)endDate;
@end
