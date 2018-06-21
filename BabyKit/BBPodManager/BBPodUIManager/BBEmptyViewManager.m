//
//  BBEmptyViewManager.m
//  TMKit
//
//  Created by li hua on 2016/6/11.
//

#import "BBEmptyViewManager.h"

@interface BBEmptyViewManager()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

/**
 --------------------------------------------------------------
 `BBEmptyConfig`配置项
 --------------------------------------------------------------
 */

@implementation BBEmptyConfig

#pragma mark - 设置默认config对象

+(BBEmptyConfig *)defaultConfig{
    
    BBEmptyConfig *config = [[BBEmptyConfig alloc]init];
    config.contentSpaceHeight = 14.0f;
    config.bgColor = [UIColor whiteColor];
    //图片
    config.contentImage = [self createRandomColorImageWithframe:CGRectMake(0, 0, 150, 150)];
   
    //标题文本属性
    config.contentTitle = @"默认显示的标题，需要替换`BBEmptyConfig`对象中的`contentTitle`";
    config.contentTitleColor = [UIColor darkGrayColor];
    config.contentTitlefontSize = 18.0f;
    config.contentTitleAttribute  = [config getTitleAttributeColor:config.contentTitleColor fontSize: config.contentTitlefontSize];

    //详情文本属性
    config.contentDetail = @"默认显示的详细描述，需要替换`BBEmptyConfig`对象中的`contentDetail`";
    config.contentDetailColor = [UIColor lightGrayColor];
    config.contentDetailFontSize = 14.0f;
    config.contentDetailAttribute = [config getTitleAttributeColor:config.contentDetailColor fontSize: config.contentDetailFontSize];

    ///点击按钮文本属性
    config.contentButtonTitle = @"点击刷新";
    config.contentButtonTitleColor = [UIColor orangeColor];
    config.contentButtonTitleFontSize = 14.0f;
    config.contentButtonTitleAttribute = [config getTitleAttributeColor:config.contentButtonTitleColor fontSize: config.contentButtonTitleFontSize];
   
    return config;
    
}
#pragma mark - 设置属性，重新赋值文本的Attribute

//标题文本设置
-(void)setContentTitlefontSize:(CGFloat)contentTitlefontSize{
    _contentTitlefontSize = contentTitlefontSize;
    if(_contentTitleColor){
        _contentButtonTitleAttribute = [self getTitleAttributeColor:_contentTitleColor fontSize:_contentTitlefontSize];
    }
}

-(void)setContentTitleColor:(UIColor *)contentTitleColor{
    _contentTitleColor = contentTitleColor;
    _contentButtonTitleAttribute = [self getTitleAttributeColor:_contentTitleColor fontSize:_contentTitlefontSize];
}

//详情文本设置
-(void)setContentDetailFontSize:(CGFloat)contentDetailFontSize{
    _contentDetailFontSize = contentDetailFontSize;
    if(_contentDetailColor){
        _contentDetailAttribute = [self getTitleAttributeColor:_contentDetailColor fontSize:_contentDetailFontSize];
    }
}

-(void)setContentDetailColor:(UIColor *)contentDetailColor{
    _contentDetailColor = contentDetailColor;
    _contentDetailAttribute = [self getTitleAttributeColor:_contentDetailColor fontSize:_contentDetailFontSize];
}

//点击文本设置
-(void)setContentButtonTitleFontSize:(CGFloat)contentButtonTitleFontSize{
    _contentButtonTitleFontSize = contentButtonTitleFontSize;
    if(_contentButtonTitleColor){
        _contentButtonTitleAttribute = [self getTitleAttributeColor:_contentButtonTitleColor fontSize:_contentButtonTitleFontSize];
    }
}

-(void)setContentButtonTitleColor:(UIColor *)contentButtonTitleColor{
    _contentButtonTitleColor = contentButtonTitleColor;
    _contentButtonTitleAttribute = [self getTitleAttributeColor:_contentButtonTitleColor fontSize:_contentButtonTitleFontSize];
}

#pragma mark - tools工具方法

-(NSDictionary *)getTitleAttributeColor:(UIColor *)color fontSize:(CGFloat)fontSize{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                           NSForegroundColorAttributeName:color,
                           NSParagraphStyleAttributeName:paragraph
                           };
    return attr;
}

+ (UIImage *)createRandomColorImageWithframe:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random() %256/256.0 blue:arc4random() %256/256.0 alpha:1];
    //绘制图片
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end


