//
//  YDHomeController.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/27.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDHomeController.h"
#import "YDRouter.h"
@interface YDHomeController ()

@end

@implementation YDHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesBegan:touches withEvent:event];

    [[YDRouter shareRouter] handleURL:[NSURL URLWithString:@"ydservice://product/product"]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
