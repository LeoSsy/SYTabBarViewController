## SYTabBarViewController

 首先感谢你的支持，SYTabBarViewController 是一个可以灵活配置的SYTabBarViewController控制器
 
 ## 图文渐变效果

 ![MacDown Screenshot](./tabbarcontrollerDemo.gif)
 
 ## 文字渐变效果
 
 ![MacDown Screenshot](./demo2.gif)
 
 ## 功能
 
 - [x] 支持 设置是否渐变
 - [x] 支持 设置是否缩放
 - [x] 支持 灵活配置内容控制器的frame
 - [x] 支持 设置标题的背景图片
 - [x] 支持 设置标题顶部间距 以及首个标题左侧间距
 - [x] 支持 最小标题个数均匀分布屏幕
 - [x] 支持 下标宽度根据标题宽度展示，隐藏下标，隐藏显示下划线
 - [x] 支持  配置只显示文字不显示图片功能

 
 ## 安装
 
 将 SYTabBarViewController 文件夹拽入项目中，导入头文件：#import "SYTabBarViewController.h"

## 使用
1.继承BLTabBarViewController

2.实现如下两个方法进行配置:

    - (void)configTabBarController;
    - (void)buildChildControllers;
    
示例：


    - (void)configTabBarController {
    //配置标题大小 颜色
    self.titleScrollViewColor = [UIColor whiteColor];
    self.normalTitleBgColor = [UIColor clearColor];
    self.normalColor = UIColorFromRGB(0x999999);
    self.selectedColor = UIColorFromRGB(0x38c83d);
    self.underLineColor =  UIColorFromRGB(0x38c83d);
    self.underLineH = 2;
    self.titleHeight = 94;
    self.underLineType = UnderLineTypeTextBottom;
    //设置尺寸
    self.contentView.backgroundColor = [UIColor clearColor];
    self.firstMargin = 15;
    self.lastMargin = 15;
    //重新布局整个内容控件的位置
    self.contentView.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-44);
    //    self.topBgImageName = @"kehu_top_bg2";
    //    self.topBgImageContentMode = UIViewContentModeScaleAspectFill;
    self.underLine.layer.cornerRadius = 2;
    self.titleTopMargin = 15;
    self.textUnderLineMargin = 10;
    //    self.isShowGradient = false;
    self.isShowUnderLine = YES;
    self.scaleEffectPercent = 1.1;
    self.titleUnderlineColor = [UIColor redColor];
    
    }
    
    - (void)buildChildControllers {
    //添加子控制器
    [self addChildController:@"OneTableViewController" title:@"记录" imageName:@"kehu_icon_jilu1" highImage:@"kehu_icon_jilu2"];
    [self addChildController:@"OneTableViewController" title:@"指导" imageName:@"kehu_icon_zhidao1" highImage:@"kehu_icon_zhidao2"];
    [self addChildController:@"OneTableViewController" title:@"资料" imageName:@"kehu_icon_ziliao1" highImage:@"kehu_icon_ziliao2"];
    [self addChildController:@"OneTableViewController" title:@"评测" imageName:@"kehu_icon_ceping1" highImage:@"kehu_icon_ceping2"];
    }
    


## ps

    如果你的标题数据都是通过服务器获取的话，那么你需要在你获取到标题之后调用父类的reloadData()方法来刷新数据


如果你在使用中遇到了什么问题，可以直接在讨论区提出，我会及时的解决。

更多功能敬请期待！ 