/**
 --------------------------------------------------------------
 `BBEmptyViewManager`空白页面-管理器
 --------------------------------------------------------------
 */

@implementation BBEmptyViewManager

+(BBEmptyViewManager *)emptyView:(UIScrollView *)emptyView config:(BBEmptyConfig *)config buttonOnClick:(BBEmptyOnClick)buttonOnClick viewOnClick:(BBEmptyOnClick)viewOnClick
{
    BBEmptyViewManager *manager = [[BBEmptyViewManager alloc]init];
    //去除分割线技巧
    UITableView *tableView;
    if([emptyView isKindOfClass:[UITableView class]]){
        tableView = (UITableView *)emptyView;
        tableView.tableFooterView = [UIView new];
    }
    //设置config
    manager.config = config != nil ? config : [BBEmptyConfig defaultConfig];
    manager.config.contentView = [emptyView isKindOfClass:[UITableView class]] ? tableView : emptyView;
    //设置事件
    manager.config.buttonOnClick = buttonOnClick;
    manager.config.viewOnClick = viewOnClick;
    //设置代理
    manager.config.contentView.emptyDataSetSource = manager;
    manager.config.contentView.emptyDataSetDelegate = manager;
    return manager;
}


+(BBEmptyViewManager *)emptyView:(UIScrollView *)emptyView
                contentImageName:(id)contentImageName
                 buttonImageName:(id)buttonImageName
                           title:(NSString *)title
                          detail:(NSString *)detail
                   buttonOnClick:(BBEmptyOnClick)buttonOnClick
                     viewOnClick:(BBEmptyOnClick)viewOnClick
{
    UIImage *contentImage;
    if([contentImageName isKindOfClass:[NSString class]]){
        contentImage = [UIImage imageNamed:contentImageName];
    }else if([contentImageName isKindOfClass:[UIImage class]]) {
        contentImage = contentImageName;
    }else{
        contentImage = nil;
    }
    
    UIImage *buttonImage;
    if([buttonImage isKindOfClass:[NSString class]]){
        buttonImage = [UIImage imageNamed:buttonImageName];
    }else if([buttonImageName isKindOfClass:[UIImage class]]) {
        buttonImage = buttonImageName;
    }else{
        buttonImage = nil;
    }
    BBEmptyConfig *config = [BBEmptyConfig defaultConfig];
    config.contentView = emptyView;
    config.contentImage = contentImage;
    config.clickButtonImage = buttonImage;
    config.contentTitle = title;
    config.contentDetail = detail;
    BBEmptyViewManager *manager = [self emptyView:emptyView config:config buttonOnClick:buttonOnClick viewOnClick:viewOnClick];
    return manager;
}


-(void)reloadEmptyView{
    [self.config.contentView reloadEmptyDataSet];
}

#pragma mark - DZNEmptyDataSetSource

//配置图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.config.contentImage;
}

//标题配置
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if(self.config.contentTitle){
        NSString *title = self.config.contentTitle;
        return [[NSAttributedString alloc] initWithString:title attributes:self.config.contentTitleAttribute];
    }
    return nil;
}

//详情说明
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if( self.config.contentDetail){
        NSString *contentDetail = self.config.contentDetail;
        return [[NSAttributedString alloc] initWithString:contentDetail attributes:self.config.contentDetailAttribute];
    }
    return nil;
}

///标题按钮配置
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if(self.config.contentButtonTitle){
        return [[NSAttributedString alloc] initWithString:self.config.contentButtonTitle attributes:self.config.contentButtonTitleAttribute];
    }
    return nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return self.config.bgColor;
}

//按钮图片配置
-(UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return self.config.clickButtonImage;
}

#pragma mark - DZNEmptyDataSetDelegate

//view点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if(self.config.viewOnClick){
        self.config.isLoading = YES;
        self.config.viewOnClick();
        [self reloadEmptyView];
        self.config.isLoading = NO;
    }
}

//偏移设置
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return self.config.offset;
}

//按钮点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if(self.config.buttonOnClick){
        self.config.isLoading = YES;
        self.config.buttonOnClick();
        [self reloadEmptyView];
        self.config.isLoading = NO;
    }
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.config.isLoading;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark 图片旋转动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    if(self.config.animation){
        return self.config.animation;
    }
    //默认动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//竖值
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return self.config.contentSpaceHeight;
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.config.contentView.contentOffset = CGPointZero;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return self.config.customView;
}

@end
