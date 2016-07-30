//
//  YBControl.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/29.
//  Copyright © 2016年 YB. All rights reserved.
//  创建一些常用UI的方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YBControl : NSObject

//创建View
+(UIView *)createViewWithFrame:(CGRect)frame;

//创建Label
+(UILabel *)createLabelWithFrame:(CGRect)frame Text:(NSString *)text font:(CGFloat)font;

//创建Button
+(UIButton *)createButtonWithFrame:(CGRect)frame Text:(NSString *)text ImageName:(NSString *)imageName bgImagename:(NSString *)bgImageName Target:(id)target Method:(SEL)method;

//创建ImageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;

/**
 *  创建lineView
 */
+(UIView *)createLineViewWithFrame:(CGRect)frame color:(UIColor *)color;

/**
 *  根据文字来算高度
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  用来计算文字宽度
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxH:(CGFloat)maxH;

@end
