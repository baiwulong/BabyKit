//
//  BBDatabaseManager.m
//  fmdbDemo1
//
//  Created by 黎迅华 on 2016/6/15.
//  Copyright © 2016年 黎迅华. All rights reserved.
//

#import "BBDatabaseManager.h"

static BBDatabaseManager *shareDatabaseManager = nil;
@implementation BBDatabaseManager

#pragma mark - 数据库管理类-单例

/// 数据库管理类-单例
+(BBDatabaseManager *)sharedInstance{
    if (!shareDatabaseManager) {
        shareDatabaseManager = [[BBDatabaseManager alloc]init];
    }
    return shareDatabaseManager;
}

#pragma mark - 数据库文件创建/消耗 打开/关闭

/**
 * @brief 打开数据库,需要传递对应数据库的名称,如@"xxx.db",不存在对应的数据库,就默认创建在Documents目录下
 * db 默认创建在Documents目录下,假如传递完整的路径dbName,则根据路径创建对应的数据库
 */
-(BOOL)openDB:(NSString *)db{
    if (!db) {
        NSAssert(0, @"\n\n执行方法:%s\n❌❌❌需要传递一个数据库名称,如xxx.db❌❌❌\n\n",__FUNCTION__);
        return NO;
    }
    if (self.databaseQueue) {
        return YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:db]) {
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:db];
    }else{
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath   = [docsPath stringByAppendingPathComponent:db];
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    NSLog(@"\n\n====================================================\n\n✅✅✅执行方法:%s\n数据库路径:\n%@\n\n====================================================\n\n",__FUNCTION__,self.databaseQueue.path);
    return YES;
}

/**
 * @brief 删除数据库文件
 */
-(BOOL)dropDB:(NSString *)db{
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isRemove = [fileManager removeItemAtPath:db.databasePath error:nil];
        if (isRemove) {
            NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n文件%@删除成功\n\n====================================================\n\n",__FUNCTION__,db);
        }else{
            NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n文件%@删除失败\n\n====================================================\n\n",__FUNCTION__,db);
        }
    }];
    return NO;
}


#pragma mark - 数据库表table创建/销毁
//https://www.jianshu.com/p/d57c2b095cca
/**
 * @brief 在存在数据库的情况下,传入字段动态创建表格,例如字典:@{@"userName":@"text",@"headPhoto":@"blob"}
 * @param table 表格的名称
 * @param dictionary 动态传参,动态创建相应字段的表格
 * @return bool值,是否创建成功
 */
-(BOOL)createTable:(NSString *)table dictionary:(NSDictionary *)dictionary{
    [self isHadOpenDatabase];
    __block NSMutableArray *muArray = [[NSMutableArray alloc]init];
    [muArray addObjectsFromArray: [self selectFromTable:table]];
    __block BOOL isNewTable = false;
    __block BOOL isOk = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db tableExists:table]) {
            for (int i = 0; i<dictionary.allKeys.count; i++) {
                NSString *key = dictionary.allKeys[i];
                if (![db columnExists:key inTableWithName:table]) {
                    NSString *dropSql = [NSString stringWithFormat:@"DROP TABLE %@",table];
                    [db executeUpdate:dropSql];
                    isNewTable = YES;
                    break;
                }
            }
        }
        NSMutableString *muStr = [[NSMutableString alloc]init];
        for (int i = 0; i<dictionary.allKeys.count; i++) {
            NSString *key = dictionary.allKeys[i];
            NSString * value = dictionary[key];
            if ([[value uppercaseString] isEqualToString:@"TEXT"]) {
                [muStr appendString:[NSString stringWithFormat:@",%@ TEXT not null default ''",key]];
            }else if ([[value uppercaseString]isEqualToString:@"INTEGER"]){
                [muStr appendString:[NSString stringWithFormat:@",%@ INTEGER not null default ''",key]];
            }else if ([[value uppercaseString]isEqualToString:@"BLOB"]){
                [muStr appendString:[NSString stringWithFormat:@",%@ BOLB not null default ''",key]];
            }else{
                NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n类型错了,请检查字典中的类型\n提示:传入字典的参数:key代表数据表字段,value代表表字段的类型.\n本类限制三种类型:text类型[NSString],integer类型[NSNumber],blob类型[图片等]\n\n====================================================\n\n",__FUNCTION__);
                return;
            }
        }
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (rowid integer primary key autoincrement not null default ''%@)",table,muStr];
        isOk = [db executeUpdate:sql];

    }];

    if (isOk) {
        __block NSMutableArray *newMuArr = [[NSMutableArray alloc]init];
        NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n创建%@表成功\n\n====================================================\n\n",__FUNCTION__,table);
        if (muArray.count && isNewTable) {
            [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
                for (NSDictionary *dict in muArray) {
                    NSMutableDictionary *newDict = [[NSMutableDictionary alloc]init];
                    for (NSString *key in dict.allKeys) {
                        if ([db columnExists:key inTableWithName:table]) { //假如新表中存在旧表的key，就把值插入数据库中
                            [newDict setObject:dict[key] forKey:key];
                        }
                    }
                    [newMuArr addObject:newDict];
                }
            }];
            [self insertTable:table dictionaryArray:newMuArr completion:nil];
        }
    }else{
        NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n创建%@表失败\n\n====================================================\n\n",__FUNCTION__,table);
    }

    return isOk;
}

