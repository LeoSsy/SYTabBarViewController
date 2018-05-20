//
//  GlobalConfig.m
//  Jiutifen
//
//  Created by shusy on 2017/11/11.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "GlobalConfig.h"
#pragma mark 全局配置
NSString *const testUser = @"18800000002";//测试账号

#pragma mar 提示相关
NSString *const responseErrorMsg = @"errorMsg"; //错误信息提取自断
NSString *const responseCoder = @"coder"; //返回的状态
NSString *const responseObj = @"obj"; //返回的数据
NSString *const responseList = @"list"; //返回的集合
NSString *const SESSIONID = @"JSESSIONID";/// ESSIONID名称
//appid
NSString *const WEIXINAPPID = @"wx799ca04153cb59e4";//微信appid
NSString *const WEIXINAPPSECRET = @"8429fa579ba791b2552b9f919192aec2";// 微信appid

NSString* const API_sendPhoneCode = @"sendPhoneCode.shtml"; //发送短信验证码
NSString* const API_login = @"cust/login.shtml";      //用户登陆
NSString* const API_uploadDataImg = @"uploadImgServletHead";  //上传头像 二进制流
NSString* const API_updateUserInfo = @"cust/updateCust.shtml";  //修改个人资料
NSString* const API_userInfo = @"cust/appCenter.shtml";  //获取个人中心用户信息
NSString* const API_levelInfo = @"level/levelInfo.shtml";  //会员等级信息
NSString* const API_bankList = @"bank/custBankList.shtml";  //银行卡列表
NSString* const API_bankArrayList = @"bank/payBankList.shtml";  //银行列表
NSString* const API_addBank = @"bank/addCard.shtml";  //添加银行卡
NSString* const API_deleteBank = @"bank/delCard.shtml";  //删除银行卡
NSString* const API_setDefaultBank = @"bank/updIsDefault.shtml";  //设置默认银行卡
NSString* const API_upgradeList = @"level/upgradeRecordList.shtml";  //获取升级历程
NSString* const API_cloudPointsDetail = @"account/cloudDetail.shtml";  //查看云积分明细
NSString* const API_cloudPotWithDrawDetail = @"cashApply/recordList.shtml";  //云积分记录
NSString* const API_SubscribeLevelList = @"level/levelList.shtml";  //申购获取等级列表
NSString* const API_SubsLevelDetail = @"level/levelDetial.shtml";  //查看等级详情
NSString* const API_SubsLevelupgrade = @"level/upgrade.shtml";  //会员等级升级
NSString* const API_SubsLevelReceiptsInfo = @" level/receiptsInfo.shtml";  //收款信息展示
NSString* const API_cancelUpgarde = @"level/cancelUpgarde.shtml";  //取消升级
NSString* const API_privilegeDetail = @"level/privilegeDetail.shtml";  //特权详情
NSString* const API_myTeamInfo = @"team/teamInfo.shtml";  //我的团队
NSString* const API_shareTeamList = @"team/shareDetailList.shtml";  //分享团队列表
NSString* const API_shareTeamAllList = @"team/twoDetailList.shtml";  //分享团队所有列表
NSString* const API_withDrawInfo = @"cashApply/cashInfo.shtml";  //提现页面信息
NSString* const API_withDrawPoints = @"cashApply/cashApply.shtml";  //积分提现
NSString* const API_totalProfit = @"account/countProfit.shtml";  //累计收益
NSString* const API_dayProfit = @"account/yestSumProfit.shtml";  //查看昨日总收益
NSString* const API_subsidyProfit = @"/account/investDetail.shtml";  //投资补贴
NSString* const API_daySubsidyProfit = @"account/dayDetail.shtml";  //日营业额分红
NSString* const API_pointSubsidyProfit = @"account/poitProfitDetail.shtml";  //见点奖励明细
NSString* const API_shareSubsidyProfit = @"account/shareProfitDetail.shtml";  //分享奖励明细
NSString* const API_teamSubsidyProfit = @"account/teamProfitDetail.shtml";  //团队奖励明细
NSString* const API_shoppingPoitntsDetail=@"account/shoppingPoitntsDetail.shtml";//购物积分
NSString* const API_cloudWithDrawDetail=@"cashApply/applyDetail.shtml";//云积分 提现明细
NSString* const API_cloudWithDrawCancle=@"cashApply/cancelApply.shtml";//云积分 取消提现
NSString* const API_cancelApplyAndUpgarde=@"level/cancelUpgarde.shtml";//取消申请和升级
NSString* const API_getVersion = @"cust/getVersion.shtml"; //获取版本更新
NSString* const API_weixinBind = @"cust/bind.shtml"; //微信绑定
NSString* const API_tokenLogin = @"cust/tokenLogin.shtml"; //免登陆

//==================通知相关======================
NSString* const cancleUpgradeNotificationName = @"cancleUpgradeNotificationName"; //取消升级成功后的通知

NSString* const Notificationn_userInfoChange = @"Notificationn_userInfoChange";  //用户信息更新之后的通知
//缓存相关
NSString* const XSCachesDirName = @"XSales_cachesDir";  //缓存目录名称



