//
//  LYSelectTabBar.h
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYSelectTabBar;

@protocol LYSelectTabBarDelegate <NSObject>

@optional
- (void)tabBar:(LYSelectTabBar *)tabBar willSelectButtonFrom:(NSInteger)from to:(NSInteger)to;
- (void)tabBar:(LYSelectTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface LYSelectTabBar : UIView

@property (nonatomic,weak) id<LYSelectTabBarDelegate> delegate;

@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *selectedColor;     // 选中的文字颜色
@property (nonatomic,strong) UIColor *unSelectedColor;   // 非选中的文字颜色

@property (nonatomic,strong) UIImage *indicatorImage;
@property (nonatomic,assign) CGFloat indicatorHeight;

@property (nonatomic,assign,readonly) NSInteger currentIndex;

@property (nonatomic,assign) BOOL animate;

///**
// *  根据标题添加内部按钮 单个
// */
//- (void)addTabButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage;
///**
// *  根据标题添加内部按钮 多个
// */
//- (void)addTabButtonWithTitles:(NSArray<NSString *> *)titles imageArray:(NSArray *)imageArray selImageArray:(NSArray *)selImageArray;


/**
 *  设置某个tab的badge value
 *
 *  @param badgeValue 字符串类型的数值
 *  @param index      位置
 */
- (void)setBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index;

/**
 *  用来手动设置点击的按钮的位置
 */
- (void)setSelectedIndex:(NSInteger)index;

- (instancetype)initTitles:(NSArray *)titles images:(NSArray *)images selectImages:(NSArray *)selectImages indicatorImage:(NSString *)indicatorImage;

@end
