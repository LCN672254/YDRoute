//
//  NSError+RouteError.h
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    YDErrorNotFound = 4100,             //未找到执行handler
    YDErrorSourceOrTargetNoeSpecified,  //当请求为页面跳转时，无法获取来源页或者目标页
    
} YDRouteError;

@interface NSError (RouteError)

+ (NSError *) YDRouteNotFound;
+ (NSError *) YDTransitionError;

@end
