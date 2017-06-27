//
//  YDRouteRequest.h
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

/*
    模拟系统Request，该request为路由request，用于处理路由问题，由URL（路由路径）生成
 */

#import <Foundation/Foundation.h>

@interface YDRouteRequest : NSObject
@property (nonatomic,readonly) NSURL *url;

/**
 初始化方法

 @param url 请求的URL
 @param route 路由参数（路由执行时，需要的一些参数）
 @param primitive 原始参数（默认参数）
 @param back 回调
 */
- (instancetype) initWithURL:(NSURL *)url route:(NSDictionary *)route primitive:(NSDictionary *)primitive targetCall:(void (^)(NSError *error,id response)) back;

- (instancetype) initWithURL:(NSURL *)url;

@end
