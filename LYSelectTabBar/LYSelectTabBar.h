//
//  LYSelectTabBar.h
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYSelectTabBar;

typedef NS_ENUM(NSInteger,LYTabBatAssistStatus){
    LYTabBatAssist_Desc = 0,
    LYTabBatAssist_Asc,
    LYTabBatAssist_Nomal
};

@protocol LYSelectTabBarDelegate <NSObject>

@optional
- (void)tabBar:(LYSelectTabBar *)tabBar willSelectButtonFrom:(NSInteger)from to:(NSInteger)to toAssistStatus:(LYTabBatAssistStatus)status;
- (void)tabBar:(LYSelectTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to toAssistStatus:(LYTabBatAssistStatus)status;

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

- (instancetype)initTitles:(NSArray *)titles images:(NSArray *)images selectImages:(NSArray *)selectImages indicatorImage:(NSString *)indicatorImage;


- (void)setSelectedIndex:(NSInteger)index;
- (void)setButtonImageAlpha:(CGFloat)alpha;
- (void)setTitleFontSize:(CGFloat)size;
- (void)setTitleOffset:(CGFloat)offset;

- (void)addTabButtonAssistAtIndex:(NSInteger)index normalImage:(NSString *)normalImage descImage:(NSString *)descImage ascImage:(NSString *)ascImage;
/**
 *  设置某个tab的badge value
 *
 *  @param badgeValue 字符串类型的数值
 *  @param index      位置
 */
//- (void)setBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index;



@end
