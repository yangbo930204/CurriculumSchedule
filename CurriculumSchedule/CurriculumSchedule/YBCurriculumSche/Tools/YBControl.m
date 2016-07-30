//
//  YBControl.h
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/29.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "YBControl.h"


//#import "HMCityStr.h"
#import "YBCurriculumScheduleConst.h"

@implementation YBControl

//创建View
+(UIView *)createViewWithFrame:(CGRect)frame
{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    return view;
}

//创建Label
+(UILabel *)createLabelWithFrame:(CGRect)frame Text:(NSString *)text font:(CGFloat)font;
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

//创建Button
+(UIButton *)createButtonWithFrame:(CGRect)frame Text:(NSString *)text ImageName:(NSString *)imageName bgImagename:(NSString *)bgImageName Target:(id)target Method:(SEL)method
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    if (text) {
        [button setTitle:text forState:UIControlStateNormal];
    }
    return button;
}

/**
 *  创建lineView
 */
+(UIView *)createLineViewWithFrame:(CGRect)frame color:(UIColor *)color
{
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = color;
    return lineView;
}
//创建ImageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled = YES;
    return imageView;
}

//用来算文字宽度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxH:(CGFloat)maxH
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxH);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//根据文字来算高度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

@end
