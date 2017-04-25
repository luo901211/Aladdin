//
//  ALDExpertDetailModel.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDExpertDetailModel : NSObject
//{
//    company = "\U65e0\U5fe7\U82f1\U8bed";
//    desc = "\U63cf\U8ff0\U4ec0\U4e48";
//    id = 2;
//    level = 1;
//    "pic_url" = "http://api.aladingtax.com/Uploads/Picture/2017-03-22/58d281a8d3584.png";
//    position = "\U653e\U9876\U9876\U9876\U9876\U9876";
//    "real_name" = "\U6e29\U5f66\U78ca\U554a";
//}

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *real_name;


@end
