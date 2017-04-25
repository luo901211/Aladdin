//
//  VideoDetailViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetailViewModel : NSObject

- (void)loadDataWithID:(NSInteger)ID
               success:(VoidBlock)success
               failure:(VoidBlock)failure;
@end
