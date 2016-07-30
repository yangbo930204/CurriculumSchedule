//
//  YBCourseView.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/30.
//  Copyright © 2016年 YB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBCourseView : UIView
/**
 *  用来判断是上午，中午，还是下午
 */
@property (nonatomic,assign) NSInteger isDateOfDay;
/**
 *  用来判断是第几个控件
 */
@property (nonatomic,assign) NSInteger isViewTag;
@end
