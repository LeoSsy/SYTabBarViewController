//
//  SYBaseViewController.h
//  STTitleTabBarController
//
//  Created by ssy on 16/6/1.
//  Copyright © 2016年 KUNROU. All rights reserved.
//

#import "SYTabBarViewController.h"
#import "SYBlendingView.h"
#import "UIViewController+SY.h"
//屏幕尺寸
#define SYScreenW [UIScreen mainScreen].bounds.size.width
#define SYScreenH [UIScreen mainScreen].bounds.size.height
//标题默认大小
#define BLTabBarNormalTitleFont [UIFont systemFontOfSize:15]
//默认缩放比例
#define BLScaleEffectPercent 1.1

@interface SYTabBarViewController ()<UIScrollViewDelegate>

/** 顶部视图的所有子控件数组 */
@property (nonatomic, strong) NSMutableArray *topScroSubviews;

/** 顶部视图背景控件 */
@property (nonatomic, strong) UIImageView *topBgView;

/** 第一个标题的宽度 */
@property (nonatomic, assign) CGFloat firstWidth;

/** 所有标题宽度数组 */
@property (nonatomic, strong) NSMutableArray *allTitleWidths;

/** 总的标题的宽度 */
@property (nonatomic, assign) CGFloat totalWidth;

//记录当前选中的标题label
@property(nonatomic,weak)SYBlendingView *selectedBlendView;

/** 标题下划线视图 */
@property (nonatomic, weak) UIView *titleUnderline;

/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat previousOffsetX;

/** 记录是否已经点击 只要为了解决重复设置下划线位置的问题*/
@property (nonatomic, assign) BOOL isClickedTitle;

@end

@implementation SYTabBarViewController

#pragma mark - 初始化方法
///如果当前类是通过代码创建的会进入这个方法
- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

///如果当前累是通过xib或者storaboard创建的会进入这个方法
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

///初始化方法
- (void)setup
{
    self.isShowGradient = YES; //设置文字图片渐变效果
    self.isScaleEffect = YES; //设置缩放效果
    self.isShowUnderLine = YES; //默认显示下划线
    self.titleFont = BLTabBarNormalTitleFont ; //默认标题大小15
    self.titleMargin = 20; //标题之间的默认间距
    self.firstMargin = 0; //第一个标题距离屏幕左边间距
    self.lastMargin = 0; //最后一个标题距离屏幕右边的间距
    self.titleMinCount = 6; //6个的时候 均分
    self.titleHeight = 50; //默认标题控件的高度
    self.underLineH = 2; //默认下划线的高度
    self.normalTitleBgColor = [UIColor whiteColor];//默认标题的背景颜色
    self.underLineType = UnderLineTypeBottom;//默认显示在最底部
    self.titleUnderlineColor = [UIColor grayColor];
    self.titleUnderlineHeight = 1;
    if (@available(iOS 11.0, *)) {//不要为scrollview添加额外的滚动区域
        self.contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.topScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

/**
 初始化配置
 */
- (void)configTabBarController{}

/**
 配置子控制器 交给子类重写实现
 */
- (void)buildChildControllers{}

/**
 添加同时显示标题图片的子控制器
 */
- (void)addChildController:(NSString*)vcName title:(NSString*)title imageName:(NSString *)imageName highImage:(NSString*)highImage{
    Class cls =  NSClassFromString(vcName);
    UIViewController *vc = [[cls alloc] init];
    //图片必须同时设置默认图片 和高亮图片才可以 否则 不会显示图片
    if (imageName && highImage) {
        vc.norImage = imageName;//如果设置了图片才会显示图标 否则不显示
        vc.highImage = highImage;
    }
    vc.title = title;
    [self addChildViewController:vc];
}

/**
 添加只显示标题的子控制器
 */
- (void)addChildController:(NSString*)vcName title:(NSString*)title{
    Class cls =  NSClassFromString(vcName);
    UIViewController *vc = [[cls alloc] init];
    vc.title = title;
    [self addChildViewController:vc];
}

#pragma mark - 生命周期方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    //配置展示样式
    [self configTabBarController];
    //配置子控制器
    [self buildChildControllers];
    //布局frame
    CGFloat contentY = self.navigationController?SYTabBarH : [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat contentW = SYScreenW;
    if (self.contentView.y) {
        contentY = self.contentView.y;
    }
    CGFloat contentH = SYScreenH - contentY;
    // 设置内容的尺寸
    if (self.contentView.height == 0) {
        self.contentView.frame = CGRectMake(0, 0, contentW, contentH);
    }
    // 设置标题尺寸
    CGFloat titleH = self.titleHeight;
    CGFloat titleY = 0;
    self.topScrollView.frame = CGRectMake(0, titleY, contentW, titleH);
    self.topScrollView.scrollsToTop = NO;
    // 设置内容滚动视图frame
    CGFloat contentScrollY = CGRectGetMaxY(self.topScrollView.frame);
    self.contentScrollView.frame =CGRectMake(0, contentScrollY, contentW, contentH - contentScrollY);
    self.contentScrollView.scrollsToTop = NO;
    self.contentScrollView.backgroundColor = [UIColor purpleColor];
    //设置背景视图
    self.topBgView.frame = self.topScrollView.bounds;
    //设置下划线frame
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.alpha = 0.5;
    titleUnderline.backgroundColor = self.titleUnderlineColor;
    titleUnderline.frame = CGRectMake(0, CGRectGetMaxY( self.topScrollView.frame)-self.titleUnderlineHeight, SYScreenW, self.titleUnderlineHeight);
    [self.topScrollView addSubview:titleUnderline];
    _titleUnderline = titleUnderline;
    
    if (@available(iOS 11.0, *)) {
        self.topScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //没有子控制器不执行下面的操作
    if (self.childViewControllers.count == 0 || self.topScroSubviews.count) return;
    //设置初始化操作
    self.contentScrollView.backgroundColor = self.view.backgroundColor;
    //获取所有标题的宽度 根据文字的内容多少得出总宽度
    [self caculateTitlesWidth];
    //添加所有子控件
    [self addTitlViews];
}

#pragma mark 重新加载数据
- (void)reloadData
{
    //清空数据
    [self.topScroSubviews removeAllObjects];
    [self.allTitleWidths removeAllObjects];
    [self caculateTitlesWidth];
    [self addTitlViews];
}

#pragma mark - 添加标题方法
/// 计算所有标题宽度
- (void)caculateTitlesWidth
{
    //获取所有的标题
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    __block CGFloat totalWidth = 0;
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        if (title!=nil) {
            CGRect titleFrame = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont?self.titleFont:BLTabBarNormalTitleFont} context:nil];
            CGFloat width = titleFrame.size.width;
            [self.allTitleWidths addObject:@(width)];
            totalWidth += width;
            if (idx==0) {self.firstWidth = width;}
        }
    }];
    self.totalWidth = totalWidth;
}

