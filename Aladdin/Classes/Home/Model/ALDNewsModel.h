//
//  NewsModel.h
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 "add_date" = "2017-04-09";
 "add_time" = "2017-04-09 18:54:42";
 id = 3;
 "pic_url" = "";
 source = "\U963f\U62c9\U4e01";
 title = "\U6807\U9898\U554a\U6807\U9898";
 
 */

@interface ALDNewsModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *add_date;
@property (nonatomic, copy) NSString *add_time;

@end
