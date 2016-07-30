//
//  YBCourseModel.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/30.
//  Copyright © 2016年 YB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBCourseModel : NSObject
/**
 *  教师ID
 */
@property (nonatomic,copy) NSString * teacherid;
/**
 *  课程名称
 */
@property (nonatomic,copy) NSString * coursename;
/**
 *  头像
 */
@property (nonatomic,copy) NSString * image;
/**
 *  线上线下
 */
@property (nonatomic,copy) NSString * isonline;
/**
 *  名字
 */
@property (nonatomic,copy) NSString * name;
/**
 *  手机号
 */
@property (nonatomic,copy) NSString * phone;
/**
 *  课程id
 */
@property (nonatomic,assign) NSInteger cid;
/**
 *  课程开始时间
 */
@property (nonatomic,copy) NSString * starttime;
/**
 *  课程状态  1为：正常，2为取消
 */
@property (nonatomic,copy) NSString * status;
/**
 *  课程类型
 */
@property (nonatomic,copy) NSString * typenames;
@end