/**
 * @brief 删除指定的表
 */
-(BOOL)dropTable:(NSString *)table{
    [self isHadOpenDatabase];
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if (![db tableExists:table]) {
            NSLog(@"\n表%@不存在数据库",table);
            return;
        }
    }];
    BOOL isOK = [self excuteUpdateSql:[NSString stringWithFormat:@"DROP TABLE %@",table]];
    return isOK;
}

/**
 * @brief 指定的表字段
 */
-(NSArray *)fieldInTable:(NSString *)table{
    __block NSMutableArray *muArr = [[NSMutableArray alloc]init];
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if (![db tableExists:table]) {
            NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表%@不存在\n\n====================================================\n\n",__FUNCTION__,table);
            return;
        }
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"select * from %@",table]];
        for (int i=0; i<[result columnCount]; i++) {
            NSString * columnName = [result columnNameForIndex:i];
            [muArr addObject:columnName];
        }
        [result close];
    }];
    return muArr;
}

#pragma mark - SQL语句执行操作

/**
 * @brief 查询sql语句
 */
-(NSMutableArray<NSMutableDictionary *>*)querySql:(NSString *)sql{
    __block NSMutableArray *muArr = [[NSMutableArray alloc]init];
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:sql];
        while (result.next) {
            NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
            for (NSString *key in result.columnNameToIndexMap.allKeys) {
                NSString *valueString = [result stringForColumn:key];
                [dict setValue:valueString forKey:key];
            }
            [muArr addObject:dict];
        }
    }];
    return muArr;
}

/**
 * @brief 更新,插入或删除等执行SQL语句(需要自己写sql语句)
 */
-(BOOL)excuteUpdateSql:(NSString *)sql{
    [self isHadOpenDatabase];
    __block BOOL isOk = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        isOk = [db executeUpdate:sql];
        if (isOk) {
            NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n%@执行成功\n\n====================================================\n\n",__FUNCTION__,sql);
        }else{
            NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n%@执行失败\n\n====================================================\n\n",__FUNCTION__,sql);
        }
    }];
    return isOk;
}


#pragma mark -添加数据

/**
 * @brief 添加数据到指点的表,@{@"column":@"value",@"column2":@"value2"}
 */
