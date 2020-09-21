//
//  AFRespModel.h
//  JSONToModelDemo
//
//  Created by lj on 2020/9/21.
//  Copyright © 2020 Clare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHeaderModel : NSObject<YYModel>

@property (strong, nonatomic) NSString *accept;
@property (strong, nonatomic) NSString *acceptEncoding;
@property (strong, nonatomic) NSString *acceptLanguage;
@property (strong, nonatomic) NSString *host;
@property (strong, nonatomic) NSString *upgradeInsecureRequest;
@property (strong, nonatomic) NSString *userAgent;
@property (strong, nonatomic) NSString *xAmznTraceId;

@end

@interface AFRespModel : NSObject

@property (strong, nonatomic) NSDictionary *args;
@property (strong, nonatomic) AFHeaderModel *headers;
@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSString *url;

@end

NS_ASSUME_NONNULL_END
