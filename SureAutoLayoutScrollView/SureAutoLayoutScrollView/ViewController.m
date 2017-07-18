//
//  ViewController.m
//  SureAutoLayoutScrollView
//
//  Created by 刘硕 on 2017/7/14.
//  Copyright © 2017年 刘硕. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "SureAutoLayoutScrollView.h"
@interface ViewController ()
@property (nonatomic, strong) SureAutoLayoutScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[SureAutoLayoutScrollView alloc]init];
    _scrollView.imageArr = @[@"IMG_1018.JPG",@"IMG_0857.JPG",@"IMG_0856.JPG"];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
