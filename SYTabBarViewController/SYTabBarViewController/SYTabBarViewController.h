//
//  SYBaseViewController.h
//  STTitleTabBarController
//
//  Created by Jack on 2018/5/17.
//  Copyright © 2018年 bianla. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 下划线展示的位置
 */
typedef NS_ENUM(NSUInteger, UnderLineType) {
    UnderLineTypeTop = 0,       //显示在顶部
    UnderLineTypeMiddle,        //显示在中间作为背景块展示在文字下面
    UnderLineTypeTextBottom,  //显示在文字下面 通过textUnderLineMargin调整文字和下划线的间距
    UnderLineTypeBottom        //显示在底部
};

/****以下是默认值可以配置***/

//导航栏的高度
static CGFloat SYTabBarH = 64;

@interface SYTabBarViewController : UIViewController

/** 整体内容View 包含标题好内容滚动视图 */
@property (nonatomic, weak) UIView *contentView;
/** 顶部滚动视图 */
@property (nonatomic, weak) UIScrollView *topScrollView;
/** 顶部滚动视图左右间距*/
@property (nonatomic, assign) CGFloat topScrollViewLRMargin;
/** 顶部滚动视图的圆角大小*/
@property (nonatomic, assign) CGFloat topScrollViewCornerRadius;
/** 顶部滚动视图的阴影大小*/
@property (nonatomic, assign) CGSize topScrollViewShadowOffset;
/** 顶部滚动视图的阴影颜色*/
@property (nonatomic, strong) UIColor *topScrollViewShadowColor;
/** 顶部滚动视图的背景图片 */
@property (nonatomic, strong) UIImage *topBgImage;
/** 顶部滚动视图的背景图片 */
@property (nonatomic, copy) NSString *topBgImageName;
/** 顶部滚动视图的背景图片显示模式 */
@property (nonatomic, assign) UIViewContentMode topBgImageContentMode;
/** 内容滚动视图 */
@property (nonatomic, weak) UIScrollView *contentScrollView;

//==========================标题相关属性＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
/** 标题view的背景颜色*/
@property (nonatomic, strong) UIColor *titleScrollViewColor;
/** 标题高度*/
@property (nonatomic, assign) CGFloat titleHeight;
/** 标题下划线视图下面很细的那条线 */
@property (nonatomic, weak) UIColor *titleUnderlineColor;
/** 标题下划线视图下面很细的那条线的高度 */
@property (nonatomic, assign) CGFloat titleUnderlineHeight;
/**标题字体大小*/
@property (nonatomic, strong) UIFont *titleFont;
/** 是否需要渐变效果*/
@property (nonatomic, assign) BOOL isShowGradient;
/** 是否需要缩放效果*/
@property (nonatomic, assign) BOOL isScaleEffect;
/** 缩放比例*/
@property (nonatomic, assign) CGFloat scaleEffectPercent;
/**是否需要标题下划线*/
@property (nonatomic, assign) BOOL isShowTitleUnderLine;
/** 默认标题颜色*/
@property (nonatomic, strong) UIColor *normalColor;
/**选中标题颜色*/
@property (nonatomic, strong) UIColor *selectedColor;
/** 默认标题的背景颜色*/
@property (nonatomic, strong) UIColor *normalTitleBgColor;
/** 标题间距 */
@property (nonatomic, assign) CGFloat titleMargin;
/** 第一个标题距离屏幕左边间距 */
@property (nonatomic, assign) CGFloat firstMargin;
/** 最后一个标题距离屏幕右边的间距 */
@property (nonatomic, assign) CGFloat lastMargin;
/** 标题顶部的间距 */
@property (nonatomic, assign) CGFloat titleTopMargin;
/** 标题的个数最少几个的时候 让标题均匀分布 刚好填充整个屏幕均分 且左右两边的间距 第一个标题和最后一个标题的间距可以自己设置
 即： 第一个标题距离屏幕左边的间距  最后一个标题距离屏幕右边的间距   要达到这样的效果 必须在设置此属性之前 设置 firstMargin lastMargin
 */
@property (nonatomic, assign) NSInteger titleMinCount;

//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝下划线属性＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
/**当设置为文字底部的下划线的时候 文字和下划线的间距*/
@property (nonatomic, assign)CGFloat textUnderLineMargin;
/**是否需要标题视图最下面很细的那条线*/
@property (nonatomic, assign) BOOL isShowUnderLine;
/**下划线显示的位置 分别为上面 下面 文字的底部 三个位置*/
@property (nonatomic, assign) UnderLineType underLineType;
/**下划线的颜色*/
@property (nonatomic, strong) UIColor *underLineColor;
/**下划线的高度*/
@property (nonatomic, assign) CGFloat underLineH;
/**是否显示下划线的圆角*/
@property (nonatomic, assign)BOOL isShowUnderLineCornerRadius;

//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝方法＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
/**重新加载数据 如果标题相关的数据是通过网络获取 需要在获取到数据之后调用此方法刷新数据*/
- (void)reloadData;

/**
 配置TabBarController的相关显示样式 交给子类重写实现
 */
- (void)configTabBarController;

/**
 配置子控制器 交给子类重写实现
 */
- (void)buildChildControllers;

/**
 添加同时显示标题图片的子控制器
 */
- (void)addChildController:(NSString*)vcName title:(NSString*)title imageName:(NSString *)imageName highImage:(NSString*)highImage;

/**
 添加只显示标题的子控制器
 */
- (void)addChildController:(NSString*)vcName title:(NSString*)title;

/**
 展示对应下标的控制器
 @param index 下标
 */
- (void)showViewController:(NSInteger)index;

@end

//作用是为了快速设置一个控件的frame
@interface UIView (Frame)
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end


