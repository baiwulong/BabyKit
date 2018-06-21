//
//  BBGuidePageView.m

#import "BBGuidePageView.h"

@implementation BBGuidePageView

+ (BBGuidePageView *)initWithFrame:(CGRect)frame WithImages:(NSArray *)images completeBlock:(TMGuidePageCompleteBlock)completeBlock{
   return [[BBGuidePageView alloc] initWithFrame:frame WithImages:images completeBlock:completeBlock];
}


- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images completeBlock:(TMGuidePageCompleteBlock)completeBlock{
	self = [super initWithFrame:frame];
	if (self) {

        //设置block回调
        self.completeBlock = completeBlock;

		//设置引导视图的scrollview
		self.guidePageView = [[UIScrollView alloc]initWithFrame:frame];
		self.guidePageView.backgroundColor = [UIColor redColor];
		self.guidePageView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*images.count, [UIScreen mainScreen].bounds.size.height);
		self.guidePageView.bounces = NO;
		self.guidePageView.pagingEnabled = YES;
		self.guidePageView.showsHorizontalScrollIndicator = NO;
		self.guidePageView.delegate = self;
		[self addSubview:_guidePageView];
		
		//设置引导页上的跳过按钮
		self.skipButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.8, [UIScreen mainScreen].bounds.size.width*0.1, 50, 25)];
        if (!self.skipTitle) {
            self.skipTitle = @"跳过";
        }
		[self.skipButton setTitle:self.skipTitle forState:UIControlStateNormal];
		[self.skipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
		self.skipButton.backgroundColor = [UIColor grayColor];
		self.skipButton.layer.cornerRadius = 5;
		[self.skipButton addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.skipButton];
		
		//添加在引导视图上的多张引导图片
		for (int i=0; i<images.count; i++) {
			UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            if ([images[i] isKindOfClass:[NSString class]]) {
                imageView.image = [UIImage imageNamed:images[i]];
            }else{
                imageView.image = images[i];
            }
			[self.guidePageView addSubview:imageView];
			//设置在最后一张图片上显示进入体验按钮
			if (i == images.count-1) {
				imageView.userInteractionEnabled = YES;
				UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.3, [UIScreen mainScreen].bounds.size.height*0.8, [UIScreen mainScreen].bounds.size.width*0.4, 50)];
                if (!self.enterTitle) {
                    self.enterTitle = @"开始体验";
                }
				[btn setTitle:self.enterTitle forState:UIControlStateNormal];
				btn.titleLabel.font = [UIFont systemFontOfSize:21];
				[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
				btn.backgroundColor = [UIColor colorWithRed:0.188 green:0.671 blue:0.271 alpha:1.000];
				[btn addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
				[imageView addSubview:btn];
			}
			
		}
		//设置引导页上的页面控制器
		self.imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.1, [UIScreen mainScreen].bounds.size.height*0.9, [UIScreen mainScreen].bounds.size.width*0.9, 50)];
		self.imagePageControl.currentPage = 0;
		self.imagePageControl.numberOfPages = images.count;
		self.imagePageControl.pageIndicatorTintColor = [UIColor grayColor];
		self.imagePageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
		[self addSubview:self.imagePageControl];
	}
	return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {
	int page = scrollview.contentOffset.x / scrollview.frame.size.width;
	[self.imagePageControl setCurrentPage:page];
}

- (void)btn_Click:(UIButton *)sender{
	[UIView animateWithDuration:0.5 animations:^{
		self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.completeBlock();
    }];
}


@end