///添加所有的标题
- (void)addTitlViews
{
    //获取子控制器数量
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelW = 0;
    CGFloat labelH = self.titleHeight;
    CGFloat labelX = 0;
    CGFloat labelY = self.titleTopMargin;
    //其他按钮的间距
    CGFloat otherMargin = 0;
    if (count>self.titleMinCount) {
        otherMargin = self.titleMargin;
    }else{ //计算平均间距
        otherMargin =(SYScreenW - (self.firstMargin+self.lastMargin)- self.totalWidth)/(count-1);
    }
    // 添加所有的标题
    for (int i = 0; i < count; i++) {
         UIViewController *vc = self.childViewControllers[i];
        SYBlendingView *topTabBar = nil;
        if (vc.norImage && vc.highImage) {
            topTabBar = [SYBlendingView blendViewWithText:vc.title image:vc.norImage highlitedImage:vc.highImage margin:5];
            topTabBar.normalColor = self.normalColor;
            topTabBar.highlitedColor = self.selectedColor;
        }else{
            topTabBar = [SYBlendingView blendViewWithText:vc.title normalColor:self.normalColor highlitedColor:self.selectedColor textFont:self.titleFont?self.titleFont:BLTabBarNormalTitleFont];
        }
         topTabBar.tag = i;
         topTabBar.backgroundColor = [UIColor clearColor];
         topTabBar.label.font = self.titleFont?self.titleFont:BLTabBarNormalTitleFont;
         topTabBar.label.text = vc.title;
         labelW = [self.allTitleWidths[i] floatValue];
         SYBlendingView *lastLabel = [self.topScroSubviews lastObject];
        if (i==0) {//第一个标题加上首部的间距
            labelX = self.firstMargin + CGRectGetMaxX(lastLabel.frame);
        }else if(i==count-1){//最后一个标题加上尾部的间距
            if (count<=self.titleMinCount) {
                labelX = SYScreenW - self.lastMargin-labelW;
            }else{
                labelX = otherMargin + CGRectGetMaxX(lastLabel.frame);
            }
        }else{//其他标题的frame
            labelX = otherMargin + CGRectGetMaxX(lastLabel.frame);
        }
        topTabBar.frame = CGRectMake(labelX, labelY, labelW, labelH);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewClick:)];
        [ topTabBar addGestureRecognizer:tap];
        //保存控件
        [self.topScroSubviews addObject: topTabBar];
        [self.topScrollView addSubview: topTabBar];
        //第一个标题默认设置
        if (i == 0) {
            self.underLine.width = labelW;
            self.underLine.centerX = topTabBar.centerX;
            topTabBar.progress = 1.0;
            [self topViewClick:tap];
        }
    }
    // 设置标题滚动范围
    UILabel *lastLabel = self.topScroSubviews.lastObject;
    self.topScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame)-_titleMargin+_firstWidth, 0);
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.contentSize = CGSizeMake(count * SYScreenW, 0);
    [self.topScrollView bringSubviewToFront:self.underLine];

}

