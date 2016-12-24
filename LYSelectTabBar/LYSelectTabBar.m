//
//  LYSelectTabBar.m
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYSelectTabBar.h"
#import "LYSelectView.h"

@interface LYSelectTabBar ()

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *selImages;
@property (nonatomic,strong) NSMutableArray<LYSelectView *> *selectViewArray;
@property (nonatomic,strong) UIImageView *indicatorImageView;// 指示器

@property (nonatomic,strong) MASConstraint *animataConstraint;

@end

@implementation LYSelectTabBar

- (instancetype)initTitles:(NSArray *)titles images:(NSArray *)images selectImages:(NSArray *)selectImages indicatorImage:(NSString *)indicatorImage{
    self = [self init];
    if(self){
        _titles = titles;
        _images = images;
        _selImages = selectImages;
        _indicatorImage = [UIImage imageNamed:indicatorImage];
        
        [self addTabButtonWithTitles:_titles imageArray:_images selImageArray:_selImages];
        [self addSubview:self.indicatorImageView];
        [self configureContraints];
        
        [self setSelectedIndex:0];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if(self){
        [self buildDefault];
    }
    return self;
}

- (void)buildDefault{
    _font = [UIFont systemFontOfSize:14];
    _selectedColor = [UIColor redColor];
    _unSelectedColor = [UIColor lightGrayColor];
    _indicatorHeight = 1;
    _animate = YES;
    _currentIndex = -1;
    _selectViewArray = [NSMutableArray array];
}

- (LYSelectView *)addTabButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage{
    LYSelectView *view = [[LYSelectView alloc]initWithTitle:title font:_font selImage:selImage unSelImage:image selColor:_selectedColor unSelColor:_unSelectedColor];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectViewTapAction:)]];
    [self addSubview:view];
    [_selectViewArray addObject:view];
    
    return view;
}

- (void)addTabButtonWithTitles:(NSArray<NSString *> *)titles imageArray:(NSArray *)imageArray selImageArray:(NSArray *)selImageArray{
    if(titles.count==0) return;
    BOOL needImage = titles.count<=imageArray.count;
    for(int i=0;i<titles.count;i++){
        LYSelectView *view = [self addTabButtonWithTitle:titles[i] image:needImage?[UIImage imageNamed:imageArray[i]]:nil selImage:needImage?[UIImage imageNamed:selImageArray[i]]:nil];
        view.tag = i;
    }
}


- (void)configureContraints{
    [_selectViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:5 tailSpacing:5];
    [_selectViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self);
    }];
    [_indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(@(_indicatorHeight));
        make.width.equalTo(self).dividedBy(_selectViewArray.count);
        self.animataConstraint = make.centerX.equalTo(self).dividedBy(4);
    }];
}

#pragma mark -
#pragma mark - getter and setter
- (UIImageView *)indicatorImageView{
    if(!_indicatorImageView){
        _indicatorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _indicatorImageView.image = _indicatorImage;
        _indicatorImageView.backgroundColor = _selectedColor;
    }
    return _indicatorImageView;
}

- (void)setSelectedIndex:(NSInteger)index{
    NSInteger from = _currentIndex;
    if(index == from) return;
    [self doSelectAcionAtIndex:index];
    _currentIndex = index;
    if(from == -1) return;
    [self doSelectAcionAtIndex:from];
    
    [self layoutIfNeeded];
    self.animataConstraint.centerOffset = CGPointMake(self.center.x*(_currentIndex*2.f)/4.f, self.indicatorImageView.center.y);
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)setFont:(UIFont *)font{
    _font = font;
    [self setTitleFontSize:font.pointSize];
}
#pragma mark -
#pragma mark -animation
- (void)setButtonImageAlpha:(CGFloat)alpha{
    for(LYSelectView *view in _selectViewArray){
        view.tabImageBtn.alpha = alpha;
    }
}

- (void)setTitleFontSize:(CGFloat)size{
    for(LYSelectView *view in _selectViewArray){
        view.tabButton.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setTitleOffset:(CGFloat)offset{
    for(LYSelectView *view in _selectViewArray){
        [view.tabButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view).offset(-10-offset);
        }];
    }
}

#pragma mark -
#pragma mark - action
- (void)selectViewTapAction:(UIGestureRecognizer *)sender{
    NSInteger from = _currentIndex;
    NSInteger index = sender.view.tag;
    if(self.delegate&&[self.delegate respondsToSelector:@selector(tabBar:willSelectButtonFrom:to:)]){
        [self.delegate tabBar:self willSelectButtonFrom:from to:index];
    }
    [self setSelectedIndex:index];
    if(self.delegate&&[self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]){
        [self.delegate tabBar:self didSelectButtonFrom:from to:index];
    }
}

- (void)doSelectAcionAtIndex:(NSInteger)index{
    if(index<0||index>=_selectViewArray.count) return;
    LYSelectView *view = _selectViewArray[index];
    [view doSelectAction];
}
@end
