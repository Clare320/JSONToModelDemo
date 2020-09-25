//
//  Dog+Wrestle.h
//  JSONToModelDemo
//
//  Created by lj on 2020/9/17.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dog (Wrestle)

@property (nonatomic, copy) NSString *ownerName;

- (void)warry;

@end

NS_ASSUME_NONNULL_END
