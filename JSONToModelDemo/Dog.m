//
//  Dog.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/17.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "Dog.h"

@interface Dog ()

@property (nonatomic, strong) NSString *address;

@end

@implementation Dog

- (void)run {
    NSLog(@"to %@ run run run!", self.address);
}

//+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
//    return  @{
//        @"address": @"street"
//    };
//}

@end
