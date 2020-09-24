//
//  ViewController.m
//  JSONToModelDemo
//
//  Created by lj on 2020/9/17.
//  Copyright © 2020 Clare. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import <MessageThrottle/MessageThrottle.h>

#import "AFRespModel.h"
#import "Dog.h"
#import "BlockChainMaker.h"
#import "Car.h"
#import "MyClass.h"
//#import "MySubClass.h"

typedef void(^testCheckBlock)(void);
NSInteger totalScore = 1001;

static NSInteger totalMount = 1;

@interface ViewController ()

@property (nonatomic, strong) UIButton *reqButton;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UIPickerView *namePicker;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) Dog *redDog;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"view did load");
    
    [self.view addSubview:self.reqButton];
    [self.view addSubview:self.nameField];
    
    MTRule *rule = [[MTRule alloc] initWithTarget:self selector:@selector(requestAF) durationThreshold:1];
    [rule apply];
    
    [self testRuntime];
//    [self testMethodForward];
//    [self testBlock];
//    [self testShaddowAndDeepClone];
//    [self testMasonry];
//    [self testYYModel];
//    [self testKVCAndKVO];

}

//MARK: - life cycle

// 苹果推荐添加、更新约束的地方，
- (void)updateViewConstraints {
    NSLog(@"update View Constraints!");
    
    [self.nameField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(130);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.height.equalTo(@35);
    }];
    
    [super updateViewConstraints];
}

- (void)dealloc {
    NSLog(@"redDog: %@", self.redDog);
    [self.redDog removeObserver:self forKeyPath:@"name"];
}


//MARK: - 处理

- (void)testRuntime {
    /*
    NSLog(@"NSObject class is %p", [NSObject class]);
    NSLog(@"NSObject is Meta Class %d, super is %d", class_isMetaClass([NSObject class]), class_isMetaClass(class_getSuperclass(class_getSuperclass([NSObject class]))));
    NSLog(@"NSObject isa %p", objc_getClass((__bridge void *)[NSObject class]));
    NSLog(@"NSObject Super class isa %p", class_getSuperclass([NSObject class]));
    NSLog(@"Dog isa %p", objc_getClass((__bridge void *)[Dog class]));
    NSLog(@"%ld", class_getInstanceSize([Dog class]));
    NSLog(@"NSInteger size is %ld", sizeof(NSInteger));
    */
    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    
    //类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"\r");
    
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"\r");
    
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"_string name is %s", ivar_getName(string));
    }
    NSLog(@"\r");
    
    // 属性
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name is %s", property_getName(property));
    }
    free(properties);
    NSLog(@"\r");
    
    // 方法 成员方法放在自己的object_method_list，类方法放在meta class - Class isa的object_method_list
    // objc_getMetaClass(class_getName(cls)) 获取meta class
    // 这里返回的是指针 数组
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", sel_getName(method_getName(method)));
    }
    free(methods);
    NSLog(@"\r");
    
    /**
     /// An opaque type that represents a method in a class definition.
     typedef struct objc_method *Method;

     /// An opaque type that represents an instance variable.
        指向objc_ivar结构体的指针
     typedef struct objc_ivar *Ivar;

     /// An opaque type that represents a category.
     typedef struct objc_category *Category;

     /// An opaque type that represents an Objective-C declared property.
     typedef struct objc_property *objc_property_t;
     */
    
    
    int a = 10;
    int *b = &a;
    typedef int * B;
    int **d = &b;
    B *c = &b;
    NSLog(@"d -->%d", *(*d));
    NSLog(@"c -->%d", *(*c));
}

- (void)testMethodForward {
    Car *car = [[Car alloc] init];
    [car runToDestination:@"CDC"];
}

- (void)testBlock {
    NSString *nick = @"cc";
    void (^block1)(NSInteger age) = ^ (NSInteger age) {
        NSLog(@"Hello world %ld", age);
    };
    
    __block NSInteger val = 10;
    NSLog(@"val-->%p", &val);
    NSMutableString *name = [NSMutableString stringWithString:@"kunm"];
    void (^block)(void) = ^ {
        val = 13;
        NSLog(@"block val-->%p", &val);
        totalScore = 1003;
        totalMount = 3;
        [name appendString:@" mnu"];
        NSLog(@"block value: %ld, global value: %ld, totalMount: %ld, name: %@", val, totalScore, totalMount, name);
    };
    val = 15;
    totalScore = 1000;
    block();
    
    BlockChainMaker *maker = [[BlockChainMaker alloc] init];
    maker.add(20).add(30);
    
    NSLog(@"result: %.2f", maker.result);
    
//    _NSConcreteStackBlock
//    _NSConcreteGlobalBlock
}