#pragma mark - 标题点击处理
// 标题按钮点击
- (void)topViewClick:(UITapGestureRecognizer *)tap
{
    //获取点击的标题
    SYBlendingView *label = (SYBlendingView *)tap.view;
    NSInteger i = label.tag;
    //记录标题被点击
    self.isClickedTitle = YES;
    if (i == 0 && !self.selectedBlendView) { //解决第一次初始选中第一个标题无法拿到子控件的frame问题
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self selectTitleFromView:label];
        });
    }else{
        [self selectTitleFromView:label];
    }
    //获取偏移量
    CGFloat offsetX = i * SYScreenW;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    self.previousOffsetX = offsetX;
    // 显示对应的控制器
    [self showViewController:i];
    //设置以前状态
    self.isClickedTitle = NO;
}

#pragma mark 选中一标题label
- (void)selectTitleFromView:(SYBlendingView *)blendView
{
    //防止重复选中同一个
    if (self.selectedBlendView == blendView )  return;

    //重置所有的状态
    self.selectedBlendView.label.textColor = self.normalColor;
    self.selectedBlendView.fillColor = self.normalColor;
    [self.selectedBlendView resentImage];
    self.selectedBlendView.progress = 0;
    
    //设置当前状态
    blendView.label.textColor = self.selectedColor;
    blendView.fillColor = self.selectedColor;
    if (!self.isShowGradient) {blendView.progress = 1.0;} //不需要标题渐变需要设置此属性让图片高亮

    //设置缩放
    if (self.isScaleEffect) {
        if (!self.selectedBlendView) {//第一次不需要展示缩放动画
            self.selectedBlendView.transform = CGAffineTransformIdentity;
            CGFloat scaleTransform = self.scaleEffectPercent?self.scaleEffectPercent:BLScaleEffectPercent;
            blendView.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.selectedBlendView.transform = CGAffineTransformIdentity;
                CGFloat scaleTransform = self.scaleEffectPercent?self.scaleEffectPercent:BLScaleEffectPercent;
                blendView.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
            }];
        }
    }
    
    //当所有的标题宽度大于屏幕宽度的时候才需要设置标题居中
    if (self.childViewControllers.count>self.titleMinCount) {
        // 设置标题居中
        [self setLabelTitleCenter:blendView];
    }
    
    // 设置下标的位置
    [self setUpUnderLine:blendView];
    
    //设置选中
    self.selectedBlendView = blendView;
}

// 设置下标的位置
- (void)setUpUnderLine:(SYBlendingView *)blendingView
{
    // 获取文字尺寸
    CGRect titleFrame = [blendingView.label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont?self.titleFont:BLTabBarNormalTitleFont} context:nil];
    self.underLine.height = self.underLineH;
   if (self.underLineType == UnderLineTypeTop ) {//如果是顶部的下划线
        self.underLine.y = titleFrame.origin.y;
    }else if (self.underLineType == UnderLineTypeTextBottom ){//文字底部的下划线
        CGFloat endY = self.titleTopMargin+CGRectGetMaxY(blendingView.label.frame)+self.textUnderLineMargin;
        if (endY>=blendingView.height) {endY =  blendingView.height - self.underLineH;}//如果大于标题的高度 就设置为底部的下划线
        self.underLine.y = endY;
    }else if (self.underLineType == UnderLineTypeBottom ){    //底部的下划线
          self.underLine.y = self.topScrollView.height - (self.underLine.height-1);
    }
    self.underLine.width = titleFrame.size.width;
    //首次显示不需要动画
    if (self.underLine.x ==0 ) {
        self.underLine.centerX = blendingView.centerX;
        return;
    }
    //添加动画
    self.underLine.width = titleFrame.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.centerX = blendingView.centerX;
    }];
}

// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(SYBlendingView *)label
{
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - SYScreenW * 0.5;
    if (offsetX < 0) {offsetX = 0;}
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.topScrollView.contentSize.width - SYScreenW;
    if (maxOffsetX < 0) {maxOffsetX = 0;}
    if (offsetX > maxOffsetX) {offsetX = maxOffsetX;}
    // 滚动区域
    [self.topScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark ============== UIScrollViewDelegate ===============

//正在滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        if (self.topScroSubviews.count == 0) return;
        // 获取偏移量
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger leftIndex = offsetX / SYScreenW;
        SYBlendingView *leftView = self.topScroSubviews[leftIndex];
        NSInteger rightIndex = leftIndex + 1;
        SYBlendingView *rightView = nil;
        if (rightIndex < self.topScroSubviews.count) {
            rightView = self.topScroSubviews[rightIndex];
        }
        [self setGradientWithOffset:offsetX rightView:rightView leftView:leftView];
        [self setUnderLineOffset:offsetX rightView:rightView leftView:leftView];
        [self setScaleWithOffset:offsetX rightView:rightView leftView:leftView];
        // 记录偏移量
        self.previousOffsetX = offsetX;
}

// 减速完成调用此方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算偏移距离
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger distance = (int)offsetX % (int)SYScreenW;
    if (distance > SYScreenW * 0.5) {        // 大于屏幕的一半表示往右边移动
        offsetX = offsetX + (SYScreenW - distance);
    }else if (distance < SYScreenW * 0.5 && distance > 0){ // 否则往左边移动
        offsetX =  offsetX - distance;
    }
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    NSInteger i = offsetX / SYScreenW;
    [self selectTitleFromView:self.topScroSubviews[i]];
    [self showViewController:i];
}

/**
 设置下划线偏移
 @param offsetX 偏移量
 @param rightView 右边的视图
 @param leftView 左边的视图
 */
- (void)setUnderLineOffset:(CGFloat)offsetX rightView:(SYBlendingView *)rightView leftView:(SYBlendingView *)leftView
{
    //记录标题是否点击 如果点击了就不要再设置偏移
    if (self.isClickedTitle) return;
    CGFloat centerDistance = rightView.x - leftView.x;
    // 距离
    CGFloat offsetDistance = offsetX - _previousOffsetX;
    // 计算需要移动的距离
    CGFloat moveX = offsetDistance * centerDistance / SYScreenW;
    //偏移动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.x += moveX;
    }];
}

/**
 设置渐变 文字和图片的渐变
 @param offsetX 偏移量
 @param rightView 右边的控件
 @param leftView 左边的控件
 */
- (void)setGradientWithOffset:(CGFloat)offsetX rightView:(SYBlendingView *)rightView leftView:(SYBlendingView *)leftView
{
    //如果用户设置不显示渐变就直接return
    if (!self.isShowGradient) return;
    // 计算右边比例 直接等于 当前偏移量和屏幕的比例leftLabel.tag 是为了让每次的计算比例值在0-1之间
    CGFloat sacle = offsetX / SYScreenW - leftView.tag;
    // 计算移动距离
    CGFloat distance = offsetX - self.previousOffsetX;
    if (distance > 0) { // 往右边移动
        rightView.label.textColor = self.normalColor;
        rightView.fillColor = self.selectedColor;
        rightView.progress = sacle;
        rightView.reversedAnimation = NO;
        
        leftView.label.textColor = self.selectedColor;
        leftView.fillColor = self.normalColor;
        leftView.progress = sacle;
        leftView.reversedAnimation = YES;

    } else if(distance < 0){ // 往左边移动
        
        rightView.label.textColor = self.normalColor;
        rightView.fillColor = self.selectedColor;
        rightView.progress = sacle;
        rightView.reversedAnimation = NO;

        leftView.label.textColor = self.selectedColor;
        leftView.fillColor = self.normalColor;
        leftView.progress = sacle;
        leftView.reversedAnimation = YES;
    }
}


/**
 设置缩放效果
 @param offsetX 偏移量
 @param rightView 右边的控件
 @param leftView 左边的控件
 */
- (void)setScaleWithOffset:(CGFloat)offsetX rightView:(SYBlendingView *)rightView leftView:(SYBlendingView *)leftView
{
    //如果用户不需要缩放 就不设置
    if (!self.isScaleEffect) return;
    // 计算右边比例 直接等于 当前偏移量和屏幕的比例leftLabel.tag 是为了让每次的计算比例值在0-1之间
    CGFloat rightSacle = offsetX / SYScreenW - leftView.tag;
    CGFloat leftScale = 1 - rightSacle;
    CGFloat percent =  (self.scaleEffectPercent?self.scaleEffectPercent:BLScaleEffectPercent);
    percent -= 1;
    // 设置缩放
    leftView.transform = CGAffineTransformMakeScale(leftScale * percent + 1, leftScale * percent + 1);
    rightView.transform = CGAffineTransformMakeScale(rightSacle * percent + 1, rightSacle * percent + 1);
}


