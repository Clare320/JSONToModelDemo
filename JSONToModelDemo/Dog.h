//
//  Dog.h
//  JSONToModelDemo
//
//  Created by lj on 2020/9/17.
//  Copyright © 2020 Clare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject {
    NSString *_nickname;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger age;
@property (nonatomic) NSInteger sex;

@property (nonatomic, readonly) float price;

@end

NS_ASSUME_NONNULL_END

