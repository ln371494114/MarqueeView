//
//  ViewController.m
//  MarqueeView
//
//  Created by 李楠 on 2018/7/26.
//  Copyright © 2018年 李楠. All rights reserved.
//

#import "ViewController.h"
#import "MarqueeView.h"
#import <LNCoreFoundation/DKMacros.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MarqueeView *view = [[MarqueeView alloc] initWithFrame:CGRectMake(24, 100, kScreenWidth - 48, 44) withTittle:@[@"xixixxxxxxx", @"nnnnnnnnn", @"vvvvvvvvvvvv", @"bbbbbbbbbb"] leftImage:nil];
    view.backgroundColor = [UIColor orangeColor];
    view.handlerTitleClickCallBack = ^(NSInteger index) {
        NSLog(@"------ %ld -----", (long)index);
    };
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