#pragma mark 显示对应的控制器
- (void)showViewController:(NSInteger)index
{
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = index * SYScreenW;
    UIViewController *vc = self.childViewControllers[index];
    if (vc.isViewLoaded) return;// 如果控制器的view已经加载 就不需要在继续add
    vc.view.frame= CGRectMake(offsetX, 0, self.contentScrollView.width, self.contentScrollView.height);
    [self.contentScrollView addSubview:vc.view];
    
}

#pragma mark - 懒加载

- (NSMutableArray *)topScroSubviews
{
    if (_topScroSubviews == nil) {
        _topScroSubviews = [NSMutableArray array];
    }
    return _topScroSubviews;
}

- (NSMutableArray *)allTitleWidths
{
    if (_allTitleWidths == nil) {
        _allTitleWidths = [NSMutableArray array];
    }
    return _allTitleWidths;
}

- (UIView *)underLine
{
    if (_underLine == nil) {
        UIView *underLineView = [[UIView alloc] init];
        underLineView.backgroundColor = _underLineColor?_underLineColor:[UIColor redColor ];
        [self.topScrollView addSubview:underLineView];
        _underLine = underLineView;
    }
    return _isShowUnderLine?_underLine : nil;
}

- (UIScrollView *)topScrollView
{
    if (_topScrollView == nil) {
        UIScrollView *topScrollView = [[UIScrollView alloc] init];
        topScrollView.backgroundColor = _titleScrollViewColor?_titleScrollViewColor:[UIColor colorWithWhite:1 alpha:0.7];
        topScrollView.bounces = NO;
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.showsVerticalScrollIndicator = NO;
        topScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.contentView addSubview:topScrollView];
        _topScrollView = topScrollView;
    }
    return _topScrollView;
}

- (UIImageView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIImageView alloc] init];
        _topBgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.topScrollView addSubview:_topBgView];
    }
    return _topBgView;
}

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        UIScrollView *contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView = contentScrollView;
        _contentScrollView.backgroundColor = [UIColor orangeColor];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        [self.contentView insertSubview:contentScrollView belowSubview:self.topScrollView];
    }
    return _contentScrollView;
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        _contentView = contentView;
        [self.view addSubview:contentView];
    }
    return _contentView;
}

#pragma mark 属性改变监听

- (void)setNormalColor:(UIColor *)normalColor {
    if (normalColor == nil){
        _normalColor = [UIColor blackColor];
    }
    _normalColor = normalColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    if (selectedColor == nil) _selectedColor = [UIColor redColor];
}

- (void)setTitleUnderlineColor:(UIColor *)titleUnderlineColor {
    _titleUnderlineColor = titleUnderlineColor;
    _titleUnderline.backgroundColor = titleUnderlineColor;
    self.isShowTitleUnderLine = YES;
}

- (void)setIsShowTitleUnderLine:(BOOL)isShowTitleUnderLine {
    if (isShowTitleUnderLine) {
        self.titleUnderline.hidden = false;
    }else{
        self.titleUnderline.hidden = true;
    }
}

- (void)setIsShowUnderLine:(BOOL)isShowUnderLine
{
    _isShowUnderLine = isShowUnderLine;
}

- (void)settopScrollViewColor:(UIColor *)topScrollViewColor
{
    topScrollViewColor = topScrollViewColor;
    self.topScrollView.backgroundColor = topScrollViewColor;
}

- (void)setUnderLineColor:(UIColor *)underLineColor {
    _underLineColor = underLineColor;
    self.underLine.backgroundColor = underLineColor;
}

- (void)setTopBgImage:(UIImage *)topBgImage {
    _topBgImage = topBgImage;
    self.topBgView.image = topBgImage;
}

- (void)setTopBgImageName:(NSString *)topBgImageName {
    _topBgImageName = topBgImageName;
    self.topBgView.image = [UIImage imageNamed:topBgImageName];
}

- (void)setTopBgImageContentMode:(UIViewContentMode)topBgImageContentMode {
    _topBgImageContentMode = topBgImageContentMode;
    self.topBgView.contentMode = topBgImageContentMode;
}

@end


#pragma mark 作用是为了快速设置一个控件的frame
@implementation UIView (Frame)

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end

