//
//  BLBlendingLabel.m
//  BLTopTabBarView
//
//  Created by Jack on 2018/5/17.
//  Copyright © 2018年  . All rights reserved.
//

#import "SYBlendingLabel.h"

@implementation SYBlendingLabel
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    [self.fillColor?self.fillColor:[UIColor redColor] set];
//    rect.size.width = rect.size.width * _progress;
//    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
    //创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //创建位图
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    uint8_t pixel[4] = { 0 };
    CGContextRef context = CGBitmapContextCreate(&pixel, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
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
