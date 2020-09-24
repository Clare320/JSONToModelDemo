//
//  MyClass.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/24.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "MyClass.h"

@interface MyClass () {
    NSInteger _instance1;
    NSString *_instance2;
}
@property (nonatomic, assign) NSUInteger integer;
- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;
@end

@implementation MyClass
+ (void)classMethod1 {
    NSLog(@"class method1");
}

- (void)method1 {
    NSLog(@"call method method1");
}

- (void)method2 {
    NSLog(@"call method2");
}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    NSLog(@"arg1: %ld, arg2: %@", arg1, arg2);
}

@end