- (void)testShaddowAndDeepClone {
    NSString *first = @"1";
    NSMutableString *second = [NSMutableString stringWithString:@"2"];
    
    NSArray *array = @[first, second];
    NSArray *copyArray = [array copy];
    NSMutableArray *mutableArray = [array mutableCopy];

    NSLog(@"array: %p, copyArray: %p, mutableArray: %p", &array, &copyArray, &mutableArray);
}

- (void)testMasonry {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = self.view;
        
        make.top.equalTo(superView.mas_safeAreaLayoutGuideTop).with.offset(200);
        make.left.equalTo(superView.mas_safeAreaLayoutGuideLeft).with.offset(10);
        make.right.equalTo(superView.mas_safeAreaLayoutGuideRight).with.offset(-10);
        make.height.mas_equalTo(@(CGSizeMake(100, 100)));
    }];
}

- (void)testYYModel {
    NSString *target = @"{\"address\":\"PuDong\", \"sex\":\"0\"}";
    Dog *jsonDog = [Dog yy_modelWithJSON:target];
    NSLog(@"json--->%@", jsonDog);
    
    BOOL isValid = [NSJSONSerialization isValidJSONObject:@{ @"name": @"LBL" }];
    NSLog(@"isValid-->%d", isValid);
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[target dataUsingEncoding:NSUTF8StringEncoding ] options:NSJSONReadingMutableLeaves error:NULL];
    Dog *dog = [Dog yy_modelWithJSON:target];
    NSLog(@"dog:%@, dict:%@", dog, dict);
    // 匿名类别中属性可以被解析赋值，不能被调用
}

- (void)testKVCAndKVO {
    Dog *dog = [[Dog alloc] init];
    self.redDog = dog;
    
    [dog setValue:@"Aluka" forKey:@"name"];
    [dog setValue:@(3) forKey:@"age"];
    [dog setValue:@(0) forKey:@"sex"];
    [dog setValue:@"Xcv_kjhg" forKey:@"address"];
    NSLog(@"before kvc price: %f", dog.price);
    [dog setValue:@(100.0) forKey:@"price"];
    [dog setValue:@"CSC" forKey:@"city"];
    NSLog(@"kvc-name: %@, age: %ld, sex: %@, address: %@, price: %f, city: %@", dog.name, dog.age, dog.sex == 0 ? @"male" : @"female", [dog valueForKey:@"address"], dog.price, [dog valueForKey:@"city"]);
    
    [dog addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}


//MARK: - Binding UI

- (IBAction)changeDogName:(id)sender {
    self.redDog.name = [self.redDog.name isEqualToString:@"Aluka"] ? @"Sbada" : @"Aluka";
}

//MARK: - Event

- (void)requestAF {
    NSLog(@"---> call requestAF");
    [self.dataTask resume];
}

- (NSURLSessionDataTask *)dataTaskWithURL: (NSString *)url responseModel: (Class<YYModel>)cls completionHandler: (nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSObject *object = [[cls class] yy_modelWithJSON:responseObject];
        completionHandler(response, object, error);
    }];
    return  dataTask;
}

- (NSURLSessionDataTask *)originalDataTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://httpbin.org/get"]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"response:%@", response);
    }];
    return  dataTask;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[Dog class]]) {
        if ([keyPath isEqualToString:@"name"]) {
            NSString *oldName = change[NSKeyValueChangeOldKey];
            NSString *newName = change[NSKeyValueChangeNewKey];
            NSLog(@"observe new name: %@, old name: %@", newName, oldName);
        }
    }
}


//MARK: - Setter && Getter

- (UIButton *)reqButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 100, 50, 30);
    [button setTitle:@"请求" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(requestAF) forControlEvents:UIControlEventTouchUpInside];
    
    return  button;
}

- (NSURLSessionDataTask *)dataTask {
    return [self dataTaskWithURL:@"http://httpbin.org/get" responseModel:[AFRespModel class] completionHandler:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"responseObject:%@", responseObject);
    }];
}

- (UITextField *)nameField {
    if (!_nameField) {
        UITextField *field = [[UITextField alloc] init];
        field.placeholder = @"test masonry";
        _nameField = field;
    }
    return _nameField;
}

- (UIPickerView *)namePicker {
    if (!_namePicker) {
        UIPickerView *picker = [[UIPickerView alloc] init];
        _namePicker = picker;
    }
    
    return _namePicker;
}

@end


/**
 解决请求与响应不匹配的问题
 防抖 debounce 触发条件后开始计时，一旦又有人触发重新计时，一直到这个计时触发计时条件去执行
 节流 throttle  保证某个时间内只执行一次
 
 网络请求状态跟button的可用性关联在一起。
 
 事件响应传递机制
 */

/**
 移动设备上请求和web请求有什么区别？
 */


/**
 请求该在哪写？
 是写在ViewControll.m还是写在Model里面。在MVVM结构里面放在ViewModel里面？
 */

/**
 
 xcframework是啥？
 */

/**
 KVC KVO
 */
