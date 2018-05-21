//
//  ViewController.m
//  tabBarMoveAnimation
//
//  Created by Jack on 2018/5/16.
//  Copyright © 2018年 bianla. All rights reserved.
//

#import "ViewController.h"
#import "GlobalConfig.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"
#import "ThreeTableViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)configTabBarController {
    //配置标题大小 颜色
    self.titleScrollViewColor = [UIColor whiteColor];
    self.normalTitleBgColor = [UIColor clearColor];
    self.normalColor = UIColorFromRGB(0x999999);
    self.selectedColor = UIColorFromRGB(0x38c83d);
    self.underLineColor =  UIColorFromRGB(0x38c83d);
    self.underLineH = 2;
    self.titleHeight = 64;
    self.underLineType = UnderLineTypeTextBottom;
    //设置尺寸
    self.contentView.backgroundColor = [UIColor clearColor];
    self.firstMargin = 15;
    self.lastMargin = 15;
    //重新布局整个内容控件的位置
    self.contentView.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-44);
    //    self.topBgImageName = @"kehu_top_bg2";
    //    self.topBgImageContentMode = UIViewContentModeScaleAspectFill;
    self.isShowUnderLineCornerRadius = 2;
//        self.titleTopMargin = 15;
    self.textUnderLineMargin = 10;
    //    self.isShowGradient = false;
    self.isShowUnderLine = YES;
    self.scaleEffectPercent = 1.1;
    self.titleUnderlineColor = [UIColor lightTextColor];
    
}

- (void)buildChildControllers {
    //添加子控制器
    [self addChildController:@"OneTableViewController" title:@"记录" ];
    [self addChildController:@"OneTableViewController" title:@"指导"];
    [self addChildController:@"OneTableViewController" title:@"资料" ];
    [self addChildController:@"OneTableViewController" title:@"评测"];
}

@end
