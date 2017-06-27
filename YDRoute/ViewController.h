//
//  ViewController.h
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (UIViewController *) currentViewController;

- (UIViewController *) viewControllerWithHost:(NSString *) host;

- (BOOL) switchToController:(UIViewController *)vc;
@end

