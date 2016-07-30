//
//  YBUILabel.h
//  HuamiBaby
//
//  Created by QiaoYuEr on 15/11/17.
//  Copyright © 2015年 花蜜宝宝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, //居上对齐，
    VerticalAlignmentMiddle,  //居中对齐
    VerticalAlignmentBottom,  //居下对齐
} VerticalAlignment;


@interface YBUILabel : UILabel
{
    @private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
