//
//  BlockChainMaker.h
//  JSONToModelDemo
//
//  Created by lj on 2020/9/23.
//  Copyright © 2020 Clare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BlockChainMaker;

typedef BlockChainMaker *_Nonnull(^MakerBlock)(CGFloat num);

@interface BlockChainMaker : NSObject

@property (nonatomic, assign) CGFloat result;

- (MakerBlock)add;

@end

NS_ASSUME_NONNULL_END
