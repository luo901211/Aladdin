//
//  ApiMacros.h
//  Aladdin
//
//  Created by luo on 2017/4/7.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#ifndef ApiMacros_h
#define ApiMacros_h

//#define SERVER_HOST  @"http://api.phpdog.me"
#define SERVER_HOST  @"http://api.aladingtax.com"

#define API_PAGE_SIZE 20

/************************************************************************************************/
/**********资讯***********/

/*
 * 资讯分类
 *
 */
#define NEWS_TYPE @"/news/type"

/*
 * 资讯列表
 * type：非必填，分类id，默认全部类型
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define NEWS_LIST @"/news/index"

/*
 * 资讯轮播图
 * type：非必填，分类id，默认全部类型
 */
#define NEWS_BANNER_LIST @"/news/scroll"

/*
 * 发表资讯评论
 * token：必传，用户标识
 * id：必传，资讯id
 * comment：必传，评论内容
 */
#define NEWS_COMMENT_SUBMIT @"/news/comment"



/************************************************************************************************/
/**********发现***********/

/*
 * 视频-分类
 */
#define API_DISCOVER_VIDEO_TYPE @"/video/type"

/*
 * 视频-列表
 * type：非必填，分类id，默认全部类型
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define API_DISCOVER_VIDEO_LIST @"/video/index"

/*
 * 视频-详情
 * id：必填，视频id
 */
#define API_DISCOVER_VIDEO_DETAIL @"/video/detail"

/*
 * 政策法规-分类
 */
#define API_DISCOVER_POLICY_TYPE @"/policy/type"

/*
 * 政策法规-列表
 * type：非必填，分类id，默认全部类型
 * search：非必填，搜索内容
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define API_DISCOVER_POLICY_LIST @"/policy/index"

/*
 * 政策法规-详情
 * id：必填，视频id
 */
#define API_DISCOVER_POLICY_DETAIL @"/policy/detail"


/*
 * 财务秘籍-列表
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define API_DISCOVER_FINANCE_LIST @"/esoterica/index"
/*
 * 财务秘籍-章节
 * id：必传，秘籍id（上个接口返回的id）
 */
#define API_DISCOVER_FINANCE_CHAPTER @"/esoterica/chapter"
/*
 * 政策法规-详情
 * token：必传，用户标识
 * id：必传，章节id（上个接口返回的id）
 */
#define API_DISCOVER_FINANCE_DETAIL @"/esoterica/detail"


/*
 * 大咖-列表
 * level：必填  1优秀回答者，2知名专家
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define API_DISCOVER_EXPERT_LIST @"/expert/index"
/*
 * 大咖-详情
 * id：必传，大咖用户id	
 */
#define API_DISCOVER_EXPERT_DETAIL @"/expert/detail"

/*
 * 大咖-专家观点列表
 * id：必传，专家用户id
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define API_DISCOVER_EXPERT_NEWS_LIST @"/expert/news"

/*
 * 大咖-专家解答列表
 * id：必传，专家用户id
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define API_DISCOVER_EXPERT_ANSWER_LIST @"/expert/answer"

/*
 * 大咖-专家发表观点
 * token：必传，用户标识
 * title：必传，标题
 * desc：选填  描述
 * detail：必传，内容
 * pic：选填，封面图name=pic
 */
#define API_DISCOVER_EXPERT_NEWS_ADD @"/expert/addNews"


/************************************************************************************************/
/***账号模块***/

/*
 * 用户-发送短信验证码
 * mobile：必填，手机号
 */
#define API_SENDCODE @"/user/sendcode"


/*
 * 用户-注册
 * mobile：必填，手机号
 * code：必填，验证码
 * password：必填，密码
 */
#define API_REGISTER @"/user/register"

/*
 * 用户-手机号+密码登录
 * mobile：必填，手机号
 * password：必填，密码
 */
#define API_LOGIN_PASSWORD @"/user/login"

/*
 * 用户-手机号+验证码登录
 * mobile：必填，手机号
 * code：必填，验证码
 */
#define API_LOGIN_CODE @"/user/codeLogin"

/*
 * 用户-修改密码
 * token：必传，用户标识
 * old：必传，旧密码
 * new：必传，新密码
 * confirm：必传，确认密码
 */
#define API_CHANGE_PASSWORD @"/user/editPassword"

/*
 * 用户-找回密码
 * mobile：必填，手机号
 * code：必填，验证码
 * new：必填，新密码
 */
#define API_FIND_PASSWORD @"/user/findPassword"

/***个人中心模块***/
/*
 * 用户-查询用户信息
 * token：必传，用户标识
 */
#define API_USER_INFO @"/user/info"

/*
 * 用户-保存用户信息
 * token：必传，用户标识
 * real_name：必传
 * address：必传
 * company：必传
 * position：必传
 * pic ： 必传，name=pic, 使用file方式上传图像
 */
#define API_USER_SAVEINFO @"/user/saveInfo"

/*
 * 用户-消息分类
 * token：必传，用户标识
 */
#define API_USER_MSGTYPE @"/user/msgtype"

/*
 * 用户-消息列表
 * token：必传，用户标识
 * type：必传，分类标识（上个接口中的type值）
 */
#define API_USER_MSGLIST @"/user/msglist"

/*
 * 用户-投诉建议列表
 * token：必传，用户标识
 * type：必传，分类标识（上个接口中的type值）
 */
#define API_USER_OPINION  @"/user/opinion"

/*
 * 用户-添加收藏	
 * token：必传，用户标识
 * type：必传，收藏内容分类标识
 * id：必传，收藏内容id
 */
#define API_USER_COLLECT_ADD  @"/user/collect"

/*
 * 用户-收藏列表
 * token：必传，用户标识
 */
#define API_USER_COLLECT_LIST  @"/user/collectList"

/************************************************************************************************/
/***公司服务模块***/

/*
 * 平台服务-公司列表
 * page_num：非必填，第几页，默认1
 * page_size：非必填，每页条数，默认20
 */
#define API_SERVER_LIST @"/company/index"

/*
 * 平台服务-公司详情
 * id：必传，平台服务公司id
 */
#define API_SERVER_DETAIL @"/company/detail"


#endif /* ApiMacros_h */
