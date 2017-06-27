//
//  YDDefaultRouteHandler.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDDefaultRouteHandler.h"
#import "NSError+RouteError.h"
#import "YDDefaultWebViewController.h"

@implementation YDDefaultRouteHandler

- (BOOL) shouldHandleRequest:(YDRouteRequest *)request{

    NSString *urlString = request.url.absoluteString;
    
    return ([urlString hasPrefix:@"http://"]||[urlString hasPrefix:@"https://"]);
}

- (UIViewController *) targetViewControllerWithRequest:(YDRouteRequest *)request{

    return [[YDDefaultWebViewController alloc] initWithNibName:@"YDDefaultWebViewController" bundle:[NSBundle mainBundle]];
    
}
@end
