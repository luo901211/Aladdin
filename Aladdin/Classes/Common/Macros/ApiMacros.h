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


#endif /* ApiMacros_h */
