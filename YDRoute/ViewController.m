//
//  ViewController.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "ViewController.h"
#import "YDRouter.h"
#import "YDHomeRouteHandler.h"
#import "YDProductRouteHandler.h"
#import "YDAppRouteHandler.h"

@interface ViewController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) UITabBarController *tabbarController;
@property (nonatomic,strong) NSMutableArray *rootClasses;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [weakSelf initTabbarController];
    });
    
    [self registerRoute];
    
    self.rootClasses = [NSMutableArray array];
    
}

- (void) registerRoute{

    [[YDRouter shareRouter] registerHandler:[[YDHomeRouteHandler alloc] init] route:@"home"];
    [[YDRouter shareRouter] registerHandler:[[YDProductRouteHandler alloc] init] route:@"product"];
    [[YDRouter shareRouter] registerHandler:[[YDAppRouteHandler alloc] init] route:@"App"];
}

- (void) viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];

    _tabbarController.view.frame = self.view.bounds;
}


- (void) initTabbarController{

    _tabbarController = [[UITabBarController alloc] init];
    self.tabbarController.view.frame = self.view.bounds;
    self.tabbarController.delegate = self;
    [self.view addSubview:_tabbarController.view];
    [self addChildViewController:_tabbarController];
    
    UIViewController *home = [self creatViewControllerWithClassName:@"YDHomeController" title:@"首页"];
    UIViewController *product = [self creatViewControllerWithClassName:@"YDProductViewController" title:@"产品"];
    
    NSArray *viewControllers = @[home,product];
    self.tabbarController.viewControllers = viewControllers;
    
    [self.rootClasses addObject:@"home"];
    [self.rootClasses addObject:@"product"];
    
}

- (UIViewController *)creatViewControllerWithClassName:(NSString *)className title:(NSString *)title{

    Class class = NSClassFromString(className);
    
    UIViewController *vc = nil;
    
    if (class != nil) {

         vc = [[class alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
    }else{
    
        vc = [[UIViewController alloc] init];
    }
    
    vc.hidesBottomBarWhenPushed = NO;
    vc.tabBarItem.title = title;
    vc.title = title;
    
    return [[UINavigationController alloc] initWithRootViewController:vc];
    
}

- (UIViewController *)currentViewController{

    return  self.tabbarController.selectedViewController;
}

- (UIViewController *) viewControllerWithHost:(NSString *)host{

    NSInteger index = [self.rootClasses indexOfObject:host];
    
    if (index != NSNotFound) {
        
        return self.tabbarController.viewControllers[index];
    }
    
    return nil;
}

- (BOOL) switchToController:(UIViewController *) controller{

    UIViewController *current = [self currentViewController];
    
    if (controller != self.tabbarController.selectedViewController) {
        
        [self.tabbarController setSelectedViewController:controller];
        
    }
    
    if ([current isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *nav = (UINavigationController *)current;
        [nav popToRootViewControllerAnimated:YES];
        
    }else{
    
        [current.navigationController popToRootViewControllerAnimated:YES];
    }
    
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
