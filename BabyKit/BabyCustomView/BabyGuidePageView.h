//
//  BabyGuidePageView.h
//

#import <UIKit/UIKit.h>

@interface BabyGuidePageView : UIView<UIScrollViewDelegate>

typedef void(^BabyGuidePageCompleteBlock)(void);

/// 点击进入app按钮
@property (nonatomic,strong) UIButton *enterButton;
/// 点击进入app按钮-按钮标题
@property (nonatomic,copy) NSString *enterTitle;
/// 跳过按钮
@property (nonatomic,strong) UIButton *skipButton;
/// 点击进入app按钮-按钮标题
@property (nonatomic,copy) NSString *skipTitle;
/// 滚动页滚动下标
@property UIPageControl *imagePageControl;
/// 引导滚动页
@property UIScrollView  *guidePageView;

@property (nonatomic,copy) BabyGuidePageCompleteBlock completeBlock;

+ (BabyGuidePageView *)initWithFrame:(CGRect)frame WithImages:(NSArray *)images completeBlock:(BabyGuidePageCompleteBlock)completeBlock;

/**
 *  @brief 引导页view创建
     //HomePage
     if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunchAPP"]) {
     [[NSUserDefaults standardUserDefaults] setObject:@"isFirstLaunchAPP" forKey:@"isFirstLaunchAPP"];
     //引导页图片数组
     NSArray *images =  @[[UIImage imageNamed:@"image1.jpg"],[UIImage imageNamed:@"image2.jpg"],[UIImage imageNamed:@"image3.jpg"],[UIImage imageNamed:@"image4.jpg"],[UIImage imageNamed:@"image5.jpg"]];
     //创建引导页视图
     BabyGuidePageView *pageView = [BabyGuidePageView initWithFrame:self.view.bounds WithImages:images completeBlock:^{
     NSLog(@"进入app主页");
     }];
     //假如是taBabyarcontroller,就添加到taBabyarcontroller.view中,
     [self.navigationController.view addSubview:pageView];
     }
 */
- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images completeBlock:(BabyGuidePageCompleteBlock)completeBlock;


@end
