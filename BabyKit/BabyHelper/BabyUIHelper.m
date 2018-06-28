//
//  BBUIKitHelper.m
//  Pods
//
//  Created by li hua on 2017/6/14.
//

#import "BabyUIHelper.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>



 #pragma mark - UIButton Category

/**
 --------------------------------------------------------------
 UIButton的类别扩展，参考BAButton实现
 --------------------------------------------------------------
 */
@implementation UIButton (BabyButton)

#pragma mark - Setter and Getter （Runtime实现）

-(void)setBaby_buttonType:(BabyButtonType)baby_buttonType{
    objc_setAssociatedObject(self, @selector(baby_buttonType), @(baby_buttonType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutButton];
}

-(BabyButtonType)baby_buttonType{
    NSNumber *number = objc_getAssociatedObject(self, @selector(baby_buttonType));
    return number.integerValue;
}


-(void)setBaby_padding:(CGFloat)baby_padding{
    objc_setAssociatedObject(self, @selector(baby_padding), @(baby_padding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutButton];
}

-(CGFloat)baby_padding{
    NSNumber *number = objc_getAssociatedObject(self, @selector(baby_padding));
    return number.floatValue;
}

#pragma mark - Button Layout

-(void)layoutButton{
    CGFloat image_w = self.imageView.bounds.size.width;
    CGFloat image_h = self.imageView.bounds.size.height;
    
    CGFloat title_w = self.titleLabel.bounds.size.width;
    CGFloat title_h = self.titleLabel.bounds.size.height;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        title_w = self.titleLabel.intrinsicContentSize.width;
        title_h = self.titleLabel.intrinsicContentSize.height;
    }
    
    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    
    NSInteger insetPadding = 5;
    
    switch (self.baby_buttonType) {
        case BabyButtonTypeCenterImageLeft:{
            titleEdge = UIEdgeInsetsMake(0, self.baby_padding, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.baby_padding);
        }
            break;
        case BabyButtonTypeCenterImageRight:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w - self.baby_padding, 0, image_w);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.baby_padding, 0, -title_w);
        }
            break;
        case BabyButtonTypeCenterImageTop:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w, -image_h - self.baby_padding, 0);
            imageEdge = UIEdgeInsetsMake(-title_h - self.baby_padding, 0, 0, -title_w);
        }
            break;
        case BabyButtonTypeCenterImageBottom:
        {
            titleEdge = UIEdgeInsetsMake(-image_h - self.baby_padding, -image_w, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, -title_h - self.baby_padding, -title_w);
        }
            break;
        case BabyButtonTypeCenterImageCenter:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, -image_w);
        }
            break;
        case BabyButtonTypeLeftImageLeft:
        {
            titleEdge = UIEdgeInsetsMake(0, self.baby_padding + insetPadding, 0, 0);
            
            imageEdge = UIEdgeInsetsMake(0, insetPadding, 0, 0);
            
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case BabyButtonTypeLeftImageRight:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w + insetPadding, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.baby_padding + insetPadding, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case BabyButtonTypeRightImageLeft:
        {
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.baby_padding + insetPadding);
            titleEdge = UIEdgeInsetsMake(0, 0, 0, insetPadding);
            
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case BabyButtonTypeRightImageRight:
        {
            titleEdge = UIEdgeInsetsMake(0, 0, 0, image_w + self.baby_padding + insetPadding);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, -title_w + insetPadding);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
            
        default:
            break;
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
}

@end



/**
 --------------------------------------------------------------
 `BabyUIHelper`,快速调用接口创建UI控件
 --------------------------------------------------------------
 */

@implementation BabyUIHelper

#pragma mark - C函数快速获取

float BabyDegreesToRadian(float angle){
    return M_PI * (angle) / 180.0;
}

float BabyRadianToDegrees(float radian){
    return (radian*180.0)/(M_PI);
}

CGFloat BabyScaleHeight(CGFloat height){
    return  height * [[UIScreen mainScreen] bounds].size.height/667.0;
}

CGFloat BabyScaleWidth(CGFloat width){
    return  width * [[UIScreen mainScreen] bounds].size.width/375.0;
}

