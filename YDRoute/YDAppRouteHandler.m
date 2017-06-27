//
//  YDAppRouteHandler.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/27.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDAppRouteHandler.h"
#import "ViewController.h"
#import "NSString+YDQuery.h"
#import "NSError+RouteError.h"

@interface YDAppRouteHandler ()

@property (nonatomic,weak) ViewController *rootViewController;

@end

@implementation YDAppRouteHandler

- (ViewController *) rootViewController{

    return (ViewController *)[UIApplication sharedApplication].windows[0].rootViewController;
}

- (NSString *) handleHost{

    return @"App";
}

- (UIViewController *) targetViewControllerWithRequest:(YDRouteRequest *)request{

    NSArray *paths = request.url.path.pathComponents;
    
    if (paths.count>0) {
        
        NSString *host = paths[0];
        
        return [self.rootViewController viewControllerWithHost:host];
        
    }

    return nil;
}

- (BOOL) handleRequest:(YDRouteRequest *)request error:(NSError *__autoreleasing *)error{

//    UIViewController *source = [self sourceViewControllerForTransitionRequest:request];
    UIViewController *target = [self targetViewControllerWithRequest:request];
    
    if (target == nil) {
        
        *error = [NSError YDTransitionError];
        return NO;
        
    }

    return [self.rootViewController switchToController:target];
}


@end
