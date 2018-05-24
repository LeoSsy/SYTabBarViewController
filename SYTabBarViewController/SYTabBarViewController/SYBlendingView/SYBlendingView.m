//
//  BLTabBarLabel.m
//  BLTopTabBarView
//
//  Created by Jack on 2018/5/17.
//  Copyright © 2018年 bianla. All rights reserved.
//

#import "SYBlendingView.h"

typedef NS_ENUM(NSUInteger, SYBlendingViewType) {
    SYBlendingViewTypeText,//仅仅显示文本 不显示图片
    SYBlendingViewTypeImage,//同时显示文本图片
};

@interface SYBlendingView()
/**背景视图*/
@property(nonatomic,strong)UIImageView *bgImageV ;
/**高亮视图*/
@property(nonatomic,strong)UIImageView *highlitedImageV ;
/**蒙版*/
@property(nonatomic,strong)UIView *maskView;
/**原来的默认图片*/
@property(nonatomic,strong)UIImage *oldNorImage ;
/**原来的高亮图片*/
@property(nonatomic,strong)UIImage *oldHighImage ;
/**标题距离图片的间距*/
@property(nonatomic,assign)CGFloat margin ;
/**显示类型*/
@property(nonatomic,assign)SYBlendingViewType displayType;
@end

@implementation SYBlendingView

/**
 初始化方法 带文字图片渐变的效果
 */
+ (instancetype)blendViewWithText:(NSString*)text image:(NSString*)imageName highlitedImage:(NSString*)highlitedImageName margin:(CGFloat)margin{
    return  [[SYBlendingView alloc] initWithFrame:CGRectZero text:text image:imageName highlitedImage:highlitedImageName margin:margin normalColor:[UIColor blackColor] highlitedColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:15] type:SYBlendingViewTypeImage];
}


/**
 初始化方法 仅带文字渐变的效果 不显示图片
 */
+ (instancetype)blendViewWithText:(NSString*)text normalColor:(UIColor*)normalColor  highlitedColor:(UIColor*)highlitedColor textFont:(UIFont*)textFont{
    return [[SYBlendingView alloc] initWithFrame:CGRectZero text:text image:nil highlitedImage:nil margin:0 normalColor:normalColor highlitedColor:highlitedColor textFont:textFont type:SYBlendingViewTypeText];
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString*)text image:(NSString*)imageName highlitedImage:(NSString*)highlitedImageName margin:(CGFloat)margin normalColor:(UIColor*)normalColor  highlitedColor:(UIColor*)highlitedColor textFont:(UIFont*)textFont type:(SYBlendingViewType)type
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        self.label = [[SYBlendingLabel alloc] init];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        //仅显示文本
        if (type == SYBlendingViewTypeImage) {
            UIImageView *bgImageV = [[UIImageView alloc] init];
            bgImageV.image = [UIImage imageNamed:imageName];
            [self addSubview:bgImageV];
            self.bgImageV =bgImageV;
            
            UIImageView *highlitedImageV = [[UIImageView alloc]init];
            highlitedImageV.image = [UIImage imageNamed:highlitedImageName];
            highlitedImageV.backgroundColor = [UIColor whiteColor];
            [self addSubview:highlitedImageV];
            self.highlitedImageV = highlitedImageV;
            
            UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
            maskView.backgroundColor = [UIColor whiteColor];
            self.maskView = maskView;
            highlitedImageV.layer.mask = maskView.layer;
            
            self.norImage = [UIImage imageNamed:imageName];
            self.highlitedImage = [UIImage imageNamed:highlitedImageName];
            self.oldNorImage = self.norImage;
            self.oldHighImage = self.highlitedImage;
            self.margin = margin;

        }else{
            self.label.font = textFont;
            self.label.textColor = normalColor;
            self.label.highlightedTextColor = highlitedColor;
        }
    
        self.label.text = text;
        self.displayType = type;
    }
    return self;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.label.textColor = normalColor;
}

- (void)setHighlitedColor:(UIColor *)highlitedColor {
    _highlitedColor = highlitedColor;
    self.label.highlightedTextColor = highlitedColor;
    self.label.fillColor = highlitedColor;
}

- (void)setNorImage:(UIImage *)norImage {
    if (!norImage) return;
    _norImage = norImage;
    self.bgImageV.image = norImage;
    [self setNeedsLayout];
}

- (void)setHighlitedImage:(UIImage *)highlitedImage {
    if (!highlitedImage) return;
    _highlitedImage = highlitedImage;
    self.highlitedImageV.image = highlitedImage;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
    [self setNeedsLayout];
}

- (void)resentImage{
    self.bgImageV.image = self.oldNorImage;
    self.highlitedImageV.image = self.oldHighImage;
}

/**
 清除背景颜色
 */
- (void)clearBackgroundColor {
    self.bgImageV.backgroundColor = [UIColor clearColor];
    self.highlitedImageV.backgroundColor = [UIColor clearColor];
}

- (void)setTextFont:(UIFont *)textFont {
    if (!textFont) return;
    _textFont = textFont;
    self.label.font = textFont;
    [self setNeedsLayout];
}

- (void)setTextFontSize:(CGFloat)textFontSize {
    if (!textFontSize) return;
    _textFontSize = textFontSize;
    self.label.font = [UIFont systemFontOfSize:textFontSize];
    [self setNeedsLayout];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.label.fillColor = fillColor;
}

- (void)setReversedAnimation:(BOOL)reversedAnimation {
    if (reversedAnimation) {
        self.norImage = self.oldHighImage;
        self.highlitedImage = self.oldNorImage;
    }else{
        self.norImage = self.oldNorImage;
        self.highlitedImage = self.oldHighImage;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //只显示文本
    if (self.displayType == SYBlendingViewTypeText) {
        CGFloat labelH = self.label.font.pointSize+5;
        CGFloat labelY = (self.bounds.size.height - labelH)*0.5;
        self.label.frame = CGRectMake(0, labelY ,self.bounds.size.width, labelH);
        return;
    }
    //显示图片
    if (self.norImage) {
        CGFloat imageW = self.norImage.size.width;
        CGFloat imageX = (self.bounds.size.width - imageW)*0.5;
        self.bgImageV.frame = CGRectMake(imageX, 0, imageW, self.norImage.size.height);
        if (self.highlitedImage) {
            CGFloat imageW = self.highlitedImage.size.width;
            CGFloat imageX = (self.bounds.size.width - imageW)*0.5;
            self.highlitedImageV.frame = CGRectMake(imageX, 0, imageW, self.highlitedImage.size.height);
        }
    }
    if (self.label.text) {
        CGFloat width = [self.label.text boundingRectWithSize:CGSizeMake(500, self.label.font.pointSize+5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil].size.width;
        CGFloat labelX = (self.bounds.size.width - width)*0.5;
        self.label.frame = CGRectMake(labelX, CGRectGetMaxY( self.bgImageV.frame)+self.margin,width, self.label.font.pointSize);
    }
    //改变mask
    CGRect frame = self.maskView.frame;
    frame.size.width = self.highlitedImage.size.width * self.progress;
    self.maskView.frame = frame;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self.label setProgress:progress];
    [self setNeedsLayout];
}

@end

