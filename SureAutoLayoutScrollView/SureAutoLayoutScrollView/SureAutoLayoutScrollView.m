//
//  SureAutoLayoutScrollView.m
//  SureAutoLayoutScrollView
//
//  Created by 刘硕 on 2017/7/14.
//  Copyright © 2017年 刘硕. All rights reserved.
//

#import "SureAutoLayoutScrollView.h"
#import <Masonry.h>
@interface SureAutoLayoutScrollView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@end
@implementation SureAutoLayoutScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
}

- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIView*)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    for (NSInteger i = 0; i < imageArr.count; i++) {
        UIImageView *tapImageView = [self viewWithTag:1000 + i];
        if (!tapImageView) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:_imageArr[i]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.tag = 1000 + i;
            [_contentView addSubview:imageView];
        } else {
            tapImageView.image = [UIImage imageNamed:_imageArr[i]];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_scrollView);
        make.centerY.equalTo(_scrollView.mas_centerY).offset(0);
        make.width.equalTo(@(self.bounds.size.width * _imageArr.count));
    }];
    
    CGFloat space = 0;
    //用于接收上一控件
    UIImageView *lastImageView;
    for (NSInteger i = 0; i < _imageArr.count; i++) {
        UIImageView *imageView = [self viewWithTag:1000 + i];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentView.mas_top).offset(space);
            make.bottom.equalTo(_contentView.mas_bottom).offset(space);
            if (lastImageView) {
                //如果存在上一控件，设置与上一控件右边缘约束，设置等宽
                make.left.equalTo(lastImageView.mas_right).offset(space);
                make.width.equalTo(lastImageView.mas_width);
            } else {
                //不存在上一控件，设置与父视图左边缘约束，设置宽度为当前视图宽度
                make.left.equalTo(_contentView.mas_left).offset(space);
                make.width.equalTo(@(self.bounds.size.width));
            }
            if (i == _imageArr.count - 1) {
                //若为最后一个控件，设置与父视图右边缘约束
                make.right.equalTo(_contentView.mas_right).offset(space);
            }
        }];
        //接收上一控件
        lastImageView = imageView;
    }

}

@end
