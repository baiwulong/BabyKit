//
//  NSObject+BabyKit.m
//  BabyKit
//
//  Created by li hua on 2016/6/20.
//

#import "NSObject+BabyKit.h"
#import <objc/runtime.h>





/**
 --------------------------------------------------------------
 `NSObject (Get)`获取非空字符串，或者字典数组json转换等处理
 --------------------------------------------------------------
 */

#pragma mark - NSObject Category - Getter

@implementation NSObject (Get)

/// 获取字符串类型
-(NSString *)getString{
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    }else if ([self isKindOfClass:[NSNumber class]]){
        NSNumber *number = (NSNumber *)self;
        return number.stringValue;
    }
    return @"";
}

/// 转json字符串
-(NSString *)getJson{
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    NSString *json     = @"";
    NSError  *error    = nil;
    NSData   *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];
    if (!error) {
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return json;
}

///获取非nil数组
- (NSArray *)getArray{
    if ([self isKindOfClass:[NSNull class]]) {
        return [NSArray new];
    }else if ([self isKindOfClass:[NSString class]]){ //json转数组
        NSString *json = (NSString *)self;
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        id array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if(error) {
            NSLog(@"json解析失败：%@，\n返回空数组:[NSArray new]\n",error);
            return  [NSArray new];
        }
        if ([array isKindOfClass:[NSArray class]]) {
            NSLog(@"json转换-》array数组类型,返回对应的数组");
            return array;
        }else{
            NSLog(@"json转换-》dictionary字典类型,返回空数组:[NSArray new]");
            return [NSArray new];
        }
        
    }else if([self isKindOfClass:[NSArray class]]){
        return (NSArray *)self;
    }
    return [NSArray new];
}

///获取非nil字典
- (NSDictionary *)getDictionary{
    if ([self isKindOfClass:[NSNull class]]) {
        return [NSDictionary new];
    }else if ([self isKindOfClass:[NSString class]]){ //json转数组
        NSString *json = (NSString *)self;
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        id dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if(error) {
            NSLog(@"json解析失败：%@，\n返回空数组:[NSDictionary new]\n",error);
            return [NSDictionary new];
        }
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSLog(@"json转换-》NSDictionary字典类型,返回对应的数组");
            return dict;
        }else{
            NSLog(@"json转换-》数组类型,返回空字典:[NSDictionary new]");
            return [NSDictionary new];
        }
    }else if([self isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)self;
        NSArray *keyArr = [dict allKeys];
        NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
        for (int i = 0; i < keyArr.count; i ++){
            id obj = [dict objectForKey:keyArr[i]];
            obj = [self changeType:obj];
            [resDic setObject:obj forKey:keyArr[i]];
        }
        return resDic;
    }
    return [NSDictionary new];
}

//类型判断与转换
-(id)changeType:(id)myObj{
    if ([myObj isKindOfClass:[NSDictionary class]]){ //递归
        return [myObj dictionary];
    }else if([myObj isKindOfClass:[NSArray class]]){
        return [self toNotAullArr:myObj];
    }else if([myObj isKindOfClass:[NSString class]]){
        return myObj;
    }else if([myObj isKindOfClass:[NSNull class]]){
        return @"";
    }else{
        return myObj;
    }
}

//将NSArray中的Null类型的项目转化成@""
-(NSArray *)toNotAullArr:(NSArray *)myArr{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++){
        id obj = myArr[i];
        obj = [self changeType:obj];
        [resArr addObject:obj];
    }
    return resArr;
}

@end






/**
 --------------------------------------------------------------
 `NSObject (Model)`用于运行时动态获取当前类的属性列表、方法列表、成员变量列表、协议列表
 --------------------------------------------------------------
 */
#pragma mark - NSObject Category - dictionary to Model

@implementation NSObject (Model)

