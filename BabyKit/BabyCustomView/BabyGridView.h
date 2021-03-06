//
//  BabyGridView.h
//  OMyCar
//
//  Created by li hua on 2017/5/7.
//  Copyright © 2016年 黎迅华. All rights reserved.
//

#import <UIKit/UIKit.h>


///====================================================================
/// 九宫格布局类
///====================================================================



///====================================================================
/// BabyGridViewDatasource
///====================================================================

@protocol BabyGridViewDatasource

@required

///九宫格,单位宽度
-(CGFloat)gridViewUnitWidth;

///九宫格，单位高度
-(CGFloat)gridViewUnitHeight;

///九宫格，元素与视图顶部距离
-(CGFloat)gridViewMarginTop;

///九宫格，元素与视图左侧距离
-(CGFloat)gridViewMarginLeft;

///九宫格，元素与视图右侧距离
-(CGFloat)gridViewMarginRight;

///九宫格，元素y轴的间隔高度
-(CGFloat)gridViewUnitMarginY;

///九宫格，视图元素的列数
-(NSInteger)gridViewColumnCount;

///九宫格，视图元素总个数
-(NSInteger)gridViewAllCount;

///九宫格，视图元素图标图片数组
-(NSArray *)gridViewImageArray;

@optional

///九宫格，视图元素标题数组
-(NSArray *)gridViewTitleArray;

///九宫格，视图元素选中图片数组
-(NSArray *)gridViewSelectedImageArray;

@end

///====================================================================
/// BabyGridViewDelegate
///====================================================================

@protocol BabyGridViewDelegate

@optional

///点击视图元素
-(void)didSelectedUnitbutton:(UIButton *)button;

///取消点击视图元素
-(void)deSelectedUnitbutton:(UIButton *)button;

@end

@interface BabyGridView : UIView

@property (nonatomic,weak) id<BabyGridViewDatasource> dataSource;
@property (nonatomic,weak) id<BabyGridViewDelegate> delegate;
@property (nonatomic,strong) UIButton * selectedButton;


-(instancetype)initWithFrame:(CGRect)frame
                  dataSource:(id<BabyGridViewDatasource>)dataSource
                    delegate:(id<BabyGridViewDelegate>)delegate;



@end
