//
//  YDRouteHandler.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDRouteHandler.h"
#import "NSString+YDQuery.h"
#import "UIViewController+YDRouteRequest.h"
#import "NSError+RouteError.h"
#import "ViewController.h"

@interface YDRouteHandler ()

@property (nonatomic,strong) NSDictionary *confige;

@end

@implementation YDRouteHandler

- (NSDictionary *)confige{

    if (!_confige) {

        NSString *path = [[NSBundle mainBundle] pathForResource:[self targetConfigeName] ofType:@"plist"];
        self.confige = [NSDictionary dictionaryWithContentsOfFile:path];
        
    }

    return _confige;
}

- (NSString *) targetConfigeName{

    return  nil;
}

- (BOOL) shouldHandleRequest:(YDRouteRequest *)request{

    NSString *urlString = request.url.host;
    return  [urlString isEqualToString:[self handleHost]];
}

- (NSString *) targetViewControllerClassWithRequst:(YDRouteRequest *)request{

    NSString *key = request.url.lastPathComponent;
    return self.confige[key];
}

- (UIViewController *) targetViewControllerWithRequest:(YDRouteRequest *)request{

    NSString *className = [self targetViewControllerClassWithRequst:request];
    Class class = className.classType;
    
    if (class) {
        
        return [[class alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
    }
    
    return nil;
}

- (UIViewController *) sourceViewControllerForTransitionRequest:(YDRouteRequest *)request{

    UINavigationController *nav = (UINavigationController *)[[UIApplication sharedApplication] windows][0].rootViewController;
    
    if ([nav isKindOfClass:[ViewController class]]) {
     
        ViewController *vc = (ViewController *)nav;
        return [vc currentViewController];
        
    }
    
    return nil;
}

- (BOOL) preferModalPresentationWithRequest:(YDRouteRequest *)request{

    return false;
}

- (BOOL) transitionSourceViewController:(UIViewController *)source targetViewController:(UIViewController *) target isPresent:(BOOL) present{

    if (present || ![source isKindOfClass:[UINavigationController class]]) {
        
        [source presentViewController:target animated:YES completion:^{
            
        }];
    }else if ([source isKindOfClass:[UINavigationController class]]){
    
        UINavigationController *nav = (UINavigationController *)source;
        
        [nav pushViewController:target animated:YES];
    
    }else{
    
        return NO;
        
    }

    return YES;
}

- (BOOL) handleRequest:(YDRouteRequest *)request error:(NSError **) error{

    UIViewController *source = [self sourceViewControllerForTransitionRequest:request];
    UIViewController *target = [self targetViewControllerWithRequest:request];
    
    if (source == nil || target == nil) {
        
        *error = [NSError YDTransitionError];
        return NO;
    }
    
    target.ydRouteRequest = request;
    target.hidesBottomBarWhenPushed = YES;
    
    return [self transitionSourceViewController:source targetViewController:target isPresent:[self preferModalPresentationWithRequest:request]];
}

- (NSString *) handleHost{

    return nil;
}


@end
