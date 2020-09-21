//
//  AFRespModel.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/21.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "AFRespModel.h"

@implementation AFHeaderModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return  @{
        @"accept": @"Accept",
        @"acceptEncoding": @"Accept-Encording",
        @"acceptLanguage": @"Accept-Language",
        @"host": @"Host",
        @"upgradeInsecureRequest": @"Upgrade-Insecure-Request",
        @"userAgent": @"User-Agent",
        @"xAmznTraceId": @"X-Amzn-Trace-Id"
    };
}

@end

@implementation AFRespModel

@end
