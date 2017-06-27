//
//  YDRouteRequest.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDRouteRequest.h"
#import "NSError+RouteError.h"
#import "NSString+YDQuery.h"

@interface YDRouteRequest ()

@property (nonatomic, strong) NSURL *Url;
@property (nonatomic, strong) NSDictionary *routeParameters;
@property (nonatomic, strong) NSDictionary *primitiveParameters;
@property (nonatomic, copy) void(^targetCallBack)(NSError *error,id response);
@property (nonatomic, assign) BOOL isConsumed;
@property (nonatomic, strong) NSDictionary *queryParameters;
@end

@implementation YDRouteRequest

- (instancetype) initWithURL:(NSURL *)url route:(NSDictionary *)route primitive:(NSDictionary *)primitive targetCall:(void (^) (NSError * error, id response))back{

    self = [super init];

    if (self) {
        
        self.Url = url;
        self.routeParameters = route;
        self.primitiveParameters = primitive;
        self.targetCallBack = back;
        
    }
    
    return self;
}

- (instancetype) initWithURL:(NSURL *)url{

    return [self initWithURL:url route:nil primitive:nil targetCall:nil];
}

- (NSURL *)url{

    return self.Url;
}

- (NSDictionary *)queryParameters{

    if (!_queryParameters) {
        
        _queryParameters = self.Url.query.parametersFromQueryString;
        
    }
    
    return _queryParameters;
}

- (id) objectForKeyedSubscript:(NSString *)key{

    id value = self.queryParameters[key];

    if (value == nil) {
        
        value = self.routeParameters[key];
    }
    
    if (value == nil) {
        
        value = self.primitiveParameters[key];
    }
    
    return  value;
}


- (void)defaulteFinishTargetCallBack{
    
    if (self.targetCallBack) {
        
        self.targetCallBack(nil, [self routeResponse:1 message:@"成功"]);
    }
}

- (NSDictionary *)routeResponse:(NSInteger) code message:(NSString *)message{

    return @{@"code":@(code),@"message":message?:@""};
}

@end
