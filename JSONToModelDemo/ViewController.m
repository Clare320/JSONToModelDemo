//
//  ViewController.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/17.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import <MessageThrottle/MessageThrottle.h>

#import "AFRespModel.h"
#import "Dog.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *reqButton;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.reqButton];
//    [self test];
    
    MTRule *rule = [[MTRule alloc] initWithTarget:self selector:@selector(requestAF) durationThreshold:1];
    [rule apply];
}

- (void)test {
    NSString *target = @"{\"address\":\"PuDong\"}";
    Dog *jsonDog = [Dog yy_modelWithJSON:target];
    NSLog(@"json--->%@", jsonDog);
    
    BOOL isValid = [NSJSONSerialization isValidJSONObject:@{ @"name": @"LBL" }];
    NSLog(@"isValid-->%d", isValid);
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[target dataUsingEncoding:NSUTF8StringEncoding ] options:NSJSONReadingMutableLeaves error:NULL];
    Dog *dog = [Dog yy_modelWithJSON:target];
    NSLog(@"dog:%@, dict:%@", dog, dict);
}


//MARK: - Event

- (void)requestAF {
    NSLog(@"---> call requestAF");
    [self.dataTask resume];
}

- (NSURLSessionDataTask *)dataTaskWithURL: (NSString *)url responseModel: (Class<YYModel>)cls completionHandler: (nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSObject *object = [[cls class] yy_modelWithJSON:responseObject];
        completionHandler(response, object, error);
    }];
    return  dataTask;
}

- (NSURLSessionDataTask *)originalDataTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://httpbin.org/get"]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"response:%@", response);
    }];
    return  dataTask;
}


//MARK: - Setter && Getter

- (UIButton *)reqButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 100, 50, 30);
    [button setTitle:@"请求" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(requestAF) forControlEvents:UIControlEventTouchUpInside];
    
    return  button;
}

- (NSURLSessionDataTask *)dataTask {
    return [self dataTaskWithURL:@"http://httpbin.org/get" responseModel:[AFRespModel class] completionHandler:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"responseObject:%@", responseObject);
    }];
}

@end


/**
 解决请求与响应不匹配的问题
 防抖 debounce 触发条件后开始计时，一旦又有人触发重新计时，一直到这个计时触发计时条件去执行
 节流 throttle  保证某个时间内只执行一次
 
 网络请求状态跟button的可用性关联在一起。
 
 事件响应传递机制
 */

/**
 移动设备上请求和web请求有什么区别？
 */


/**
 请求该在哪写？
 是写在ViewControll.m还是写在Model里面。在MVVM结构里面放在ViewModel里面？
 */

/**
 
 xcframework是啥？
 */

/**
 KVC KVO
 */
