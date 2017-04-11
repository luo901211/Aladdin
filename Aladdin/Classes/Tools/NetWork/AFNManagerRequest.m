//
//  AFNManagerRequest.m
//  Aladdin
//
//  Created by luo on 2017/4/10.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AFNManagerRequest.h"
#import "AFHTTPSessionManager.h"

#define BASE_URL SERVER_HOST

#define kTIMEOUT_INTERVAL 15

@implementation AFNManagerRequest
/**
 *  类方法
 */
+ (AFNManagerRequest *)sharedUtil {
    
    static dispatch_once_t  onceToken;
    static AFNManagerRequest * setSharedInstance;
    
    dispatch_once(&onceToken, ^{
        setSharedInstance = [[AFNManagerRequest alloc] init];
        
    });
    return setSharedInstance;
}

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
                              failure:(HttpFailureBlock)failure {

    NSString *URLString = [BASE_URL stringByAppendingPathComponent:path];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:params error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            failure(error);
        } else {
            NSLog(@"url: %@",response.URL);
            NSLog(@"responseObject: %@",responseObject);
            #pragma mark - 业务代码
            // 统一处理错误
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 1) {
                success(response, responseObject[@"res"]);
            }else{
                
                NSError *error = [NSError errorWithDomain:response.URL.host code:code userInfo:responseObject];
                
                failure(error);
            }

        }
    }];
    [dataTask resume];
    return dataTask;
}

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
                               failure:(HttpFailureBlock)failure {
    
    NSString *URLString = [BASE_URL stringByAppendingPathComponent:path];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:params error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            failure(error);
        } else {
            NSLog(@"responseObject: %@",responseObject);
#pragma mark - 业务代码
            // 统一处理错误
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 1) {
                success(response, responseObject[@"res"]);
            }else{
                
                NSError *error = [NSError errorWithDomain:response.URL.host code:code userInfo:responseObject];
                failure(error);
            }
            
        }
    }];
    [dataTask resume];
    return dataTask;

}

/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */

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
                                       failure:(HttpFailureBlock)failure {
    NSString *URLString = [BASE_URL stringByAppendingPathComponent:path];

    NSURL *URL = [NSURL URLWithString:URLString];

    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            // 进度
            progress(downloadProgress.fractionCompleted);
        }
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (failure && error) {
            failure(error);
        } else if (success) {
            success(response, filePath);
        }
    }];
    [downloadTask resume];
    return downloadTask;
}



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
                                        failure:(HttpFailureBlock)failure {
    NSString *URLString = [BASE_URL stringByAppendingPathComponent:path];

    NSData *data = UIImagePNGRepresentation(image);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:imagekey mimeType:@"image/png"];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      if (progress) {
                          // 进度
                          progress(uploadProgress.fractionCompleted);
                      }                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (failure && error) {
                          failure(error);
                      } else if (success) {
                          success(response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
    
    return uploadTask;
}

@end
