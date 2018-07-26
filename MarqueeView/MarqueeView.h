//
//  MarqueeView.h
//  MarqueeView
//
//  Created by 李楠 on 2018/7/26.
//  Copyright © 2018年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 跑马灯
 */

@interface MarqueeView : UIView

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

/** 跑马灯标题 */
@property (nonatomic, strong) NSArray *titleArr;

/** 点击跑马灯消息回调 */
@property (nonatomic, copy) void (^handlerTitleClickCallBack) (NSInteger index);


/**
 初始化方法

 @param frame frame
 @param titles 标题
 @param image 左侧图标.  没有可传nil
 @return MarqueeView
 */
- (instancetype)initWithFrame:(CGRect)frame withTittle:(NSArray *)titles leftImage:(UIImage *)image;

@end
