//
//  NSObject+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2017/6/20.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


/**
 --------------------------------------------------------------
 `NSObject (Getter)`获取非空字符串，或者字典数组json转换等处理
 --------------------------------------------------------------
 */

#pragma mark - NSObject Category - Getter

@interface NSObject (GetInfo)

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



NS_ASSUME_NONNULL_END






