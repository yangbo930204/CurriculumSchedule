//
//  YBCourseDetailsView.m
//  CurriculumSchedule
//
//  Created by 站在巨人肩膀上的小菜鸟 on 16/7/30.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "YBCourseDetailsView.h"
#import "YBCurriculumScheduleConst.h"


#define BlueColor RGBA(0, 153, 255, 1)
#define RedColor RGBA(252, 67, 70, 1)
#define GrayColor RGBA(201, 201, 201, 1)
#define TextColor RGBA(129, 129, 129, 1)

@interface YBCourseDetailsView ()
/**
 *  背景
 */
@property (nonatomic,strong) UIView * courseDetailView;
/**
 *  课程名称
 */
@property (nonatomic,strong) UILabel * courseName;
/**
 *  开课时间
 */
@property (nonatomic,strong) UILabel * startTime;
/**
 *  课程状态
 */
@property (nonatomic,strong) UILabel * courseZT;
/**
 *  多门课程
 */
@property (nonatomic,strong) UIImageView * ManyCoursesImage;
@end

@implementation YBCourseDetailsView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //字体大小
        CGFloat textFont;
        if (CSScreenWidth < 375) {
            textFont = 13;
        }else{
            textFont = 15;
        }
        
        CGFloat width = (CSScreenWidth - 60)/3;
        CGFloat Height = (MytimeTable) / 7;
        
        UIView * courseDetailView = [YBControl createViewWithFrame:CGRectMake(5, 5, width-10, Height-10)];
        courseDetailView.backgroundColor = BlueColor;
        self.courseDetailView = courseDetailView;
        [self addSubview:courseDetailView];
        
        //课程名称
        NSString * textStr = @"花蜜课程";
        CGSize courseNameWidth= [YBControl sizeWithText:@"花蜜" font:[UIFont systemFontOfSize:textFont] maxH:(Height-10)/2];
        UILabel * courseName = [YBControl createLabelWithFrame:CGRectMake(0, 0, courseNameWidth.width+10, Height - 10) Text:textStr font:textFont];
        courseName.numberOfLines = 0;
        courseName.textColor = [UIColor whiteColor];
        
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:6];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
        courseName.attributedText = attributedString;
        courseName.textAlignment = NSTextAlignmentCenter;
        self.courseName = courseName;
        [courseDetailView addSubview:courseName];
        
        //开课时间
        UILabel * startTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(courseName.frame)-0.5, 0.5, courseDetailView.frame.size.width - courseName.frame.size.width, (Height-10)/2-4)];
        startTime.backgroundColor = [UIColor whiteColor];
        startTime.text = @"11:00";
        startTime.font = [UIFont systemFontOfSize:textFont];
        
        startTime.textAlignment = NSTextAlignmentCenter;
        
        startTime.textColor = TextColor;
        startTime.textAlignment = NSTextAlignmentCenter;
        self.startTime = startTime;
        [courseDetailView addSubview:startTime];
        
        //课程状态
        UILabel * courseZT = [YBControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(courseName.frame)-0.5, CGRectGetMaxY(startTime.frame)+0.5, courseDetailView.frame.size.width - courseName.frame.size.width, (Height-10)/2+2.5) Text:@"已完成" font:textFont];
        courseZT.backgroundColor = [UIColor whiteColor];
        courseZT.textColor = TextColor;
        courseZT.textAlignment = NSTextAlignmentCenter;
        
        self.courseZT = courseZT;
        [courseDetailView addSubview:courseZT];
        
        
        UIImageView * ManyCoursesImage = [YBControl createImageViewWithFrame:courseDetailView.frame ImageName:@"curriculum_multidoor_nor"];
        
        [self addSubview:ManyCoursesImage];
        CGFloat labelY = ManyCoursesImage.frame.size.height/2+0.5;
        UILabel * ManyCourseLabel = [YBControl createLabelWithFrame:CGRectMake(0.5, labelY, ManyCoursesImage.frame.size.width-1, ManyCoursesImage.frame.size.height-labelY-0.5) Text:@"多门课程" font:textFont];
        ManyCourseLabel.backgroundColor = [UIColor whiteColor];
        ManyCourseLabel.textAlignment = NSTextAlignmentCenter;
        ManyCourseLabel.textColor = TextColor;
        self.ManyCoursesImage = ManyCoursesImage;
        [ManyCoursesImage addSubview:ManyCourseLabel];
    }
    return self;
}

-(void)setCourseArray:(NSMutableArray *)courseArray
{
    _courseArray = courseArray;
    
    if (courseArray.count == 1) {
        self.courseDetailView.hidden = NO;
        self.ManyCoursesImage.hidden = YES;
        YBCourseModel * courseModel = courseArray[0];
        
        if (courseModel.typenames) {
            self.courseName.text = courseModel.typenames;
        }
        
        if (courseModel.status.integerValue == 1) {
            
            //比较两个日期的大小
            NSInteger big = [YBDateTools stringTimeFromTimeSp:courseModel.starttime];
            if (big > 0) {
                self.courseZT.text = @"已完成";
                self.courseDetailView.backgroundColor = BlueColor;
            }else{
                self.courseZT.text = @"待上课";
                self.courseDetailView.backgroundColor = RedColor;
            }
            
        }else if (courseModel.status.integerValue == 2) {
            self.courseDetailView.backgroundColor = GrayColor;
            self.courseZT.text = @"已取消";
        }
        if (courseModel.starttime) {
            self.startTime.text = [self stringDateFromTimeSp:courseModel.starttime];
            NSLog(@"starttime === %@",courseModel.starttime);
        }
        self.tag = courseModel.cid;
    }else{
        self.courseDetailView.hidden = YES;
        self.ManyCoursesImage.hidden = NO;
        
    }
}

- (NSString *)stringDateFromTimeSp:(NSString *)timeSp{
    
    if (timeSp.integerValue < 1) {
        return @"未填写";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    //    时间戳转时间的方法
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeSp.integerValue];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    return confromTimespStr;
}
@end
