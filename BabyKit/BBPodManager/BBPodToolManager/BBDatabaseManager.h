//
//  BBDatabaseManager.h
//  fmdbDemo1
//
//  Created by 黎迅华 on 2017/6/15.
//  Copyright © 2016年 黎迅华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

/**
 --------------------------------------------------------------
 `BBDatabaseManager`,操作数据库类,基于FMDB封装
 ## FMDB主要操作3个类:
  The three main classes in FMDB are:
  - `FMDatabase` - Represents a single SQLite database.  Used for executing SQL statements.
  - `<FMResultSet>` - Represents the results of executing a query on an `FMDatabase`.
  - `<FMDatabaseQueue>` - If you want to perform queries and updates on multiple threads, you'll want to use this class.
 --------------------------------------------------------------
 */
@interface BBDatabaseManager : NSObject

NS_ASSUME_NONNULL_BEGIN

/// 数据库操作队列,在多线程操作数据库时,需要使用这个来操作,保证线程安全
@property (nonatomic,strong) FMDatabaseQueue *databaseQueue;

#pragma mark - 数据库管理类-单例

/// 数据库管理类-单例
+(BBDatabaseManager *)sharedInstance;


#pragma mark - 数据库文件创建/消耗 打开/关闭

/**
 * @brief 打开数据库,需要传递对应数据库的名称,如@"xxx.db",不存在对应的数据库,就默认创建在Documents目录下
 * db 默认创建在Documents目录下,假如传递完整的路径dbName,则根据路径创建对应的数据库
 */
-(BOOL)openDB:(NSString *)db;

/**
 * @brief 删除数据库文件
 */
-(BOOL)dropDB:(NSString *)db;


#pragma mark - 数据库表table创建/销毁

/**
 * @brief 在存在数据库的情况下,传入字段动态创建表格,例如字典:@{@"userName":@"text",@"headPhoto":@"blob"}
 * @param table 表格的名称
 * @param dictionary 动态传参,动态创建相应字段的表格
 * @return bool值,是否创建成功
 */
-(BOOL)createTable:(NSString *)table dictionary:(NSDictionary *)dictionary;

/**
 * @brief 指定的表字段
 */
-(NSArray *)fieldInTable:(NSString *)table;

/**
 * @brief 删除指定的表
 */
-(BOOL)dropTable:(NSString *)table;


#pragma mark - SQL语句执行操作

/**
 * @brief 查询sql语句
 */
-(NSMutableArray<NSDictionary *>*)querySql:(NSString *)sql;

/**
 * @brief 更新,插入或删除等执行SQL语句(需要自己写sql语句)
 */
-(BOOL)excuteUpdateSql:(NSString *)sql;

#pragma mark -添加数据

/**
 * @brief 添加数据到指点的表,@{@"column":@"value",@"column2":@"value2"}
 */
-(BOOL)insertTable:(NSString *)table dictionary:(NSDictionary *)dictionary;

/**
 * @brief 批量插入数据表,@[@{@"column":@"value",@"column2":@"value2"}]
 */
- (void)insertTable:(NSString *)table dictionaryArray:(NSArray<NSDictionary *> *)dictionaryArray completion:(void (^ __nullable)(void))completion;


/**
 * @brief 添加数据到指点的数据表,可以指点定是否开启事务处理
 * @param table     添加数据到指点的数据表
 * @param dictionary  字段与对应的内容     @{@"column":@"value",@"column2":@"value2"}
 * @param transaction 是否开启事务处理
 */
- (void)insertTable:(NSString *)table dictionary:(NSDictionary *)dictionary transaction:(BOOL)transaction;



#pragma mark - 删除数据

/**
 * @brief 删除指定表的所有数据
 * @param table 表名称
 * @return bool值
 */
-(BOOL)deleteFromTable:(NSString *)table;

/**
 * @brief 删除指点table中指定,字段值与传入的值相等,的数据记录
 */
-(BOOL)deleteFromTable:(NSString *)table whereDictionary:(NSDictionary *)dictionary;

#pragma mark - 查询数据

/**
 * @brief 查询方法
 */
-(NSArray<NSDictionary *> *)selectFromTable:(NSString *)table;

/**
 * @brief 查询方法,range只查询在range范围内的数据,如第1-10条的数据,就NSRangeMake(0,10)
 */
-(NSArray<NSDictionary *> *)selectFromTable:(NSString *)table range:(NSRange)range;

/**
 * @brief 查询第一条数据
 */
-(NSDictionary *)selectFirstRowFromTable:(NSString *)table;

/**
 * @brief 查询最后一条数据
 */
-(NSDictionary *)selectLastRowFromTable:(NSString *)table;

#pragma mark - 更新数据

/**
 * @brief 更新数据,
 * @fieldDictionary:传递dictionary 如更新第三条记录的name,age,sex三个字段的值为@"BB",@"25",@"1",就传递字典@{"name":@"BB",@"age":@"25",@"sex":@"1"}
 * @whereDictionary:就传递@{@"rowid":@"3"}
 */
-(BOOL)updateTable:(NSString *)table keyValueDictionary:(NSDictionary *)fieldDictionary whereDictionary:(NSDictionary *)whereDictionary;

#pragma mark - sql语句语法
/*
 5.1 插入数据
 insert into 表名(col1,col2,……) values(val1,val2……); -- 插入指定列
 insert into 表名 values (,,,,); -- 插入所有列
 insert into 表名 values    -- 一次插入多行
 (val1,val2……),
 (val1,val2……),
 (val1,val2……);
 5.3修改数据
 update tablename
 set
 col1=newval1,
 col2=newval2,
 ...
 ...
 colN=newvalN
 where 条件;
 5.4，删除数据    delete from tablenaeme where 条件;
 5.5，    select     查询
 （1）  条件查询   where  a. 条件表达式的意义，表达式为真，则该行取出
 b.  比较运算符  = ，!=，< > <=  >=
 c.  like , not like ('%'匹配任意多个字符,'_'匹配任意单个字符)
 in , not in , between and
 d. is null , is not null
 （2）  分组       group by
 一般要配合5个聚合函数使用:max,min,sum,avg,count
 （3）  筛选       having
 （4）  排序       order by
 （5）  限制       limit
 6:    连接查询
 6.1， 左连接
 .. left join .. on
 table A left join table B on tableA.col1 = tableB.col2 ;
 例句:
 select 列名 from table A left join table B on tableA.col1 = tableB.col2
 2.  右链接: right join
 3.  内连接:  inner join
 左右连接都是以在左边的表的数据为准,沿着左表查右表.
 内连接是以两张表都有的共同部分数据为准,也就是左右连接的数据之交集.
 7    子查询
 where 型子查询:内层sql的返回值在where后作为条件表达式的一部分
 例句: select * from tableA where colA = (select colB from tableB where ...);
 from 型子查询:内层sql查询结果,作为一张表,供外层的sql语句再次查询
 例句:select * from (select * from ...) as tableName where ....
 */
NS_ASSUME_NONNULL_END


@end
