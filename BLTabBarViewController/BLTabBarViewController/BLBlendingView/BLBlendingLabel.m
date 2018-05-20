//
//  BLBlendingLabel.m
//  BLTopTabBarView
//
//  Created by Jack on 2018/5/17.
//  Copyright © 2018年 bianla. All rights reserved.
//

#import "BLBlendingLabel.h"

@implementation BLBlendingLabel
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self.fillColor?self.fillColor:[UIColor redColor] set];
    rect.size.width = rect.size.width * _progress;
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

@end
