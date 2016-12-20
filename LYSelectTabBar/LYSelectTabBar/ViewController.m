//
//  ViewController.m
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "ViewController.h"
#import "LYSelectTabBar.h"

@interface ViewController ()<LYSelectTabBarDelegate>

@property (nonatomic,strong) LYSelectTabBar *selectBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.selectBar];
    [self.selectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.height.equalTo(@(80));
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - getter and setter
- (LYSelectTabBar *)selectBar{
    if(!_selectBar){
        _selectBar = [[LYSelectTabBar alloc]initTitles:@[@"店铺首页",@"全部宝贝",@"新品上架",@"微淘动态"] images:@[@"tab1",@"tab2",@"tab3",@"tab4"] selectImages:@[@"tab1-on",@"tab2-on",@"tab3-on",@"tab4-on"] indicatorImage:nil];
        _selectBar.delegate = self;
    }
    
    return _selectBar;
}

@end
