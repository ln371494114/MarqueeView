//
//  Helper.h
//  CLICK
//
//  Created by Jie Zhang on 15/7/17.
//  Copyright © 2013-2018 duolabao.com All right reserved. This software is the confidential and proprietary information of duolabao.com (Confidential Information). You shall not disclose such Confidential Information and shall use it only in accordance with the terms of the license agreement you entered into with duolabao.com.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Helper : NSObject

#pragma mark - 工具方法

//设置高亮状态下btn背景色
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 设置富文本
/** 封装设置富文本(()) */
+ (NSMutableAttributedString *)attributedTextWithTitle:(NSString *)title text:(NSString *)text textColor:(UIColor *)textColor;


#pragma mark - Common
+(void)showAlert:(NSString*)text;


#pragma mark - 获取二维码
/**
 *  生成二维码
 *
 *  @param url  二维码内容
 *  @param size 图片宽
 *
 *  @return 二维码img
 */
+ (UIImage *)getQRCodeImageWithContent:(NSString *)url size:(CGFloat) size;

#pragma mark - 图片处理
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

@end
