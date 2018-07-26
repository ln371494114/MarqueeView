//
//  UIButton+enlargeEdge.h
//  duolabao_commercial
//
//  Created by linan on 2016/11/7.
//  Copyright © 2013-2018 duolabao.com All right reserved. This software is the confidential and proprietary information of duolabao.com (Confidential Information). You shall not disclose such Confidential Information and shall use it only in accordance with the terms of the license agreement you entered into with duolabao.com.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat) size;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