BOOL BabyisiPhone5SE(void){
    return [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f;
}
BOOL BabyisiPhone6S(void){
    return [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f;
}
BOOL BabyisiPhone6Plus(void){
    return  [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f;
}
BOOL BabyisiPhoneX(void){
    return ([[UIScreen mainScreen] bounds].size.height == 812.0f) ? YES : NO;
}

/// 系统版本
CGFloat BabySystemVersion(void){
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

/// 获取非空字符串
NSString *BabyToString(id obj){
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }else if ([obj isKindOfClass:[NSNumber class]]){
        NSNumber *number = (NSNumber *)obj;
        return number.stringValue;
    }
    return @"";
}

/// 快速获取主屏幕
UIWindow *BabyKeyWindow(void){
    return [UIApplication sharedApplication].keyWindow;
}
/// 快速获取屏幕宽度
CGFloat BabyScreen(void){
    return [UIScreen mainScreen].bounds.size.width;
}
/// 快速获取屏幕高度
CGFloat BabyScreenHeight(void){
    return [UIScreen mainScreen].bounds.size.height;
}
/// 快速设置view圆角
void BabyViewRadius(UIView *view,float radius){
    [view.layer setCornerRadius:radius];
    [view.layer setMasksToBounds:YES];
}
/// 快速设置view圆角
void BabyViewBorder(UIView *view,float radius,float border,UIColor *borderColor){
    [view.layer setCornerRadius:radius];
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:border];
    [view.layer setBorderColor:[borderColor CGColor]];
}


#pragma mark - UI

+(void)radius:(UIView *)view radius:(CGFloat)radius{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}
+(void)radius:(UIView *)view radius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    [self radius:view radius:radius];
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
}

#pragma mark - UILabel
+(UILabel *)label{
    return [[UILabel alloc]initWithFrame:CGRectZero];
}
+(UILabel *)labelFrame:(CGRect)frame{
    UILabel *label = [self label];
    label.frame = frame;
    return label;
}
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text{
    UILabel *label = [self labelFrame:frame];
    label.text = text;
    return label;
}
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor{
    UILabel *label = [self labelFrame:frame text:text];
    label.textColor = textColor;
    return label;
}
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize{
    UILabel *label = [self labelFrame:frame text:text textColor:textColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize bold:(BOOL)bold{
    UILabel *label = [self labelFrame:frame text:text textColor:textColor];
    if (bold) {
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    return label;
}
+(UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [self labelFrame:frame text:text textColor:textColor fontSize:fontSize];
    label.textAlignment = textAlignment;
    return label;
}

#pragma mark - UIButton

+(UIButton *)button{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame{
    UIButton *button = [self button];
    button.frame = frame;
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title{
    UIButton *button = [self buttonFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *button = [self buttonFrame:frame title:title];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}

+(UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame title:title titleColor:titleColor];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame title:title titleColor:titleColor target:target selector:selector];
    [self radius:button radius:radius];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius title:(NSString *)title titleColor:(UIColor *)titleColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor target:(id)target  selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame radius:radius title:title titleColor:titleColor target:target selector:selector];
    [self radius:button radius:radius borderWidth:borderWidth borderColor:borderColor];
    return button;
}

+(UIButton *)buttonFrame:(CGRect)frame image:(id)image{
    UIButton *button = [self buttonFrame:frame];
    if ([image isKindOfClass:[UIImage class]]) {
        [button setImage:image forState:UIControlStateNormal];
    }else if([image isKindOfClass:[NSString class]]){
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame image:(id)image target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame image:image];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame bgImage:(id)bgImage target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame];
    if ([bgImage isKindOfClass:[UIImage class]]) {
        [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    }else if([bgImage isKindOfClass:[NSString class]]){
        [button setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    }
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame image:(id)image selectedImage:(id)selectedImage target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame image:image target:target selector:selector];
    if ([selectedImage isKindOfClass:[UIImage class]]) {
        [button setBackgroundImage:selectedImage forState:UIControlStateNormal];
    }else if([selectedImage isKindOfClass:[NSString class]]){
        [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateNormal];
    }
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame image:(id)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame image:image target:target selector:selector];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius bgImage:(id)bgImage target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame bgImage:bgImage target:target selector:selector];
    [self radius:button radius:radius];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius image:(id)image target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame image:image target:target selector:selector];
    [self radius:button radius:radius];
    return button;
}
+(UIButton *)buttonFrame:(CGRect)frame radius:(CGFloat)radius image:(id)image selectedImage:(id)selectedImage target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame image:image selectedImage:selectedImage target:target selector:selector];
    [self radius:button radius:radius];
    return button;
}

+(UIButton *)buttonFrame:(CGRect)frame image:(id)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat)fontsize buttonType:(BabyButtonType)type padding:(CGFloat)padding target:(id)target selector:(SEL)selector{
    UIButton *button = [self buttonFrame:frame image:image title:title titleColor:titleColor target:target selector:selector];
    button.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    button.baby_buttonType = type;
    button.baby_padding = padding;
    return button;
}

#pragma mark - UIImageView

+(UIImageView *)imageView{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    return imageView;
}
+(UIImageView *)imageViewFrame:(CGRect)frame{
    UIImageView *imageView = [self imageView];
    imageView.frame = frame;
    return imageView;
}
+(UIImageView *)imageViewFrame:(CGRect)frame image:(id)image{
    UIImageView *imageView = [self imageViewFrame:frame];
    if ([image isKindOfClass:[UIImage class]]) {
        UIImage *img = image;
        image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        imageView.image = image;
    }else if([image isKindOfClass:[NSString class]]){
        UIImage *img = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        imageView.image = img;
    }
    return imageView;
}
+(UIImageView *)imageViewFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    UIImageView *imageView = [self imageViewFrame:frame];
    imageView.backgroundColor = color;
    return imageView;
}
+(UIImageView *)imageViewFrame:(CGRect)frame image:(id)image radius:(CGFloat)radius{
    UIImageView *imageView = [self imageViewFrame:frame image:image];
    [self radius:imageView radius:radius];
    return imageView;
}

