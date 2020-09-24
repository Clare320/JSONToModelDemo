//
//  Car.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/24.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "Car.h"
#import <objc/runtime.h>
#import <objc/message.h>

#import "Person.h"

typedef struct {
    NSString *name;
    NSInteger age;
} student;

@implementation Car

// 用来处理即使类实现了runtoDestination:成员方法，执行这个方法时同样进行消息转发（手动触发）
+ (void)load {
    SEL selector = @selector(runToDestination:);
    Method targetMethod = class_getInstanceMethod(self.class, @selector(selector));
    const char *typeEncoding = method_getTypeEncoding(targetMethod);
    IMP targetMethodIMP = _objc_msgForward;
    class_replaceMethod(self.class, selector, targetMethodIMP, typeEncoding);
    
//    const char *encoding1 = method_getTypeEncoding(class_getInstanceMethod(self.class, @selector(testStruct:age:)));
//    const char *encoding2 = method_getTypeEncoding(class_getInstanceMethod(self.class, @selector(testParamStr:)));
}
/**
 方法对应的转发实现：
 _objc_msgForward 其它返回值使用
 _objc_msgForward_stret 返回值为struct类型使用
 */

- (void)runToDestination:(NSString *)place {
    NSLog(@"car run to %@!", place);
}

- (student)testStruct:(NSString *)name age:(NSInteger)age {
    student stu = { name, age };
    return stu;
}

- (NSString *)testParamStr: (NSString *)dest {
    return dest;
}

    
// 当Selector没有找到对应的method时，首先调用这个方法，这里可以动态添加方法实现。 未处理这个SEL时，执行forwardingTargetForSelector
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(runToDestination:)) {
////        class_addMethod(self, sel, (IMP)dynamicMethodIMPRunToDestination, "v@:@");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

// 返回一个能执行aSelector的对象
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(runToDestination:)) {
//        return [[Person alloc] init];
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(runToDestination:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// 上面两种情况都未处理的话就执行-forwardInvocation:进行消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.selector == @selector(runToDestination:)) {
        void *argBuf = NULL;
        NSUInteger numberOfArguments = anInvocation.methodSignature.numberOfArguments;
        for (NSUInteger idx = 2; idx < numberOfArguments; idx++) {
            const char *type = [anInvocation.methodSignature getArgumentTypeAtIndex:idx];
            NSUInteger argSize;
            NSGetSizeAndAlignment(type, &argSize, NULL);
            if (!(argBuf = reallocf(argBuf, argSize))) {
                NSLog(@"Failed to allocate memory for block invocation.");
                return;
            }
            id value = nil;
            [anInvocation getArgument:&value atIndex:idx];
            // 现在argBuf中保存这第index参数的值，你可以使用这些值进行其他处理，例如为block中各参数赋值，并调用。
            if (type[0] == '@') {
//                id *value = (__bridge id)argBuf;
//                NSLog(@"value--->%@", (__bridge id)argBuf);
                // void * 与 OC类型的转换没解决 __bride type
                NSLog(@"--->%@", value);
            }
            NSLog(@"index--->%ld", idx);
        }
    }
}

static void dynamicMethodIMPRunToDestination(id self, SEL _cmd, id place) {
    NSLog(@"dynamic run to %@", place);
}

@end