-(BOOL)insertTable:(NSString *)table dictionary:(NSDictionary *)dictionary{
    [self isHadOpenDatabase];

    NSMutableString *keyMuStr = [[NSMutableString alloc]init];
    NSMutableString *valueMuStr = [[NSMutableString alloc]init];
    for (int i = 0; i<dictionary.allKeys.count; i++) {
        NSString *key = dictionary.allKeys[i];
        //=>@"index1,:index2..."
        [keyMuStr appendString:[NSString stringWithFormat:@"%@,",key]];
        //=>@":index1,:index2..."
        [valueMuStr appendString:[NSString stringWithFormat:@":%@,",key]];
    }
    if (keyMuStr.length > 0) {
        NSString *keyStr = [keyMuStr substringToIndex:keyMuStr.length-1];
        NSString *valueStr = [valueMuStr substringToIndex:valueMuStr.length-1];
        NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@)VALUES(%@)",table,keyStr,valueStr];
        //插入数据
        NSMutableDictionary *muDict = [[NSMutableDictionary alloc]init];
        for (int i = 0; i<dictionary.allValues.count; i++) {
            [muDict setValue:[self toString:dictionary.allValues[i]] forKey:dictionary.allKeys[i]];
        }
        NSArray *fieldArray = [self fieldInTable:table];
        __block BOOL isOk = NO;
        [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            isOk = [db executeUpdate:sql withParameterDictionary:muDict];
            if (isOk) {
                NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n%@插入数据成功SQL:%@\n\n====================================================\n\n",__FUNCTION__,table,sql);
            }else{
                NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n%@插入数据失败\n执行的SQL:%@\n表字段:%@\n\n====================================================\n\n",__FUNCTION__,table,sql,fieldArray);
            }
        }];
        return isOk;
    }
    return NO;
}



/**
 * @brief 批量插入数据表,@[@{@"column":@"value",@"column2":@"value2"}]
 */
- (void)insertTable:(NSString *)table dictionaryArray:(NSArray<NSDictionary *> *)dictionaryArray completion:(void (^ __nullable)(void))completion{
    [self isHadOpenDatabase];
    for (NSDictionary *dict in dictionaryArray) {
        [self insertTable:table dictionary:dict];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

/**
 * @brief 添加数据到指点的数据表,可以指点定是否开启事务处理
 * @param table     添加数据到指点的数据表
 * @param dictionary  字段与对应的内容     @{@"column":@"value",@"column2":@"value2"}
 * @param transaction 是否开启事务处理
 */
- (void)insertTable:(NSString *)table dictionary:(NSDictionary *)dictionary transaction:(BOOL)transaction{
    [self isHadOpenDatabase];

    if (transaction) {
        __block BOOL isOk = NO;
        [self.databaseQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            @try {
                if (![self insertTable:table dictionary:dictionary]) {
                    NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表格%@事务插入失败\n\n====================================================\n\n",__FUNCTION__,table);
                }else{
                    NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n表格%@事务插入成功\n\n====================================================\n\n",__FUNCTION__,table);
                }
            }
            @catch (NSException *exception) {
                [db rollback];
            }
            @finally {
                if (!isOk) {
                    [db commit];
                }
            }
        }];
    }else{
        if (![self insertTable:table dictionary:dictionary]) {
            NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表格%@非事务插入失败\n\n====================================================\n\n",__FUNCTION__,table);
        }else{
            NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n表格%@非事务插入成功\n\n====================================================\n\n",__FUNCTION__,table);
        }
    }
}

/**
 * @brief 添加数据到指点的数据表,可以指点定是否开启事务处理
 * @param table          添加数据到指点的数据表
 * @param dictionaryArray  数组"字段与其内容"    @[@{@"column":@"value",@"column2":@"value2"},...]
 * @param transaction 是否开启事务处理
 */
- (void)insertTable:(NSString *)table dictionaryArray:(NSArray *)dictionaryArray transaction:(BOOL)transaction{
    [self isHadOpenDatabase];

    if (transaction) {
        if (transaction) {
            __block BOOL isOk = NO;
            [self.databaseQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
                @try {
                    for (NSDictionary *dict in dictionaryArray) {//就是一次性生产完,然后发货
                        if (![self insertTable:table dictionary:dict]) {
                            NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表格%@事务批量插入失败\n\n====================================================\n\n",__FUNCTION__,table);
                        }else{
                            NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n表格%@事务批量插入成功\n\n====================================================\n\n",__FUNCTION__,table);
                        }
                    }
                }
                @catch (NSException *exception) {
                    [db rollback];
                }
                @finally {
                    if (!isOk) {
                        [db commit];
                    }
                }
            }];
        }else{
            for (NSDictionary *dict in dictionaryArray) {//就是生产一个,然后发货一个
                if (![self insertTable:table dictionary:dict]) {
                    NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表格%@非事务批量插入失败\n\n====================================================\n\n",__FUNCTION__,table);
                }else{
                    NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n表格%@非事务批量插入成功\n\n====================================================\n\n",__FUNCTION__,table);
                }
            }
        }
    }
}




