//
//  ALDCollectModel.h
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDCollectModel : NSObject
//{
//    "collect_time" = "2017-05-14";
//    id = 19;
//    "publish_time" = "2017-04-30";
//    title = "\U5f20\U56db\U7684\U4e13\U5bb6\U89c2\U70b9";
//    type = news;
//    "type_id" = 5;
//    "type_name" = "\U8d44\U8baf\U65b0\U95fb";
//}
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *publish_time;
@property (nonatomic, copy) NSString *collect_time;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, assign) NSInteger type_id;


@end
