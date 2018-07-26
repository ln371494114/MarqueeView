//
//  DKMacros.h
//  CoreFoundation
//
//  Created by 李楠 on 2018/7/24.
//  Copyright © 2018年 李楠. All rights reserved.
//

#ifndef DKMacros_h
#define DKMacros_h

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define RGBColor(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define HEXCOLOR(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]
#define kStatusBarHeight 20
#define kNavigationBarHeight ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 64.0 : 44.0)

#define IS_IPAD          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4       (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE5       (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height <= 568.0f)
#define IS_IPHONE6       (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE6PLUS   (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_IPHONEX       (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)

//系统版本
#define iOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define iOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define KeyWindow      [UIApplication sharedApplication].keyWindow

#define Weak(var, weakVar) __weak __typeof(&*var) weakVar = var

//字体
#define NormalFontOfSize(fontSize)      [UIFont systemFontOfSize:fontSize]
#define BoldFontOfSize(fontSize)        [UIFont boldSystemFontOfSize:fontSize]

#endif /* DKMacros_h */
