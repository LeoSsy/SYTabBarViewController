//
//  UIViewController+BL.m
//  tabBarMoveAnimation
//
//  Created by Jack on 2018/5/18.
//  Copyright © 2018年  . All rights reserved.
//

#import "UIViewController+SY.h"
#import <objc/runtime.h>

static const NSString * norImageKey = nil;
static const NSString * highlitedImageKey = nil;
@implementation UIViewController (SY)

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
