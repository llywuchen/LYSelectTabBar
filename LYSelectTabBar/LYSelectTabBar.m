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
@property (nonatomic, strong)   UIImageView *indicatorImageView;// 指示器

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
        make.centerX.equalTo(self).dividedBy(4);
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
    if(index == _currentIndex) return;
    [self doSelectAcionAtIndex:_currentIndex];
    [self doSelectAcionAtIndex:index];
    _currentIndex = index;
    
    [self layoutIfNeeded];
    [self.indicatorImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(@(_indicatorHeight));
        make.width.equalTo(self).dividedBy(_selectViewArray.count);
        make.centerX.equalTo(self.mas_centerX).multipliedBy((_currentIndex*2.f+1.f)/4.f);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
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