+ (NSArray *)modelWithDictArray:(NSArray<NSDictionary *> *)array{
    if (array.count == 0){
        return nil;
    }
    // 判断是否是字典数组
    NSAssert([array[0] isKindOfClass:[NSDictionary class]], @"必须传入字典数组");
    // 获取属性列表数组
    NSArray *propertyList = [self modelPropertysList];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array){
        // 创建模型
        id model = [self new];
        // 遍历数组
        for (NSString *key in dict){
            // 判断属性列表数组中是否包含当前key 如果有, 意味着属性存在
            if ([propertyList containsObject:key]) {
                // 字典转模型
                [model setValue:dict[key] forKey:key];
            }
        }
        // 添加到可变数组中
        [arrayM addObject:model];
    }
    return arrayM.copy;
}

///获取本类所有 ‘属性‘ 的数组
/** 程序运行的时候动态的获取当前类的属性列表
 *  程序运行的时候,类的属性不会变化
 */
+ (NSArray *)modelPropertysList{
    NSArray *result = objc_getAssociatedObject(self, @selector(modelPropertysList));
    if (result != nil){
        return result;
    }
    NSMutableArray *arrayM = [NSMutableArray array];
    // 获取当前类的属性数组
    // count -> 属性的数量
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        // 根据下标获取属性
        objc_property_t property = list[i];
        // 获取属性的名字
        const char *cName = property_getName(property);
        // 转换成OC字符串
        NSString *name = [NSString stringWithUTF8String:cName];
        [arrayM addObject:name];
    }
    /*! ⚠️注意： 一定要释放数组 class_copyPropertyList底层为C语言，所以我们一定要记得释放properties */
    free(list);
    // ---保存属性数组对象---
    objc_setAssociatedObject(self, @selector(modelPropertysList), arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return objc_getAssociatedObject(self, @selector(modelPropertysList));
}

///获取本类所有 ‘方法‘ 的数组
+ (NSArray *)modelMethodList{
    // 1. 使用运行时动态添加属性
    NSArray *methodsList = objc_getAssociatedObject(self, @selector(modelMethodList));
    // 2. 如果数组中直接返回方法数组
    if (methodsList != nil){
        return methodsList;
    }
    // 3. 获取当前类的方法数组
    unsigned int count = 0;
    Method *list = class_copyMethodList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++){
        // 根据下标获取方法
        Method method = list[i];
        SEL methodName = method_getName(method);
        NSString *methodName_OC = NSStringFromSelector(methodName);
        
        const char *name_s =sel_getName(method_getName(method));
        int arguments = method_getNumberOfArguments(method);
        const char* encoding =method_getTypeEncoding(method);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
        [arrayM addObject:methodName_OC];
    }
    
    // 4. 释放数组
    free(list);
    // 5. 保存方法的数组对象
    objc_setAssociatedObject(self, @selector(modelMethodList), arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return objc_getAssociatedObject(self, @selector(modelMethodList));
}


/// 获取本类所有 ‘成员变量‘ 的数组 <用来调试>
+ (NSArray *)modelIvarList{
    // 1. 查询根据key 保存的成员变量数组
    NSArray *ivarList = objc_getAssociatedObject(self, @selector(modelIvarList));
    // 2. 判断数组中是否有值, 如果有直接返回
    if (ivarList != nil){
        return ivarList;
    }
    // 3. 如果数组中没有, 则根据当前类,获取当前类的所有 ‘成员变量‘
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    // 4. 遍历 成员变量 数组, 获取成员变量的名
    NSMutableArray *arrayM = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // - C语言的字符串都是 ‘char *‘ 类型的
        const char *ivarName_C = ivar_getName(ivar);
        
        // - 将 C语言的字符串 转换成 OC字符串
        NSString *ivarName_OC = [NSString stringWithUTF8String:ivarName_C];
        // - 将本类 ‘成员变量名‘ 添加到数组
        [arrayM addObject:ivarName_OC];
    }
    // 5. 释放ivars
    free(ivars);
    // 6. 根据key 动态获取保存在关联对象中的数组
    objc_setAssociatedObject(self, @selector(modelIvarList), arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return objc_getAssociatedObject(self, @selector(modelIvarList));
}

