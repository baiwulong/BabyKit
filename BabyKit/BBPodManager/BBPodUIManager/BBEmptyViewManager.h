//
//  BBEmptyViewManager.h
//  TMKit
//
//  Created by li hua on 2016/6/11.
//

#import <Foundation/Foundation.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

/** 空白页点击回调 */
typedef void(^BBEmptyOnClick)(void);

/**
 --------------------------------------------------------------
 `BBEmptyConfig`空白页面的配置
 配置图片，标题，详情描述，可自行配置文字颜色属性等
 --------------------------------------------------------------
 */
@interface BBEmptyConfig : NSObject

/// 空白页面滚动视图
@property (nonatomic,strong) UIScrollView *contentView ;
/// 空白页面-自定义视图
@property (nonatomic,strong) UIView *customView ;
/// 空白页面背景颜色
@property (nonatomic,strong) UIColor *bgColor ;
/// 空白页面偏移设置
@property (nonatomic,assign) CGFloat offset ;
/// 显示图片
@property (nonatomic,strong) UIImage *contentImage ;
/// 空白页面-控件竖直间距
@property (nonatomic,assign) CGFloat contentSpaceHeight ;
///是否动画显示
@property (nonatomic,assign) BOOL isLoading;
///自定义动画
@property (nonatomic,strong) CAAnimation *animation;

/// 空白页面-点击按钮事件配置
@property (nonatomic,copy) BBEmptyOnClick buttonOnClick ;
/// 空白页面-点击view事件配置
@property (nonatomic,copy) BBEmptyOnClick viewOnClick ;

/// 标题contentTitle
@property (nonatomic,copy) NSString *contentTitle ;
/// 标题contentTitle颜色（简单设置，更多请操作`contentTitleAttribute`）
@property (nonatomic,strong) UIColor *contentTitleColor ;
/// 标题contentTitle文本大小（简单设置，更多请操作`contentTitleAttribute`）
@property (nonatomic,assign) CGFloat contentTitlefontSize ;
/// 标题文字contentTitle属性配置（参考`NSAttributedString`配置）
@property (nonatomic,strong) NSDictionary *contentTitleAttribute ;


/// 详细描述contentDetail
@property (nonatomic,copy) NSString *contentDetail ;
/// 详细描述contentDetail颜色（简单设置，更多请操作`contentDetailAttribute`）
@property (nonatomic,strong) UIColor *contentDetailColor ;
/// 详细描述contentDetailFontSize文本大小（简单设置，更多请操作`contentTitleAttribute`）
@property (nonatomic,assign) CGFloat contentDetailFontSize ;
/// 详细描述contentDetail属性配置（参考`NSAttributedString`配置）
@property (nonatomic,strong) NSDictionary *contentDetailAttribute ;

/// 点击按钮图片
@property (nonatomic,strong) UIImage *clickButtonImage ;

/// 点击标题contentButtonTitle
@property (nonatomic,copy) NSString *contentButtonTitle ;
/// 点击标题contentButtonTitleColor颜色（简单设置，更多请操作`contentDetailAttribute`）
@property (nonatomic,strong) UIColor *contentButtonTitleColor ;
/// 点击标题contentButtonTitleFontSize文本大小（简单设置，更多请操作`contentTitleAttribute`）
@property (nonatomic,assign) CGFloat contentButtonTitleFontSize ;
/// 点击标题contentButtonTitle属性配置（参考`NSAttributedString`配置）
@property (nonatomic,strong) NSDictionary *contentButtonTitleAttribute ;



/**
 *  @brief 获取默认配置的一个BBEmptyConfig对象，然后可以修改对象的属性
 */
+(BBEmptyConfig *)defaultConfig;

@end




/**
 --------------------------------------------------------------
 `BBEmptyViewManager`基于`DZNEmptyDataSet`封装的空白页面管理类
 根据传递的类型创建不同类型的空白页面
 --------------------------------------------------------------
 */
@interface BBEmptyViewManager : NSObject

/// 空白页面配置
@property (nonatomic,strong) BBEmptyConfig *config ;

/**
 *  需要手动创建一个config对象，可以直接通过 `+(BBEmptyConfig *)defaultConfig`类方法来创建，并修改
 *
 *  @brief 创建一个空白页面,注意，返回对象BBEmptyViewManager需要在控制器中设为全局属性保留，不然显示不出来

     //实例代码：
     BBEmptyConfig *config = [BBEmptyConfig defaultConfig];
     self.manager = [BBEmptyViewManager emptyView:self.tableview config:config buttonOnClick:^{
 
     } viewOnClick:^{
 
     }];
    //重新刷新数据
    [tableview reloadData];

 
 *  @param emptyView - emptyView空白页面，UIScrollView或其子类，如tableview类
 *  @param config - config 配置空白页的config对象
 *  @param buttonOnClick - 空白页面中的按钮、按钮标题等点击事件
 *  @param viewOnClick - 空白页面标题等控件点击事件
 *
 *  @return BBEmptyViewManager 管理空白页的管理器，负责重新加载显示或消失管理
 *
 *  @since 0.1.0
 */
+(BBEmptyViewManager *)emptyView:(UIScrollView *)emptyView
                          config:(BBEmptyConfig *)config
                   buttonOnClick:(BBEmptyOnClick)buttonOnClick
                     viewOnClick:(BBEmptyOnClick)viewOnClick;


/**
 *  需要手动创建一个config对象，可以直接通过 `+(BBEmptyConfig *)defaultConfig`类方法来创建，并修改
 *
 *  @brief 创建一个空白页面,注意，返回对象BBEmptyViewManager需要在控制器中设为全局属性保留，不然显示不出来
 *
 *  @param emptyView - emptyView空白页面，UIScrollView或其子类，如tableview类
 *  @param contentImageName - contentImageName 配置空白页的显示图片
 *  @param buttonImageName - buttonImageName 配置空白页的点击按钮图片
 *  @param title - title标题
 *  @param detail - detail详情
 *  @param buttonOnClick - 标题点击事件
 *  @param viewOnClick - 空白页面标题等控件点击事件
 *
 *  @return BBEmptyViewManager 管理空白页的管理器，负责重新加载显示或消失管理
 *
 *  @since 0.1.0
 */
+(BBEmptyViewManager *)emptyView:(UIScrollView *)emptyView
                contentImageName:(id)contentImageName
                buttonImageName:(id)buttonImageName
                           title:(NSString *)title
                          detail:(NSString *)detail
                   buttonOnClick:(BBEmptyOnClick)buttonOnClick
                     viewOnClick:(BBEmptyOnClick)viewOnClick;



/**
 *  @brief 每次修改config后，主动调用重新渲染显示视图
 */
-(void)reloadEmptyView;


@end