#pragma mark - 删除数据

/**
 * @brief 删除指定表的所有数据
 * @param table 表名称
 * @return bool值
 */
-(BOOL)deleteFromTable:(NSString *)table{
    [self isHadOpenDatabase];

    __block BOOL isOk = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@ where 1",table];
        isOk = [db executeUpdate:sql];
        if (isOk) {
            NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n表%@全部数据清空成功\n\n====================================================\n\n",__FUNCTION__,table);
        }else{
            NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表%@全部数据清空失败\n\n====================================================\n\n",__FUNCTION__,table);
        }
    }];
    return isOk;

}

/**
 * @brief 删除指点table中指定,字段值与传入的值相等,的数据记录
 */
-(BOOL)deleteFromTable:(NSString *)table whereDictionary:(NSDictionary *)dictionary{
    [self isHadOpenDatabase];
    __block BOOL isOk = NO;
    for (NSString *key in dictionary.allKeys) {
        [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            if (![db tableExists:table]) {
                 NSLog(@"\n\n====================================================\n\n❌❌❌\n执行方法:%s\n该表(%@)不存在数据库中\n\n====================================================\n\n",__FUNCTION__,table);
                return ;
            };
            NSArray *fieldArray = [self fieldInTable:table];
            if (![db columnExists:key inTableWithName:table]) {
                NSLog(@"\n\n====================================================\n\n❌❌❌\n执行方法:%s\n请输入正确的字典key,该字段(%@)不存在数据表中,表字段:%@\n❌❌❌\n\n====================================================\n\n",__FUNCTION__,key,fieldArray);
                return;
            }

        }];
    }
    if (!dictionary) {
        NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n请输入字典,key对应表字段,value对应表字段的值\n\n====================================================\n\n",__FUNCTION__);
        return isOk;
    }
    NSMutableString *str = [[NSMutableString alloc]init];
    for (NSString *key in dictionary.allKeys) {
        [str appendString:[NSString stringWithFormat:@" %@ = '%@' and",key,dictionary[key]]];
    }
    NSString *whereStr = [str substringToIndex:str.length-3];
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where %@",table,whereStr];

    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db tableExists:table]) {
            isOk = [db executeUpdate:sql];
            if (isOk) {
                NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n表%@指定数据%@,清空成功\n\n====================================================\n\n",__FUNCTION__,table,whereStr);
            }else{
                NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表%@指定数据%@,清空失败\n\n====================================================\n\n",__FUNCTION__,table,whereStr);
            }
        }else{
            NSLog(@"\n\n====================================================\n\n❌❌❌执行方法:%s\n\n该表(%@)不存在数据库中\n\n====================================================\n\n",__FUNCTION__,table);
        }
    }];
    return isOk;
}

#pragma mark - 查询数据

/**
 * @brief 查询方法
 */
-(NSArray<NSDictionary *> *)selectFromTable:(NSString *)table{
    [self isHadOpenDatabase];

    NSString * sql = [NSString stringWithFormat:@"select * from %@",table];
    //    返回所有用户的字典
    __block NSMutableArray *muArr = [[NSMutableArray alloc]init];
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet * result = [db executeQuery:sql];
        while (result.next) {
            NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
            for (NSString *key in result.columnNameToIndexMap.allKeys) {
                NSString *valueString = [result stringForColumn:key];
                [dict setValue:valueString forKey:key];
            }
            [muArr addObject:dict];
        }
    }];
    return muArr;
}