/// 获取本类所有 ‘协议‘ 的数组
+ (NSArray *)modelProtocolList {
    NSArray *protocolList = objc_getAssociatedObject(self, @selector(modelProtocolList));
    if (protocolList != nil){
        return protocolList;
    }
    unsigned int count = 0;
    Protocol * __unsafe_unretained *protocolLists = class_copyProtocolList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++) {
        // 获取 协议名
        Protocol *protocol = protocolLists[i];
        const char *protocolName_C = protocol_getName(protocol);
        NSString *protocolName_OC = [NSString stringWithUTF8String:protocolName_C];
        // 将 协议名 添加到数组
        [arrayM addObject:protocolName_OC];
    }
    // 释放数组
    free(protocolLists);
    // 将保存 协议的数组动态添加到 关联对象
    objc_setAssociatedObject(self, @selector(modelProtocolList), arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return objc_getAssociatedObject(self, @selector(modelProtocolList));
}



@end






/**
 --------------------------------------------------------------
 `NSString (StringSize)`计算获取文本高度
 --------------------------------------------------------------
 */

#pragma mark - NSString Category
@implementation NSString (StringSize)

-(CGSize)stringMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *tdic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
        size = [self boundingRectWithSize:size
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:tdic
                                    context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:[UIFont systemFontOfSize:fontSize]
                  constrainedToSize:size
                      lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    return CGSizeMake(size.width, size.height+10);
}


@end


/**
 --------------------------------------------------------------
 `UIGestureRecognizer`手势分类
 --------------------------------------------------------------
 */

#pragma mark - UIGestureRecognizer Category

@interface UIGestureRecognizer (HandleAction)

@property (nonatomic, assign) BOOL shouldHandleAction;

- (void)handleAction:(UIGestureRecognizer *)recognizer;

@end

/**
 --------------------------------------------------------------
 `UIGestureRecognizer`手势分类
 --------------------------------------------------------------
 */
@implementation UIGestureRecognizer (Gesture)

+ (id)gestureRecognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    NSTimeInterval delay = 0.1;
    return [[[self class] alloc] initWithHandler:block delay:delay];
}


- (id)initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay{
    self = [self initWithTarget:self action:@selector(handleAction:)];
    if (!self) return nil;
    self.gestureHandler = block;
    self.gestureDelay = delay;
    return self;
}

- (void)gestureCancel{
    self.shouldHandleAction = NO;
}

