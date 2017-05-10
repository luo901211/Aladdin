//
//  ALDFinanceChapterModel.h
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "id": "1",
//    "title": "第一篇 aaaaaaa",
//    "chapter_id": "0",
//    "has_content": "0",
//    "child": [
//              {
//                  "id": "3",
//                  "title": "第一章 aaaaaaaa11111",
//                  "chapter_id": "1",
//                  "has_content": "0",
//              },
//              {
//                  "id": "4",
//                  "title": "第二章 aaaaaaaaa2222",
//                  "chapter_id": "1",
//                  "has_content": "0",
//                  "child": [
//                            {
//                                "id": "6",
//                                "title": "第一节 aaaaa22221111",
//                                "chapter_id": "4",
//                                "has_content": "1",
//                            }]
//              }]
//}
//

// 第一层模型
@interface ALDFinanceChapterModel : NSObject
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) BOOL is_open;

// data
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *chapter_id;
@property (nonatomic, copy) NSString *has_content;
@property (nonatomic, strong) NSArray <ALDFinanceChapterModel *>*child;


@end


