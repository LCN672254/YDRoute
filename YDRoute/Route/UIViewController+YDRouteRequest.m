//
//  UIViewController+YDRouteRequest.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "UIViewController+YDRouteRequest.h"
#import <objc/runtime.h>

#define kViewControllerRouteRequestKey  @"kViewControllerRouteRequestKey"

@implementation UIViewController (YDRouteRequest)

- (void) setYdRouteRequest:(YDRouteRequest *)request{

    objc_setAssociatedObject(self, kViewControllerRouteRequestKey, request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YDRouteRequest *) ydRouteRequest{

    return  objc_getAssociatedObject(self, kViewControllerRouteRequestKey);

}

@end