- (void)handleAction:(UIGestureRecognizer *)recognizer{
    //获取手势的block属性
    void (^handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) = recognizer.gestureHandler;
    if (!handler){
        return;
    }
    //获取延时时间
    NSTimeInterval delay = self.gestureDelay;
    CGPoint location = [self locationInView:self.view];
    //定义block控制handler的执行
    void (^block)(void) = ^{
        if (!self.shouldHandleAction){
            return;
        }
        handler(self, self.state, location);
    };
    
    self.shouldHandleAction = YES;
    
    if (!delay) {
        block();
        return;
    }
    //延时执行block
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

#pragma mark - Setter And Getter (UIGestureRecognizer)

- (void)setGestureDelay:(NSTimeInterval)gestureDelay{
    NSNumber *delayValue = gestureDelay ? @(gestureDelay) : @(0.05);
    objc_setAssociatedObject(self, @selector(gestureDelay), delayValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)gestureDelay{
    return [objc_getAssociatedObject(self, @selector(gestureDelay)) doubleValue];
}

-(void)setGestureHandler:(void (^)(UIGestureRecognizer *, UIGestureRecognizerState, CGPoint))gestureHandler{
    objc_setAssociatedObject(self, @selector(gestureHandler), gestureHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))gestureHandler{
    return objc_getAssociatedObject(self, @selector(gestureHandler));
}

-(void)setShouldHandleAction:(BOOL)shouldHandleAction{
    objc_setAssociatedObject(self, @selector(shouldHandleAction), @(shouldHandleAction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)shouldHandleAction{
    return [objc_getAssociatedObject(self, @selector(shouldHandleAction)) boolValue];
}

@end






/**
 --------------------------------------------------------------
 `UIView (View)`UIView分类
 --------------------------------------------------------------
 */

#pragma mark - UIView (View)

@implementation UIView (View)

#pragma mark - Setter And Getter (UIView)

- (void)setViewX:(CGFloat)viewX{
    CGRect frame = self.frame;
    frame.origin.x = viewX;
    self.frame = frame;
}

- (CGFloat)viewX{
    return self.frame.origin.x;
}

- (void)setViewY:(CGFloat)viewY{
    CGRect frame = self.frame;
    frame.origin.y = viewY;
    self.frame = frame;
}

- (CGFloat)viewY{
    return self.frame.origin.y;
}

-(void)setViewWidth:(CGFloat)viewWidth {
    CGRect frame = self.frame;
    frame.size.width = viewWidth;
    self.frame = frame;
}

- (CGFloat)viewWidth{
    return self.frame.size.width;
}

- (void)setViewHeight:(CGFloat)viewHeight{
    CGRect frame = self.frame;
    frame.size.height = viewHeight;
    self.frame = frame;
}

- (CGFloat)viewHeight{
    return self.frame.size.height;
}

- (void)setViewSize:(CGSize)viewSize {
    CGRect frame = self.frame;
    frame.size = viewSize;
    self.frame = frame;
}

- (CGSize)viewSize{
    return self.frame.size;
}

- (void)setViewOrigin:(CGPoint)viewOrigin {
    CGRect frame = self.frame;
    frame.origin = viewOrigin;
    self.frame = frame;
}

- (CGPoint)viewOrigin{
    return self.frame.origin;
}

- (void)setViewCenterX:(CGFloat)viewCenterX{
    CGPoint center = self.center;
    center.x = viewCenterX;
    self.center = center;
}

- (CGFloat)viewCenterX{
    return self.center.x;
}

-(void)setViewCenterY:(CGFloat)viewCenterY{
    CGPoint center = self.center;
    center.y = viewCenterY;
    self.center = center;
}

- (CGFloat)viewCenterY{
    return self.center.y;
}

/// 获取view的控制器
-(UIViewController *)viewContrller{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end






/**
 --------------------------------------------------------------
 `UIView (View)`UIView分类
 --------------------------------------------------------------
 */

#pragma mark - UIView (ActionBlock)

@implementation UIView (ActionBlock)

/// 添加单击手势
- (void)actionTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    if (!block) return;
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer gestureRecognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if (state == UIGestureRecognizerStateRecognized){
            block(sender,state,location);
        }
    }];
    gesture.numberOfTouchesRequired = 1;
    gesture.numberOfTapsRequired = 1;
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]){
            return;
        }
        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == 1);
        BOOL rightTaps = (tap.numberOfTapsRequired == 1);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];
    [self addGestureRecognizer:gesture];
}

/// 添加双击手势
- (void)actionDoubleTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    if (!block) return;
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer gestureRecognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if (state == UIGestureRecognizerStateRecognized){
            block(sender,state,location);
        }
    }];
    gesture.numberOfTouchesRequired = 2;
    gesture.numberOfTapsRequired = 1;
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]){
            return;
        }
        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == 2);
        BOOL rightTaps = (tap.numberOfTapsRequired == 1);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];
    [self addGestureRecognizer:gesture];
}

/// 添加滑动手势
-(void)actionSwipeDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    if (!block) return;
    UISwipeGestureRecognizer *swipe = [UISwipeGestureRecognizer gestureRecognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        block((UISwipeGestureRecognizer *)sender,state,location);
    }];
    swipe.direction = direction;
    [self addGestureRecognizer:swipe];
}

/// 遍历子视图
- (void)actionSubviewBlock:(void (^)(UIView *subview))block{
    NSParameterAssert(block != nil);
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        block(subview);
    }];
}


@end



