//
//  BabyKeyboardHelper.h
//  BabyKit
//
//  Created by li hua on 2017/6/20.
//

#import <Foundation/Foundation.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface BabyKeyboardHelper : NSObject

/// IQKeyboardManager 单例管理器
@property (nonatomic,strong) IQKeyboardManager *manager ;

/// 单例对象
+(BabyKeyboardHelper *)sharedInstance;

/// 配置IQKeyboardManager
-(void)configManager;

@end
