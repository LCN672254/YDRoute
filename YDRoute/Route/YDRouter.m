//
//  YDRouter.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDRouter.h"
#import "NSError+RouteError.h"

@interface YDRouter ()

@property (nonatomic,strong) NSMutableDictionary *routHandlers;

@end

@implementation YDRouter

+ (YDRouter *)shareRouter{

    static YDRouter *route = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        route = [[YDRouter alloc] init];
    });

    return route;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _routHandlers = [NSMutableDictionary dictionary];
        
    }
    return self;
}

- (void) registerHandler:(YDRouteHandler *) handler route:(NSString *)route{

    [self.routHandlers setObject:handler forKey:route];

}

- (void) removeRouteHandler:(NSString *)route{

    [self.routHandlers removeObjectForKey:route];
    
}

/**
 路由的执行协议
 @return 协议名称
 */
- (NSString *) handleScheme{

    return nil;
}

- (BOOL) canHandleURL:(NSURL *)url{

    NSString *scheme = url.scheme;
    NSString *host = url.host;
    
    if (scheme == nil || host == nil) {
        
        return NO;
    }
    
    if (![scheme isEqualToString:[self handleScheme]]) {
        
        return NO;
    }
    
    YDRouteHandler *handle = self.routHandlers[host];
    
    if (handle == nil) {
        
        return NO;
    }
    
    YDRouteRequest *request = [[YDRouteRequest alloc] initWithURL:url];
    
    return [handle shouldHandleRequest:request];

}

- (BOOL) handleURLString:(NSString *)string{

    NSURL *url = [[NSURL alloc] initWithString:string];

    return [self handleURL:url];
}

- (BOOL) handleURL:(NSURL *)url{

    return [self handleURL:url primitiveParameters:nil targetCallBack:nil completion:nil];
}

- (BOOL) handleURL:(NSURL *)url primitiveParameters:(NSDictionary *) primitive targetCallBack:(void(^)(NSError * error,id response))call completion:(void(^)(BOOL handle,NSError *error)) completion{

    if (![self canHandleURL:url]) {

        YDRouteHandler *handler = self.routHandlers[@"default"];
            
        if (handler == nil) {
            
            completion(NO,[NSError YDRouteNotFound]);
        
            return NO;
        }
            
        YDRouteRequest *request = [[YDRouteRequest alloc] initWithURL:url route:nil primitive:primitive targetCall:call];
        
        if ([handler shouldHandleRequest:request]) {
            
            NSError *error = nil;
            
            BOOL result = [handler handleRequest:request error:&error];
            
            completion(true,error);
            
            return result;
            
        }else{
        
            completion(true,[NSError YDRouteNotFound]);
            
            return NO;
        
        }
    }
    
    YDRouteHandler *handler = self.routHandlers[url.host];
    
    YDRouteRequest *request = [[YDRouteRequest alloc] initWithURL:url route:nil primitive:primitive targetCall:call];
    
    NSError *error = nil;
    
    BOOL result = [handler handleRequest:request error:&error];
    
    completion(true,error);
    
    return result;

}


@end
