//
//  BBGridView.m
//  OMyCar
//
//  Created by li hua on 2017/5/7.
//  Copyright © 2016年 黎迅华. All rights reserved.
//

#import "BBGridView.h"

@implementation BBGridView


-(instancetype)initWithFrame:(CGRect)frame
                  dataSource:(id<BBGridViewDatasource>)dataSource
                    delegate:(id<BBGridViewDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        if (dataSource && delegate) {
            self.dataSource = dataSource;
            self.delegate = delegate;
            [self createGridView];
        }
    }
    return self;
}

-(void)createGridView{
    // 每个元素的x的间距 = (总-左侧-右侧-全部元素长度)/（元素列数-1）
    CGFloat unitMarginX = (self.frame.size.width - [self.dataSource gridViewMarginLeft] -[self.dataSource gridViewMarginRight] - [self.dataSource gridViewUnitWidth] * [self.dataSource gridViewColumnCount]) / ([self.dataSource gridViewColumnCount] - 1);
    // 创建视图
    for (int i=0; i<[self.dataSource gridViewAllCount]; i++) {
        int column = i % [self.dataSource gridViewColumnCount];
        // 第几行
        int row = i / [self.dataSource gridViewColumnCount];
        // x
        CGFloat x =  [self.dataSource gridViewMarginLeft] + [self.dataSource gridViewUnitWidth] * column + column * unitMarginX;
        // y
        CGFloat y = [self.dataSource gridViewMarginTop] + [self.dataSource gridViewUnitHeight] * row + [self.dataSource gridViewUnitMarginY] * row;
        
        UIButton *unitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        unitButton.frame = CGRectMake(x, y, [self.dataSource gridViewUnitWidth], [self.dataSource gridViewUnitHeight]);
        if ([self.dataSource gridViewImageArray].count) {
            [unitButton setImage:[UIImage imageNamed:[self.dataSource gridViewImageArray][i]] forState:UIControlStateNormal];
        }
        if ([(id)self.dataSource respondsToSelector:@selector(gridViewSelectedImageArray)]) {
            if ([self.dataSource gridViewSelectedImageArray].count) {
                [unitButton setImage:[UIImage imageNamed:[self.dataSource gridViewSelectedImageArray][i]] forState:UIControlStateSelected];
            }
        }
        unitButton.selected = YES;
        if ([self.dataSource gridViewTitleArray].count) {
            [unitButton setTitle:[self.dataSource gridViewTitleArray][i] forState:UIControlStateNormal];

            NSString *title = [self.dataSource gridViewTitleArray][i];
            CGFloat image_w = unitButton.imageView.frame.size.width;
            CGFloat image_h = unitButton.imageView.frame.size.height;
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};  //指定字号
            CGRect titleRect = [title boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin |
                           NSStringDrawingUsesFontLeading attributes:dic context:nil];
            unitButton.titleLabel.font = [UIFont systemFontOfSize:12];
            UIEdgeInsets titleEdge = UIEdgeInsetsMake(10, -image_w, -image_h, 0);
            UIEdgeInsets imageEdge = UIEdgeInsetsMake(-titleRect.size.height , (unitButton.frame.size.width-image_w)/2, 0, 0);
            [unitButton setTitleEdgeInsets:titleEdge];
            [unitButton setImageEdgeInsets:imageEdge];
            [unitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            unitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [unitButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        }
        
        unitButton.tag = i;
        [unitButton addTarget:self action:@selector(unitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:unitButton];
    }
}

-(void)unitButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        if ([(id)self.delegate respondsToSelector:@selector(didSelectedUnitbutton:)]) {
            [self.delegate didSelectedUnitbutton:button];
        }
    }else{
        if ([(id)self.delegate respondsToSelector:@selector(deSelectedUnitbutton:)]) {
            [self.delegate deSelectedUnitbutton:button];
        }else  if ([(id)self.delegate respondsToSelector:@selector(didSelectedUnitbutton:)]) {
            [self.delegate didSelectedUnitbutton:button];
            button.selected = YES;
        }
    }
}

@end
