//
//  NSString+YDQuery.m
//  YDRoute
//
//  Created by 梁城楠 on 2017/6/26.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "NSString+YDQuery.h"

@implementation NSString (YDQuery)

- (NSDictionary *)parametersFromQueryString{

    NSArray *params = [self componentsSeparatedByString:@"&"];

    if (params.count == 0) {
        
        return nil;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (NSString *string in params) {
        
        NSArray * p = [string componentsSeparatedByString:@"="];
        
        if (p.count==2) {
            
            [dic setObject:p[1] forKey:p[0]];
            
        }else{
        
            continue;
        }
    }
    
    return [dic copy];
}

- (NSArray *)pathComponents{

    NSArray *paths = [self componentsSeparatedByString:@"/"];
    NSMutableArray *p = [NSMutableArray array];
    
    for (NSString * s in paths) {
        
        if (s.length) {
            
            [p addObject:s];
        }
    }
    
    return [p copy];
}

- (Class) classType{

    return NSClassFromString(self);

}


+ (NSString *)queryStringFromParameters:(NSDictionary *)parameter{

    NSMutableArray *array = [NSMutableArray array];

    for (NSString *key in parameter.allKeys) {
     
        [array addObject:[NSString stringWithFormat:@"%@=%@",key,parameter[key]]];
        
    }
    
    return [array componentsJoinedByString:@"&"];
    
}

@end
