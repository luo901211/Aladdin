//
//  ApiMacros.h
//  Aladdin
//
//  Created by luo on 2017/4/7.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#ifndef ApiMacros_h
#define ApiMacros_h

#define SERVER_HOST  @"http://api.phpdog.me"
#define API_PAGE_SIZE 20

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




#endif /* ApiMacros_h */
