 //
//  GlobalConfig.h
//  Jiutifen
//
//  Created by shusy on 2017/11/11.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define MemerHeaderViewHeight 330//个人中心头部视图的高度
#define JTmargin 20//所有的间距
#define underLinecolor  UIColorFromRGB(0xe5e5e5)//所有下划线的颜色

#define weakifySelf  \
__weak __typeof(&*self)weakSelf = self;

#define strongifySelf \
__strong __typeof(&*weakSelf)self = weakSelf;

//导航栏高度
#define navHeight CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame) + 44

//keywindow
#define KeyWindow [UIApplication sharedApplication].keyWindow

//快速获取NSUserDefaults对象
#define Userdefaults NSUserDefaults.standardUserDefaults

#define GlobalNavTitleFontSize [UIFont systemFontOfSize:18] //导航栏标题字体大小
#define GlobalNavTitleColor UIColorFromRGB(0x333333) //导航栏标题颜色

//首页
#define MemerHeaderViewHeight 303//个人中心头部视图的高度
#define JTmargin 20//所有的间距
#define underLinecolor  UIColorFromRGB(0xf5f5f5)//所有下划线的颜色
#define globalBgColor UIColorFromRGB(0xf5f5f5)

//获取当前软件版本
#define CurrentVersion  [[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] floatValue]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//自动移颜色
#define CUSTOMCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//自动颜色 带透明度
#define CUSTOMCOLORA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//随机色
#define RANDOMCOLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

//快速发送一个通知
#define PostNotificationName(name) [[NSNotificationCenter defaultCenter] postNotificationName:(name) object:nil];

//个人头像占位图片
#define userDefaultIcon [UIImage imageNamed:@"default_icon"]

//自定义字体
#define CustomFontForFette(F) [UIFont fontWithName:@"Fette-Engschrift" size:F]
#define CustomFontForArial(F) [UIFont fontWithName:@"Arial-BoldMT" size:F]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_7 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

#define IS_IPHONE_7P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONEX (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define LINE_HEIGHT (1.0 / [UIScreen mainScreen].scale)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define JTNetError [JTHud showError:@"服务器无法连接"];

#pragma mark 全局配置
extern NSString *const testUser;//测试账号
#pragma mark API接口
extern NSString *const WEIXINAPPID;/// 微信appid名称
extern NSString *const WEIXINAPPSECRET;/// 微信appid
extern NSString *const SESSIONID;/// SESSIONID名称
extern NSString* const API_sendPhoneCode;//发送短信验证码
extern NSString* const API_login;      //用户登陆
extern NSString* const API_userInfo;  //获取个人中心用户信息
extern NSString* const API_uploadDataImg;  //上传头像 二进制流
extern NSString* const API_updateUserInfo; //修改个人资料
extern NSString* const API_SubscribeLevelList;  //申购获取等级列表
extern NSString* const API_levelInfo;  //会员等级信息
extern NSString* const API_bankList;  //银行卡列表
extern NSString* const API_bankArrayList; //银行列表
extern NSString* const API_addBank;  //添加银行卡
extern NSString* const API_deleteBank;//删除银行卡
extern NSString* const API_setDefaultBank;  //设置默认银行卡
extern NSString* const API_upgradeList; //获取升级历程
extern NSString* const API_cloudPointsDetail; //查看云积分明细
extern NSString* const API_cloudPotWithDrawDetail; //查看云积分提现记录
extern NSString* const API_withDrawInfo;//提现页面信息
extern NSString* const API_SubsLevelDetail;//查看等级权益
extern NSString* const API_SubsLevelupgrade;//会员等级升级
extern NSString* const API_SubsLevelReceiptsInfo;//收款信息展示
extern NSString* const API_cancelUpgarde;  //取消升级
extern NSString* const API_privilegeDetail;  //特权详情
extern NSString* const API_myTeamInfo;  //我的团队
extern NSString* const API_shareTeamList;  //分享团队列表
extern NSString* const API_shareTeamAllList;  //分享团队所有列表
extern NSString* const API_withDrawPoints; //积分提现
extern NSString* const API_totalProfit;//累计收益
extern NSString* const API_dayProfit;//查看昨日总收益
extern NSString* const API_subsidyProfit;  //投资补贴
extern NSString* const API_daySubsidyProfit;  //日营业额分红
extern NSString* const API_pointSubsidyProfit;  //见点奖励明细
extern NSString* const API_shareSubsidyProfit;  //分享奖励明细
extern NSString* const API_teamSubsidyProfit;  //团队奖励明细
extern NSString* const API_shoppingPoitntsDetail;//购物积分
extern NSString* const API_cloudDetail;//云积分
extern NSString* const API_cloudWithDrawDetail;//云积分 提现明细
extern NSString* const API_cloudWithDrawCancle;//云积分 取消提现
extern NSString* const API_cancelApplyAndUpgarde;//取消申请和升级
extern NSString* const API_getVersion; //获取版本更新
extern NSString* const API_weixinBind; //微信绑定
extern NSString* const API_tokenLogin; //免登陆


//===============通知相关==============
extern NSString* const cancleUpgradeNotificationName; //取消升级成功后的通知
extern NSString* const Notificationn_userInfoChange; //上传图像成功通知

//==============缓存相关===================
extern NSString* const XSCachesDirName;  //缓存目录名称

//服务器返回状态字段相关
extern NSString *const responseErrorMsg;  //错误信息提取自断
extern NSString *const responseCoder; //状态码
extern NSString *const responseObj; //返回的数据
extern NSString *const responseList; //返回的集合

#pragma mark 状态码
enum ErrorCode {
    SUCCESS                      = 0000,    /**成功 **/
    failCoder                      = 1000,    /**请求成功 返回错误信息**/
    UserNotHave                      = 102,    /**成功 **/
    INVALID_SESSION     = 99999,   // session失效 未登陆
};




