//
//  NSObject+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2016/6/20.
//

#import <Foundation/Foundation.h>





/**
 --------------------------------------------------------------
 `NSObject (Getter)`获取非空字符串，或者字典数组json转换等处理
 --------------------------------------------------------------
 */

#pragma mark - NSObject Category - Getter

@interface NSObject (Get)

/**
 * 转换为非nil字符串，处理string/NSNumber，其他的都默认返回@"",(常用于处理服务器返回的Null/NSNumber/string等数据);
 */
@property(nonatomic, copy , readonly) NSString * getString;

/**
 * 转换为非nil数组，处理json/array，其他的都默认返回[NSArray new],(常用于处理服务器返回的Null/json/array数据);
 */
@property(nonatomic, copy , readonly) NSArray * getArray;

/**
 * 转换为非nil字典，处理json/dictionary，其他的都默认返回[NSDictionary new],(常用于处理服务器返回的Null,json,dictionary数据);
 */
@property(nonatomic, copy , readonly) NSDictionary * getDictionary;

/**
 * 转换为非空json字符串(常用于string、dictionary、array等转换json字符串上传给服务器);
 */
@property(nonatomic, copy , readonly) NSString * getJson;

@end





/**
 --------------------------------------------------------------
 `NSObject (DictionaryToModel)`用于运行时动态获取当前类的属性列表、方法列表、成员变量列表、协议列表
 --------------------------------------------------------------
 */
#pragma mark - NSObject Category - dictionary to Model

@interface NSObject (Model)

/**
 *  将 ‘字典数组‘ 转换成当前模型的对象数组
 *
 *  @param array 字典数组
 *
 *  @return 返回模型对象的数组
 */
+ (NSArray *)modelWithDictArray:(NSArray <NSDictionary *> *)array;

/**
 *  返回当前类的所有属性列表
 *
 *  @return 属性名称
 */
+ (NSArray *)modelPropertysList;

/**
 *  返回当前类的所有成员变量数组
 *
 *  @return 当前类的所有成员变量！
 *
 *  Tips：用于调试, 可以尝试查看所有不开源的类的ivar
 */
+ (NSArray *)modelIvarList;

/**
 *  返回当前类的所有方法
 *
 *  @return 当前类的所有成员变量！
 */
+ (NSArray *)modelMethodList;

/**
 *  返回当前类的所有协议
 *
 *  @return 当前类的所有协议！
 */
+ (NSArray *)modelProtocolList;

@end





/**
 --------------------------------------------------------------
 `NSString (BoundSize)`计算获取文本高度
 --------------------------------------------------------------
 */

#pragma mark - NSString Category

@interface NSString (StringSize)

/**
 * 计算文本高度，width：最大宽度（根据这个限制来计算高度）
 */
-(CGSize)stringMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize;

@end




/**
 --------------------------------------------------------------
 `UIGestureRecognizer (TMKit)`手势分类
 --------------------------------------------------------------
 */

#pragma mark - UIGestureRecognizer Category

@interface UIGestureRecognizer (Gesture)

/// 手势处理block属性
@property (nonatomic, copy) void (^gestureHandler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location);
/// 手势延时间隔
@property (nonatomic,assign) NSTimeInterval gestureDelay;

/// 手势创建
+ (id)gestureRecognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;
/// 取消手势
- (void)gestureCancel;

@end






/**
 --------------------------------------------------------------
 `UIView (View)`获取view的frame相关数值，获取视图控制器等
 --------------------------------------------------------------
 */

#pragma mark - UIView Category

@interface UIView (View)

///位置:x
@property (nonatomic,assign) CGFloat viewX;

/// 位置:y
@property (nonatomic,assign) CGFloat viewY;

/// 中心点:x
@property (nonatomic,assign) CGFloat viewCenterX;

///中心点:y
@property (nonatomic,assign) CGFloat viewCenterY;

/// 宽:width
@property (nonatomic,assign) CGFloat viewWidth;

/// 高:height
@property (nonatomic,assign) CGFloat viewHeight;

/// 大小:CGSize结构
@property (nonatomic,assign) CGSize viewSize;

/// 位置:CGPoint位置
@property (nonatomic,assign) CGPoint viewOrigin;

/// 递归获取视图控制器
@property (nonatomic,strong,readonly) UIViewController *viewContrller;


@end





/**
 --------------------------------------------------------------
 `UIView (ActionBlock)`view手势事件，遍历子视图等
 --------------------------------------------------------------
 */

#pragma mark - UIView Category (ActionBlock)

@interface UIView (ActionBlock)

/// 单击执行代码块
- (void)actionTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/// 两个手指点击执行代码块
- (void)actionDoubleTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/// 滑动手势
-(void)actionSwipeDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/// 遍历所有的子视图,并为每个子视图执行block代码
- (void)actionSubviewBlock:(void (^)(UIView *subview))block;

@end
