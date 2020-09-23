//
//  BlockChainMaker.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/23.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "BlockChainMaker.h"

@implementation BlockChainMaker

- (MakerBlock)add {
    return ^BlockChainMaker * (CGFloat num) {
        self->_result += num;
        return  self;
    };
}

@end
