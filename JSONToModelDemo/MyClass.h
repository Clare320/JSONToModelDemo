//
//  MyClass.h
//  JSONToModelDemo
//
//  Created by lj on 2020/9/24.
//  Copyright © 2020 Clare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClass : NSObject<NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;

- (void)method1;
- (void)method2;
+ (void)classMethod1;

@end

NS_ASSUME_NONNULL_END
