//
//  NSError+RouteError.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "NSError+RouteError.h"



#define errorDomain @"com.ydservice.error"

@implementation NSError (RouteError)

+ (NSError *) YDRouteNotFound{

    return [self YDErrorWithCode:YDErrorNotFound message:@"该路径未能找到执行页面"];

}

+ (NSError *) YDTransitionError{

    return [self YDErrorWithCode:YDErrorSourceOrTargetNoeSpecified message:@"来源或者去处不为控制器"];

}

+ (NSError *) YDErrorWithCode:(YDRouteError) code message:(NSString *)message{
    
    return [NSError errorWithDomain:errorDomain code:code userInfo:@{NSLocalizedDescriptionKey:message?:@""}];
}

@end
