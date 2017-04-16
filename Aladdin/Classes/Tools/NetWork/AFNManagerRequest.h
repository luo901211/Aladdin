//
//  AFNManagerRequest.h
//  Aladdin
//
//  Created by luo on 2017/4/10.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+Network.h"

#pragma mark 网络请求类型
enum HTTPMETHOD{
    METHOD_GET   = 0,    //GET请求
    METHOD_POST  = 1,    //POST请求
};

#pragma mark 回调block
typedef void (^HttpSuccessBlock)(NSURLResponse  *response, id responseObject);
typedef void (^HttpFailureBlock)(NSError * error);
typedef void (^HttpDownloadProgressBlock)(CGFloat progress);
typedef void (^HttpUploadProgressBlock)(CGFloat progress);

@interface AFNManagerRequest : NSObject
/**
 *  类方法
 */
+ (AFNManagerRequest *)sharedUtil;

/**
 *  get网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */

+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                               params:(NSDictionary *)params
                              success:(HttpSuccessBlock)success
                              failure:(HttpFailureBlock)failure;

+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                               params:(NSDictionary *)params
                              hudType:(NetworkRequestGraceTimeType)hudType
                              success:(HttpSuccessBlock)success
                              failure:(HttpFailureBlock)failure;
/**
 *  post网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */

+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                                params:(NSDictionary *)params
                               success:(HttpSuccessBlock)success
                               failure:(HttpFailureBlock)failure;

+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                                params:(NSDictionary *)params
                               hudType:(NetworkRequestGraceTimeType)hudType
                               success:(HttpSuccessBlock)success
                               failure:(HttpFailureBlock)failure;

/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */

+ (NSURLSessionDownloadTask *)downloadWithPath:(NSString *)path
                                      progress:(HttpDownloadProgressBlock)progress
                                       success:(HttpSuccessBlock)success
                                       failure:(HttpFailureBlock)failure;

/**
 *  上传图片
 *
 *  @param path     url地址
 *  @param image    UIImage对象
 *  @param imagekey    imagekey
 *  @param params  上传参数
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */

+ (NSURLSessionUploadTask *)uploadImageWithPath:(NSString *)path
                                         params:(NSDictionary *)params
                                      thumbName:(NSString *)imagekey
                                          image:(UIImage *)image
                                       progress:(HttpUploadProgressBlock)progress
                                        success:(HttpSuccessBlock)success
                                        failure:(HttpFailureBlock)failure;


@end
