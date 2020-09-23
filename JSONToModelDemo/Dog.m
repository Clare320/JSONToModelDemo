//
//  Dog.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/17.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "Dog.h"

/**
 @dynamic property; 
 @synthesize property;
 */

@interface Dog () {
    NSInteger _sex;
    NSString *_city;
}

@property (nonatomic, strong) NSString *address;

@end

@implementation Dog
@dynamic sex;


- (void)setSex:(NSInteger)sex {
    _sex = sex;
}

- (NSInteger)sex {
    return  _sex;
}

- (void)run {
    NSLog(@"to %@ run run run!", self.address);
}

//+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
//    return  @{
//        @"address": @"street"
//    };
//}

@end
