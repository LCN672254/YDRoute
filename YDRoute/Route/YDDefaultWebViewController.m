//
//  YDDefaultWebViewController.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDDefaultWebViewController.h"
#import "UIViewController+YDRouteRequest.h"
@interface YDDefaultWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation YDDefaultWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.ydRouteRequest.url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad:(UIWebView *)webView{

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}

@end