#pragma mark - UITextField


+(UITextField *)textFieldFrame:(CGRect)frame backgroundImage:(id)image placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode{
    UITextField *field = [[UITextField alloc]initWithFrame:frame];
    if ([image isKindOfClass:[UIImage class]]) {
        field.background = image;
    }else if([image isKindOfClass:[NSString class]]){
        field.background = [UIImage imageNamed:image];
    }
    field.placeholder = placeholder;
    if (text.length) {
        field.text = text;
    }
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    return field;
}
+(UITextField *)textFieldFrame:(CGRect)frame backgroundImage:(id)image placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate{
    UITextField *field =  [self textFieldFrame:frame backgroundImage:image placeholder:placeholder text:text clearMode:clearButtonMode];
    field.delegate = delegate;
    return field;
}
+(UITextField *)textFieldFrame:(CGRect)frame backgroundImage:(id)image placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType secureTextEntry:(BOOL)secureTextEntry{
    UITextField *field =  [self textFieldFrame:frame backgroundImage:image placeholder:placeholder text:text clearMode:clearButtonMode delegate:delegate];
    field.keyboardType = keyboardType;
    field.returnKeyType = returnKeyType;
    field.secureTextEntry = secureTextEntry;
    return field;
}

+(UITextField *)textFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode{
    UITextField *field = [[UITextField alloc]initWithFrame:frame];
    field.placeholder = placeholder;
    if (text.length) {
        field.text = text;
    }
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    return field;
}
+(UITextField *)textFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate{
    UITextField *field =  [self textFieldFrame:frame placeholder:placeholder text:text clearMode:clearButtonMode];
    field.delegate = delegate;
    return field;
}
+(UITextField *)textFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text clearMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType secureTextEntry:(BOOL)secureTextEntry{
    UITextField *field =  [self textFieldFrame:frame placeholder:placeholder text:text clearMode:clearButtonMode delegate:delegate];
    field.keyboardType = keyboardType;
    field.returnKeyType = returnKeyType;
    field.secureTextEntry = secureTextEntry;
    return field;
}


#pragma mark - UITableView

+(UITableView *)tableViewFrame:(CGRect)frame delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource style:(UITableViewStyle)style{
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.frame = frame;
    return tableView;
}

+(UITableView *)tableViewFrame:(CGRect)frame delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource style:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle{
    UITableView *tableView = [self tableViewFrame:frame delegate:delegate dataSource:dataSource style:style];
    tableView.separatorStyle = separatorStyle;
    return tableView;
}

#pragma mark - UIAlertViewController

+(UIAlertController *)alertControllerTitle:(NSString *)title message:(NSString *)message{
    void(^buttonBlock)(NSInteger tag);
    UIAlertController *alertVC = [self alertControllerStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:@"确定" buttonTitleArray:@[] buttonBlock:buttonBlock];
    return alertVC;
}

+(UIAlertController *)alertControllerTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle{
    void(^buttonBlock)(NSInteger tag);
    UIAlertController *alertVC = [self alertControllerStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:cancelTitle buttonTitleArray:@[] buttonBlock:buttonBlock];
    return alertVC;
}

+(UIAlertController *)alertControllerTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitleArray:(NSArray <NSString *>*)buttonTitleArray buttonBlock:(void(^)(NSInteger tag))buttonBlock{
    UIAlertController *alertVC = [self alertControllerStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:cancelTitle buttonTitleArray:buttonTitleArray buttonBlock:buttonBlock];
    return alertVC;
}

///UIAlertController弹窗，自定义弹窗样式 取消按钮，自定义按钮个数，buttonBlock回调中的tag顺序标记按钮事件
+(UIAlertController *)alertControllerStyle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitleArray:(NSArray <NSString *>*)buttonTitleArray  buttonBlock:(void(^)(NSInteger tag))buttonBlock{
    __block UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alertVC.title = title;
    alertVC.message = message;
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        buttonBlock(buttonTitleArray.count);//最后一个index是取消
        NSLog(@"取消按钮index为%ld",buttonTitleArray.count);
        [alertVC dismissViewControllerAnimated:YES completion:nil];
        alertVC = nil;
    }];
    [alertVC addAction:cancelAction];
    
    for (int i = 0; i<buttonTitleArray.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            buttonBlock(i);
            [alertVC dismissViewControllerAnimated:YES completion:nil];
            alertVC = nil;
        }];
        [alertVC addAction:action];
    }
    return alertVC;
}

@end
