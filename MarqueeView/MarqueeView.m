//
//  MarqueeView.m
//  MarqueeView
//
//  Created by 李楠 on 2018/7/26.
//  Copyright © 2018年 李楠. All rights reserved.
//

#import "MarqueeView.h"
#import <LNCoreFoundation/DKMacros.h>
#import <LNCoreFoundation/UIView+Frame.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/RACReturnSignal.h>

@interface MarqueeView ()
@property (nonatomic, assign) int index;
@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) RACDisposable *disposable;
@end

@implementation MarqueeView

- (instancetype)initWithFrame:(CGRect)frame withTittle:(NSArray *)titles leftImage:(UIImage *)image {
    self = [super initWithFrame:frame];
    if (self) {
        self.index = 0;
        self.titleArr = titles;
        self.tintColor = [UIColor blueColor];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.clipsToBounds = YES;
        [self.firstBtn setTitle:[titles firstObject] forState:UIControlStateNormal];
        self.firstBtn.tag = self.index;
        [self addSubview:self.firstBtn];
        [self addSubview:self.nextBtn];
        if (image) {
            _imageView.image = image;
            [self addSubview:_imageView];
        }
        
        @weakify(self);
        self.disposable = [[RACSignal interval:3.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            @strongify(self);
            self.index ++;
            if (self.index == titles.count) {
                self.index = 0;
            }
            
            if (self.firstBtn.y == 0) {
                [self.nextBtn setTitle:self.titleArr[self.index] forState:UIControlStateNormal];
                self.nextBtn.tag = self.index;
            } else if (self.firstBtn.y == self.firstBtn.height) {
                [self.firstBtn setTitle:self.titleArr[self.index] forState:UIControlStateNormal];
                self.firstBtn.tag = self.index;
            }

            /** 两个btn相互交换位置, 动画执行完,两个btn的位置保持与原来一致 */
            [UIView animateWithDuration:0.8 animations:^{
                if (self.firstBtn.y == 0) {
                    self.firstBtn.y = - self.height;
                    self.nextBtn.y = 0;
                } else if (self.firstBtn.y == self.height) {
                    self.firstBtn.y = 0;
                    self.nextBtn.y = - self.height;
                }
            } completion:^(BOOL finished) {
                if (self.nextBtn.y == 0) {
                    self.firstBtn.y = self.height;
                } else if (self.firstBtn.y == 0) {
                    self.nextBtn.y = self.height;
                }
            }];
        }];
    }
    return self;
}


- (void)clickBtn:(UIButton *)btn {
    if (self.handlerTitleClickCallBack) {
        self.handlerTitleClickCallBack(btn.tag);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_imageView) {
        double width = _imageView.image.size.width;
        double height = _imageView.image.size.height;
        _imageView.frame = CGRectMake(6, 0, width, height);
        _imageView.centerX = self.centerX;
    }
    self.firstBtn.frame = CGRectMake(_imageView.left + 6, 0, self.width, self.height);
    self.nextBtn.frame = CGRectMake(_imageView.left + 6, self.height, self.width, self.height);
}

#pragma mark - lazy Method

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIButton *)firstBtn {
    if (!_firstBtn) {
        _firstBtn = [[UIButton alloc] init];
        _firstBtn.titleLabel.font = _titleFont;
        //靠左 不居中显示
        _firstBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        /**  文字多出部分 在右侧显示点点  */
        _firstBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_firstBtn setTitleColor:self.tintColor forState:UIControlStateNormal];
        [_firstBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        _nextBtn.titleLabel.font = _titleFont;
        //靠左 不居中显示
        _nextBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        /**  文字多出部分 在右侧显示点点  */
        _nextBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_nextBtn setTitleColor:self.tintColor forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}



#pragma mark - Setter && Getter Methods

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self.firstBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:titleColor forState:UIControlStateNormal];
    
}
- (void)setTitleFont:(UIFont *)titleFont{
    
    _titleFont = titleFont;
    self.firstBtn.titleLabel.font = titleFont;
    self.nextBtn.titleLabel.font = titleFont;
    
}



@end
