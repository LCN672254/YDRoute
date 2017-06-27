//
//  NSString+YDQuery.h
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YDQuery)


/**
    解析数据时使用

 @return 数据接送
 */
- (NSDictionary *) parametersFromQueryString;

- (NSArray *) pathComponents;

+ (NSString *)queryStringFromParameters:(NSDictionary *)parameter;

- (Class) classType;

@end
