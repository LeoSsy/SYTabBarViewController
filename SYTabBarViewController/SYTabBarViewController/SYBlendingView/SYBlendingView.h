//
//  BLTabBarLabel.h
//  BLTopTabBarView
//
//  Created by Jack on 2018/5/17.
//  Copyright © 2018年  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYBlendingLabel.h"

@interface SYBlendingView : UIView
/**文本控件*/
@property(nonatomic,strong)SYBlendingLabel *label;
/**文本*/
@property(nonatomic,strong)NSString *text;
/**默认图片*/
@property(nonatomic,strong)UIImage *norImage;
/**高亮图片*/
@property(nonatomic,strong)UIImage *highlitedImage;
/**文字UIFont*/
@property(nonatomic,strong)UIFont *textFont;
/**文字*/
@property(nonatomic,assign)CGFloat textFontSize;
/**文本绘制进度*/
@property(nonatomic,assign)CGFloat progress;
/**默认文字颜色*/
@property(nonatomic,strong)UIColor *normalColor;
/**高亮文字颜色*/
@property(nonatomic,strong)UIColor *highlitedColor;
/**填充颜色*/
@property(nonatomic,strong)UIColor *fillColor;
/**反向动画 动画样式反转*/
@property(nonatomic,assign)BOOL reversedAnimation;
/**
 初始化方法 带文字图片同时渐变的效果
 @param text 显示文本
 @param imageName 默认图片
 @param highlitedImageName 高亮图片
 @param margin 标题跟图标的间距
 @return BLBlendingView
 */
+ (instancetype)blendViewWithText:(NSString*)text image:(NSString*)imageName highlitedImage:(NSString*)highlitedImageName margin:(CGFloat)margin;
/**
 初始化方法 仅带文字渐变的效果 不显示图片
 @param text 显示文本
 @return BLBlendingView
 */
+ (instancetype)blendViewWithText:(NSString*)text normalColor:(UIColor*)normalColor  highlitedColor:(UIColor*)highlitedColor textFont:(UIFont*)textFont;

/**
 重置为默认样式
 */
- (void)resentImage;

/**
 清除背景颜色
 */
- (void)clearBackgroundColor;
@end

