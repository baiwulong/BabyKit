//
//  BBKeyboardManager.h
//  BabyKit
//
//  Created by li hua on 2016/6/20.
//

#import <Foundation/Foundation.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface BBKeyboardManager : NSObject

/// IQKeyboardManager 单例管理器
@property (nonatomic,strong) IQKeyboardManager *manager ;

/// 单例对象
+(BBKeyboardManager *)sharedInstance;

/// 配置IQKeyboardManager
-(void)configManager;

@end