/**
 * @brief 查询方法,range只查询在range范围内的数据,如第1-10条的数据,就NSRangeMake(0,10)
 */
-(NSArray<NSDictionary *> *)selectFromTable:(NSString *)table range:(NSRange)range{
    [self isHadOpenDatabase];

    NSString * sql = [NSString stringWithFormat:@"select * from %@ limit %ld,%ld",table,range.location,range.length];
    //    返回所有用户的字典
    __block NSMutableArray *muArr = [[NSMutableArray alloc]init];
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet * result = [db executeQuery:sql];
        while (result.next) {
            NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
            for (NSString *key in result.columnNameToIndexMap.allKeys) {
                NSString *valueString = [result stringForColumn:key];
                [dict setValue:valueString forKey:key];
            }
            [muArr addObject:dict];
        }
    }];
    return muArr;
}

/**
 * @brief 查询第一条数据
 */
-(NSDictionary *)selectFirstRowFromTable:(NSString *)table{
    //可以自己写高效的sql,图方便了
    NSArray *array = [self selectFromTable:table];
    if (array.count) {
        return array.firstObject;
    }
    return [[NSDictionary alloc]init];
}

/**
 * @brief 查询最后一条数据
 */
-(NSDictionary *)selectLastRowFromTable:(NSString *)table{
    //可以自己写高效的sql,图方便了
    NSArray *array = [self selectFromTable:table];
    if (array.count) {
        return array.lastObject;
    }
    return [[NSDictionary alloc]init];
}

#pragma mark - 更新数据

/**
 * @brief 更新数据,
 * @fieldDictionary:传递dictionary 如更新第三条记录的name,age,sex三个字段的值为@"tm",@"25",@"1",就传递字典@{"name":@"tm",@"age":@"25",@"sex":@"1"}
 * @whereDictionary:就传递@{@"rowid":@"3"}
 */
-(BOOL)updateTable:(NSString *)table keyValueDictionary:(NSDictionary *)fieldDictionary whereDictionary:(NSDictionary *)whereDictionary{
    [self isHadOpenDatabase];

    NSMutableString *fieldStr = [[NSMutableString alloc]init];
    for (NSString *key in fieldDictionary.allKeys) {
        [fieldStr appendString:[NSString stringWithFormat:@" %@ = '%@',",key,fieldDictionary[key]]];
    }
    NSString *newFieldStr = [fieldStr substringToIndex:fieldStr.length-1];

    NSMutableString *str = [[NSMutableString alloc]init];
    for (NSString *key in whereDictionary.allKeys) {
        [str appendString:[NSString stringWithFormat:@" %@ = '%@' and",key,whereDictionary[key]]];
    }
    NSString *whereStr = [str substringToIndex:str.length-3];

    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where %@",table,newFieldStr,whereStr];
    __block BOOL isOK = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        isOK = [db executeUpdate:sql];
        if (isOK) {
            NSLog(@"\n\n====================================================\n\n✅执行方法:%s\n表%@更新成功\n\n====================================================\n\n",__FUNCTION__,table);
        }else{
            NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n表%@更新失败\n\n====================================================\n\n",__FUNCTION__,table);
        }
    }];
    return isOK;
}

-(BOOL)isHadOpenDatabase{
    if (!self.databaseQueue) {
        NSAssert(0, @"\n\n====================================================\n\n❌❌❌执行方法:%s\n请先打开数据库,请先执行`openDB:`方法来设置_databaseQueue指定的数据库文件路径❌❌❌\n\n====================================================\n\n",__FUNCTION__);
        return NO;
    }
    return YES;
}

-(NSString *)toString:(id)value{
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }else if ([value isKindOfClass:[NSNumber class]]){
        NSNumber *n = (NSNumber *)value;
        return n.stringValue;
    }
    NSLog(@"\n\n====================================================\n\n❌执行方法:%s\n%@不是字符串类型,请在参数字典中传递字符串类型\n\n====================================================\n\n",__FUNCTION__,value);
    return @"";
}
@end
