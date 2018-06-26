//
//  BabyFileHelper.h
//  BabyFileHelper
//

#import <Foundation/Foundation.h>

/**
 --------------------------------------------------------------
 `BabyFileHelper`文件路径与操作管理工具类
 --------------------------------------------------------------
 */
@interface BabyFileHelper : NSObject

/**
 * @brief 获取程序的缓存大小
 */
+(CGFloat)fileCacheSize;

/**
 * @brief 计算目录大小
 */
+ (CGFloat)folderSizeAtPath:(NSString *)path;

/**
 计算路径下的文件内存大小
 
 @param filepath 文件路径
 @return 文件内存大小
 */
+ (int64_t)fileManagerGetSizeWithFilePath:(NSString *)filepath;

/// 清除缓存
+(void)fileClearCache;

#pragma mark - 系统目录

/**
 * @brief 获取程序的根目录（home）目录
 */
+(NSString *)filePathHomePath;

/**
 * @brief 获取程序的根目录（Documents）目录
 */
+(NSString *)filePathDocumentsPath;


/**
 * @brief 获取程序的根目录（Library）目录
 */
+(NSString *)filePathLibraryPath;

/**
 * @brief 获取程序的根目录（Library中的cache）目录
 */
+(NSString *)filePathLibraryCachePath;

/**
 * @brief 获取程序的临时（temp）目录
 */
+(NSString *)filePathTempPath;


#pragma mark - 文件查看

/** @name 其他 */
/**
 判断该路径是否有文件
 @param path 文件路径
 @return BOOL 是否有文件存在
 */
+ (BOOL)fileExistsAtPath:(NSString *)path;

/**
 判断该documents中是否有文件
 @param fileName 文件名称
 @return BOOL 是否有文件存在
 */
+ (BOOL)fileExistsAtDocumentPathWithFileName:(NSString *)fileName;

/**
 * @brief 创建路径
 */
+ (BOOL)fileCreatePathIfNecessary:(NSString*)path;


/**
 * @brief 获取（创建）程序的根目录（Documents）目录下的/name
 */
+ (NSString*)fileCreateDocumentPathWithName:(NSString*)name;

/**
 * @brief 获取程序的根目录（Library）目录下的/name
 */
+ (NSString*)fileCreateCachePathWithName:(NSString*)name;

#pragma mark - 读取

/** @name 读取 */
/**
 加载文件
 @param path 文件路径
 @return NSObject 文件中的数据
 */
+ (NSObject *)fileLoadDataFromPath:(NSString *)path ;

/**
 异步加载文件
 @param path 文件路径
 @param callback 加载完成后回调
 */
+ (BOOL)fileAsyncLoadDataFromPath:(NSString *)path callback:(void(^)(NSObject *data))callback;

#pragma mark - 写入

/** @name 写入 */
/**
 存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 */
+ (BOOL)fileSaveData:(NSObject *)data withPath:(NSString *)path;

/**
 异步存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 @param callback 存储完成后回调
 */
+ (void)fileAsyncSaveData:(NSObject *)data withPath:(NSString *)path callback:(void(^)(BOOL succeed))callback;


/**
 存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 @param fileName 文件名
 */
+ (BOOL)fileSaveData:(NSObject *)data withPath:(NSString *)path fileName:(NSString *)fileName;


/**
 异步存储数据到本地
 @param path 文件路径
 @param data 需要存储的数据
 @param fileName 文件名
 @param callback 完成后的回调
 */
+ (void)fileAsyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             fileName:(NSString *)fileName
             callback:(void(^)(BOOL succeed))callback;


#pragma mark - 删除


/** @name 删除 */
/**
 删除文件
 @param path 文件路径
 @return 是否删除成功
 */
+ (BOOL)fileRemoveFileAtPath:(NSString *)path;

/**
 删除文件目录和目录下的所有文件
 @param path 文件目录路径
 @param condition 文件删除条件判断
 */
+ (void)fileRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;

/**
 删除文件目录和目录下的所有文件
 @param path 文件目录路径
 @param condition 文件删除条件判断
 */
+ (void)fileAsyncRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;






@end
