//
//  Helper.m
//  CLICK
//
//  Created by Jie Zhang on 15/7/17.
//  Copyright © 2013-2018 duolabao.com All right reserved. This software is the confidential and proprietary information of duolabao.com (Confidential Information). You shall not disclose such Confidential Information and shall use it only in accordance with the terms of the license agreement you entered into with duolabao.com.
//
#define maxNum 5

#import "Helper.h"

@implementation Helper

#pragma mark - 工具方法


//设置高亮状态下btn背景色
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 设置富文本
/** 封装设置富文本(()) */
+ (NSMutableAttributedString *)attributedTextWithTitle:(NSString *)title text:(NSString *)text textColor:(UIColor *)textColor
{
    NSString *contentString = [NSString stringWithFormat:@"%@ (%@)",title,text];
    NSMutableAttributedString *contentAttributedString = [[NSMutableAttributedString alloc] initWithString:contentString];
    NSRange colorRange = NSMakeRange([[contentAttributedString string] rangeOfString:@"(" ].location , [contentAttributedString string].length - [[contentAttributedString string] rangeOfString:@"(" ].location);
    [contentAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:colorRange];
    
    return contentAttributedString;
}




#pragma mark - Common
+(void)showAlert:(NSString*)text
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:text message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];
}


#pragma mark - 推送相关




+ (NSMutableAttributedString *)attributedTextWithTitle:(NSString *)title spacing:(CGFloat )spacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    return attributedString;
}

/** 富文本数据~更改最后一个字的字体 */
+ (NSMutableAttributedString *)getAttributeStringWithContent:(NSString *)content font:(UIFont *)font
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange fontRange = NSMakeRange(content.length - 1, 1);
    [attributeString addAttribute:NSFontAttributeName value:font range:fontRange];
    return attributeString;
}

#pragma mark - 获取二维码
/**
 *  生成二维码
 *
 *  @param url  二维码内容
 *  @param size 图片宽
 *
 *  @return 二维码img
 */
+ (UIImage *)getQRCodeImageWithContent:(NSString *)url size:(CGFloat) size
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - 图片处理
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    };
        
    return imageData;
}


@end
