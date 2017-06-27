//
//  YDRouteHandler.h
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//


/**
    路由具体模块的处理单元，外部发起请求或者活动，有router做桥接，具体由handler执行
 */

#import <Foundation/Foundation.h>
#import "YDRouteRequest.h"
#import <UIKit/UIKit.h>

@interface YDRouteHandler : NSObject


/**
 是否要执行，某一路由请求

 @param request 请求
 @return 结果
 */
- (BOOL) shouldHandleRequest:(YDRouteRequest *)request;

/**
 若路由为页面跳转，此方法为跳转来源页(APP使用不同控制器做root会影响这里的逻辑，请根据实际情况去做相应调整)
 @param request 请求
 @return 当前页面
 */
- (UIViewController *) sourceViewControllerForTransitionRequest:(YDRouteRequest *)request;

/**
 同上，此方法是跳转目标也

 @param request 请求
 @return 目标也
 */
- (UIViewController *) targetViewControllerWithRequest:(YDRouteRequest *) request;


/**
 页面跳转是否是模态方式

 @param request 请求
 @return 是否模态
 */
- (BOOL) preferModalPresentationWithRequest:(YDRouteRequest *)request;


/**
 处理请求，当请求为非页面跳转时，重写该方法。或有其他权限要求时，亦可重写
 @param request 请求
 @param error 错误信息
 @return 处理结果
 */
- (BOOL) handleRequest:(YDRouteRequest *)request error:(NSError **)error;


/**
 该handler所要处理的模块
 
 @return 模块名称
 */
- (NSString *) handleHost;


/**
 该handler的配置文件名（目前为页面跳转时使用）

 @return 文件名
 */
- (NSString *) targetConfigeName;

@end
