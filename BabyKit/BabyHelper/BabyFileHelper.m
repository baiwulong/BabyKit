//
//  BabyFileHelper.m
//  BabyFileHelper
//
//

#import "BabyFileHelper.h"

#include <sys/param.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <dirent.h>

@implementation BabyFileHelper


//获取程序的根目录（home）目录
+(NSString *)filePathHomePath{
    return NSHomeDirectory();
}
//获得document目录
+(NSString *)filePathDocumentsPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
//获得Llibrary目录
+(NSString *)filePathLibraryPath{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}
//获取（Library中的cache）目录
+(NSString *)filePathLibraryCachePath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
//获得temp目录
+(NSString *)filePathTempPath{
    return NSTemporaryDirectory();
}


static dispatch_queue_t _dispathQueue;
+ (dispatch_queue_t)defaultQueue
{
    if (!_dispathQueue) {
        _dispathQueue = dispatch_queue_create("BabyFileHelper", NULL);
    }
    return _dispathQueue;
}
#pragma mark - 读取文件


+ (NSObject *)fileLoadDataFromPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];;
}

+ (BOOL)fileAsyncLoadDataFromPath:(NSString *)path callback:(void(^)(NSObject *data))callback
{
    BOOL fileExist = [self fileExistsAtPath:path];
    dispatch_async([self defaultQueue], ^{
        NSObject *data = [self fileLoadDataFromPath:path];
        callback(data);
    });
    return fileExist;
}

#pragma mark - 存储数据
+ (BOOL)fileSaveData:(NSObject *)data withPath:(NSString *)path
{
    if ([self fileCreatePathIfNecessary:[path stringByDeletingLastPathComponent]])
    {
        return [NSKeyedArchiver archiveRootObject:data toFile:path];
    }
    return NO;
}

+ (void)fileAsyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             callback:(void(^)(BOOL succeed))callback
{
    dispatch_async([self defaultQueue], ^{
        BOOL succeed = [self fileSaveData:data withPath:path];
        callback(succeed);
    });
}

+ (BOOL)fileSaveData:(NSObject *)data
        withPath:(NSString *)path
        fileName:(NSString *)fileName
{
    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
    return [self fileSaveData:data withPath:fullPath];
}

+ (void)fileAsyncSaveData:(NSObject *)data
             withPath:(NSString *)path
             fileName:(NSString *)fileName
             callback:(void(^)(BOOL succeed))callback
{
    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
    [self fileAsyncSaveData:data withPath:fullPath callback:callback];
}

#pragma mark - 删除
+ (BOOL)fileRemoveFileAtPath:(NSString *)path
{
    NSFileManager *BabyFileHelper = [NSFileManager defaultManager];
    NSError *error;
    BOOL succeed = [BabyFileHelper removeItemAtPath:path error:&error];
    return succeed;
}

+ (void)fileRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
{
    NSFileManager *fm = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerate = [fm enumeratorAtPath:path];
	for (NSString *fileName in enumerate)
    {
		NSString *filePath = [path stringByAppendingPathComponent:fileName];
		NSDictionary *fileInfo = [fm attributesOfItemAtPath:filePath error:nil];
        if (condition(fileInfo)) {
            [fm removeItemAtPath:filePath error:nil];
        }
	}
}

+ (void)fileAsyncRemoveFileAtPath:(NSString *)path condition:(BOOL (^)(NSDictionary *fileInfo))condition;
{
    dispatch_async([self defaultQueue], ^{
        [self fileRemoveFileAtPath:path condition:condition];
    });
}

+ (BOOL)fileExistsAtPath:(NSString *)path
{
    NSFileManager *BabyFileHelper = [NSFileManager defaultManager];
    return [BabyFileHelper fileExistsAtPath:path];
}

+ (BOOL)fileExistsAtDocumentPathWithFileName:(NSString *)fileName{
    NSFileManager *BabyFileHelper = [NSFileManager defaultManager];
    NSString *filePath = [[self filePathDocumentsPath] stringByAppendingPathComponent:fileName];
    return [BabyFileHelper fileExistsAtPath:filePath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)fileCreatePathIfNecessary:(NSString*)path {
    BOOL succeeded = YES;
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        succeeded = [fm createDirectoryAtPath: path
                  withIntermediateDirectories: YES
                                   attributes: nil
                                        error: nil];
        NSLog(@"✅✅✅路径%@创建成功\n",path);
    }
    
    return succeeded;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*)fileCreateDocumentPathWithName:(NSString*)name {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
    NSString* cachePath = [cachesPath stringByAppendingPathComponent:name];
    
    [self fileCreatePathIfNecessary:cachesPath];
    [self fileCreatePathIfNecessary:cachePath];
    
    return cachePath;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*)fileCreateCachePathWithName:(NSString*)name {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
    NSString* cachePath = [cachesPath stringByAppendingPathComponent:name];
    
    [self fileCreatePathIfNecessary:cachesPath];
    [self fileCreatePathIfNecessary:cachePath];
    NSLog(@"✅✅✅缓存目录下的路径:%@\n",name);
    return cachePath;
}


+(CGFloat)fileCacheSize{
    CGFloat cacheSize = 0;
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    for (NSString *f in files)
    {
        NSString *path = [cachPath stringByAppendingPathComponent:f];
        cacheSize += [self fileManagerGetSizeWithFilePath:path];
    }
    NSLog(@"cacheSize == %f",cacheSize);
    
    return cacheSize;
    
}

#pragma mark - 计算目录大小
+ (CGFloat)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [self fileManagerGetSizeWithFilePath:absolutePath];
        }
        NSLog(@"d = %f",folderSize);
        return folderSize;
    }
    return 0;
}


/**
 计算路径下的文件内存大小
 
 @param filepath 文件路径
 @return 文件内存大小
 */
+ (int64_t)fileManagerGetSizeWithFilePath:(NSString *)filepath{
    return [self folderSizeAtPath:[filepath cStringUsingEncoding:NSUTF8StringEncoding] maxTime:nil];
}

// 完全使用unix c 函数 性能最好
// 实测  1000个文件速度 0.005896
+ (int64_t)folderSizeAtPath:(const char *)folderPath maxTime:(NSNumber *)maxTime
{
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    
    int64_t folderSize = 0;
    DIR* dir = opendir(folderPath);
    
    
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int64_t folderPathLength = strlen(folderPath);
        
        // 子文件的路径地址
        char childPath[1024];
        stpcpy(childPath, folderPath);
        
        if (folderPath[folderPathLength-1] != '/') {
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        
        if (child->d_type == DT_DIR) { // directory
            // 递归调用子目录
            folderSize += [[self class] folderSizeAtPath:childPath maxTime:maxTime];
            
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK) { // file or link
            //特殊处理几个月前的内容
            if (maxTime != nil) {
                BOOL shouldCountSize = YES;
                char *p = child->d_name;
                NSString *fileName = [NSString stringWithCString:p encoding:NSUTF8StringEncoding];
                NSComparisonResult result = [fileName compare:[maxTime stringValue]];
                if (result == NSOrderedDescending)//小于三个月不统计
                {
                    shouldCountSize = NO;
                }
                
                if (!shouldCountSize) {
                    continue;
                }
            }
            
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"方法:%s,%f,%lld",__func__,endTime-startTime,folderSize);
    return folderSize;
}



#pragma mark - 清除缓存
+(void)fileClearCache{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       NSLog(@"cachPath===%@",cachPath);
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       NSLog(@"file === %@",files);
                       for (NSString *p in files)
                       {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path])
                           {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}

+ (void)clearCacheSuccess
{
    NSLog(@"清理成功");
}


@end
