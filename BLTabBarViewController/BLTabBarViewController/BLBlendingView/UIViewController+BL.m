//
//  UIViewController+BL.m
//  tabBarMoveAnimation
//
//  Created by Jack on 2018/5/18.
//  Copyright © 2018年 bianla. All rights reserved.
//

#import "UIViewController+BL.h"
#import <objc/runtime.h>

static const NSString * norImageKey = nil;
static const NSString * highlitedImageKey = nil;
@implementation UIViewController (BL)

@dynamic norImage,highImage;

- (UIImage *)norImage {
    return objc_getAssociatedObject(self, &norImageKey);
}

- (void)setNorImage:(UIImage *)norImage {
    objc_setAssociatedObject(self, &norImageKey, norImage, OBJC_ASSOCIATION_RETAIN);
    
}
- (void)setHighImage:(UIImage *)highImage {
    objc_setAssociatedObject(self, &highlitedImageKey, highImage, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage *)highImage {
    return objc_getAssociatedObject(self, &highlitedImageKey);
}

@end
