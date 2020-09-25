//
//  Dog+Wrestle.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/17.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "Dog+Wrestle.h"
#import <objc/runtime.h>

static char ownerNameKey;

@implementation Dog (Wrestle)

//- (void)setOwnerName:(NSString *)ownerName {
//    objc_setAssociatedObject(self, &ownerNameKey, ownerName, OBJC_ASSOCIATION_COPY);
//}
//
//- (NSString *)ownerName {
//    return objc_getAssociatedObject(self, &ownerNameKey);
//}

- (void)setOwnerName:(NSString *)ownerName {
    self.name = ownerName;
}

- (NSString *)ownerName {
    return self.name;
}

- (void)warry {
    NSLog(@"crazy warry!");
}

@end
