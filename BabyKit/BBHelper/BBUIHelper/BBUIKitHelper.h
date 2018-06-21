//
//  BBUIKitHelper.h
//  Pods
//
//  Created by li hua on 2016/6/14.
//

#import <Foundation/Foundation.h>



#pragma mark - UIButton Category - 分类

/// 自定义按钮样式
typedef NS_ENUM(NSInteger, BBButtonType){
    //内容居中样式显示
    BBButtonTypeCenterImageLeft = 0,            ///< 内容居中:图左，文右 (系统默认样式)
    BBButtonTypeCenterImageRight,               ///< 内容居中:图右、文左
    BBButtonTypeCenterImageTop,                 ///< 内容居中:图上、文下
    BBButtonTypeCenterImageBottom,              ///< 内容居中:图下、文上
    BBButtonTypeCenterImageCenter,              ///< 内容居中:图中、文中(重叠)
    //内容居左侧样式显示
    BBButtonTypeLeftImageLeft,                  ///< 内容居左:图左、文右
    BBButtonTypeLeftImageRight,                 ///< 内容居左:图右、文左
    //内容居右侧样式显示
    BBButtonTypeRightImageLeft,                 ///< 内容居右:图左、文右
    BBButtonTypeRightImageRight,                ///< 内容居右:图右、文左
};

@interface UIButton (BBButton)
/**
 button 的布局样式，默认为：BBButtonTypeCenterImageLeft，注意：文字、字体大小、图片等设置一定要在设置 BBButtonType 之前设置，要不然计算会以默认字体大小计算，导致位置偏移
 */
@property(nonatomic, assign) BBButtonType bb_buttonType;

/*!
 *  文字与图片之间的间距，默认为：0
 */
@property (nonatomic, assign) CGFloat bb_padding;

@end

#pragma mark - TMUIKitHelper - 快速创建控件类

/**
 --------------------------------------------------------------
 `TMUIKitHelper`快速调用接口创建UI控件
 --------------------------------------------------------------
 */
@interface TMUIKitHelper : NSObject

#pragma mark - C函数快速获取

/// 判断是否为 iPhone 5SE
BOOL isiPhone5SE(void);
/// 判断是否为iPhone 6/6s
BOOL isiPhone6S(void);
/// 判断是否为iPhone 6Plus/6sPlus
BOOL isiPhone6Plus(void);
/// 判断是否为iPhoneX
BOOL isiPhoneX(void);
/// 系统版本
CGFloat systemVersion(void);

/// 快速获取主屏幕
UIWindow *keyWindow(void);
/// 快速获取屏幕宽度
CGFloat screen(void);
/// 快速获取屏幕高度
CGFloat screenHeight(void);
/// 快速设置view圆角
void viewRadius(UIView *view,float radius);
/// 快速设置view圆角
void viewBorder(UIView *view,float radius,float border,UIColor *borderColor);
/// 获取非空字符串
NSString *toString(id obj);

/// 比例宽度，
CGFloat TMScaleWidth(CGFloat width);
/// 比例高度，
CGFloat TMScaleHeight(CGFloat height);

#pragma mark - UI

+(void)radius:(UIView *)view radius:(CGFloat)radius;
+(void)radius:(UIView *)view radius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

#pragma mark - UILabel
+(UILabel *)label;
+(UILabel *)labelFrame:(CGRect)frame;
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text;
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor;
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

#pragma mark - UIButton

+(UIButton *)button;
+(UIButton *)buttonFrame:(CGRect)frame;
+(UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title;
+(UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor;
+(UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor  target:(id)target selector:(SEL)selector;
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target selector:(SEL)selector;
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius title:(NSString *)title titleColor:(UIColor *)titleColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor target:(id)target selector:(SEL)selector;

+(UIButton *)buttonFrame:(CGRect)frame image:(id)image;
+(UIButton *)buttonFrame:(CGRect)frame image:(id)image target:(id)target selector:(SEL)selector;
+(UIButton *)buttonFrame:(CGRect)frame bgImage:(id)bgImage target:(id)target selector:(SEL)selector;
+(UIButton *)buttonFrame:(CGRect)frame image:(id)image selectedImage:(id)selectedImage target:(id)target selector:(SEL)selector;;
+(UIButton *)buttonFrame:(CGRect)frame image:(id)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target selector:(SEL)selector;

+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius bgImage:(id)bgImage target:(id)target selector:(SEL)selector;
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius image:(id)image target:(id)target selector:(SEL)selector;
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius image:(id)image selectedImage:(id)selectedImage target:(id)target selector:(SEL)selector;

+(UIButton *)buttonFrame:(CGRect)frame image:(id)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat)fontsize buttonType:(BBButtonType)type padding:(CGFloat)padding target:(id)target selector:(SEL)selector;

#pragma mark - UIImageView

+(UIImageView *)imageView;
+(UIImageView *)imageViewFrame:(CGRect)frame;
+(UIImageView *)imageViewFrame:(CGRect)frame image:(id)image;
+(UIImageView *)imageViewFrame:(CGRect)frame backgroundColor:(UIColor *)color;
+(UIImageView *)imageViewFrame:(CGRect)frame image:(id)image radius:(CGFloat)radius;

#pragma mark - UITextField

+(UITextField *)textFieldFrame:(CGRect)frame backgroundImage:(id)image placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode;
+(UITextField *)textFieldFrame:(CGRect)frame backgroundImage:(id)image placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate;
+(UITextField *)textFieldFrame:(CGRect)frame backgroundImage:(id)image placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType secureTextEntry:(BOOL)secureTextEntry;

+(UITextField *)textFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode;
+(UITextField *)textFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate;
+(UITextField *)textFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType secureTextEntry:(BOOL)secureTextEntry;

#pragma mark - UITableView

+(UITableView *)tableViewFrame:(CGRect)frame delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource  style:(UITableViewStyle)style;
+(UITableView *)tableViewFrame:(CGRect)frame delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource style:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle;

#pragma mark - UIAlertViewController

//NS_CLASS_AVAILABLE_IOS(8_0) iOS8之后才有用

///UIAlertController弹窗，默认取消按钮为“确定”
+(UIAlertController *)alertControllerTitle:(NSString *)title message:(NSString *)message NS_CLASS_AVAILABLE_IOS(8_0);

///UIAlertController弹窗，自定义 取消按钮
+(UIAlertController *)alertControllerTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle NS_CLASS_AVAILABLE_IOS(8_0);

///UIAlertController弹窗，自定义 取消按钮，自定义按钮个数，buttonBlock回调中的tag顺序标记按钮事件
+(UIAlertController *)alertControllerTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitleArray:(NSArray <NSString *>*)buttonTitleArray buttonBlock:(void(^)(NSInteger tag))buttonBlock NS_CLASS_AVAILABLE_IOS(8_0);

///UIAlertController弹窗，自定义弹窗样式 取消按钮，自定义按钮个数，buttonBlock回调中的tag顺序标记按钮事件
+(UIAlertController *)alertControllerStyle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitleArray:(NSArray <NSString *>*)buttonTitleArray  buttonBlock:(void(^)(NSInteger tag))buttonBlock NS_CLASS_AVAILABLE_IOS(8_0);

@end


