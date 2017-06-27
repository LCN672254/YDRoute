//
//  YDRouter.h
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//


/**
 路由中心。用于处理与外部的中介，不同模块中间的桥梁关系，协调不同模块间的工作。
 路由URL格式，与网络URL相同都为： scheme://host/path/query
 scheme:协议，APP本身独有协议，如果需要在APP外部唤醒APP，则需要将该协议暴露出去，否则在内部调用时，可以任意指定，为了安全起见，还是APP做全局配置
 host:具体执行模块，http请求host：port，APP路由处理不需要端口，只需明确具体执行模块，当模块不清晰时，APP可以尝试使用默认模块执行（目前未做处理，若模块未注册则会在执行过程返回NotFound错误）
 
 path:模块下的执行路径（模块下，依旧很有很多功能，当工程较多时，路径会教程，逻辑较复杂，目前路径只做一级，后面会完善，探讨多路径的执行）
 query:即请求中，所带的参数，用户目标模块页面的处理
 
 例如：abc://person/say?word=hello
 可以理解为，在abc协议下，执行person模块的say业务，业务参数是world，值为hello
 
 */

#import <Foundation/Foundation.h>
#import "YDRouteHandler.h"

@interface YDRouter : NSObject

+ (YDRouter *) shareRouter;

/**
 注册模块

 @param handler 模块的handler（用处看handler类）
 @param route 路径（模块名）
 */
- (void) registerHandler:(YDRouteHandler *) handler route:(NSString *)route;

/**
    执行URLString
 */
- (BOOL) handleURLString:(NSString *)string;

/**
 执行请求

 @param url 请求URL
 @return 返回执行结果
 */
- (BOOL) handleURL:(NSURL *)url;


/**
 执行请求

 @param url 请求的URL
 @param primitive 特殊参数
 @param call 执行完成，或者需要某些后续的回调
 @param completion 执行完成的回调，较call会早很多，这只是方法回调，用于监听方法是否调用完成
 @return 执行结果
 */
- (BOOL) handleURL:(NSURL *)url primitiveParameters:(NSDictionary *) primitive targetCallBack:(void(^)(NSError * error,id response))call completion:(void(^)(BOOL handle,NSError *error)) completion;

@end
