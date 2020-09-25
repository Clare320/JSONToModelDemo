//
//  UIViewController+Tracking.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/25.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

+ (void)load {
    [super load];
    
    SEL originSel = @selector(viewWillAppear:);
    SEL newSel = @selector(llj_viewWillAppear:);
    
    
    IMP originIMP = class_getMethodImplementation([self class], originSel);
    IMP newIMP = class_getMethodImplementation([self class], newSel);
    
    Method originMethod = class_getInstanceMethod([self class], originSel);
    Method newMethod = class_getInstanceMethod([self class], newSel);
    
    BOOL isAdd = class_addMethod([self class], originSel, newIMP, method_getTypeEncoding(originMethod));
    if (isAdd) {
        class_replaceMethod([self class], newSel, originIMP, method_getTypeEncoding(newMethod));
    } else {
        method_exchangeImplementations(originMethod, newMethod);
    }
    
}

- (void)llj_viewWillAppear:(BOOL)animated {
    NSLog(@"llj_viewWillAppear");
    
    [self llj_viewWillAppear:animated];
}

@end

/**
 另外一种方式 用全局的IMP指针函数去接一个方法的原实现，重新定义一个静态函数方法，实现逻辑并且实现原实现，然后重新setImplementtations。静态函数方法要怎么设？
 */
