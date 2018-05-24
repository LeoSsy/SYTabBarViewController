//
//  BLBlendingLabel.h
//  BLTopTabBarView
//
//  Created by Jack on 2018/5/17.
//  Copyright © 2018年  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBlendingLabel : UILabel
/**绘制进度*/
@property(nonatomic,assign)CGFloat progress;
/**填充颜色*/
@property(nonatomic,strong)UIColor *fillColor;
@end
