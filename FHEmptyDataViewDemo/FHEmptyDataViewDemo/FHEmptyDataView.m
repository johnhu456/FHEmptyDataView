//
//  FHEmptyDataView.m
//  FHEmptyDataViewDemo
//
//  Created by MADAO on 16/7/26.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHEmptyDataView.h"

@interface FHEmptyDataView()
{
    struct {
        unsigned int imageForIconFlag: 1;
        unsigned int sizeForIconFlag: 1;
        unsigned int vertialOffsetForIconFlag: 1;
        unsigned int titleForDescriptionFlag: 1;
        unsigned int heightBetweenTitleAndImvFlag: 1;
        unsigned int customDescriptionTag:1;
    }_setSourceFlag;
}
@property (nonatomic, strong) UIImageView *imvIcon;

@property (nonatomic, strong, readwrite) UILabel *lblTitle;

@property (nonatomic, strong) UIButton *lblButton;
@end

static CGFloat const kIconWidthDefault = 50.f;
static CGFloat const kTitleHeightDefault = 30.f;
static CGFloat const kSpaceTitleDefault = 15.f;

@implementation FHEmptyDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setupSubViews];
    }
    return self;
}

#pragma mark - UserInterface

- (void)setupSubViews
{
    self.imvIcon = [[UIImageView alloc] init];
    self.imvIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imvIcon];
    
    self.lblTitle = [[UILabel alloc] init];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.textColor = [UIColor lightGrayColor];
    self.lblTitle.font = [UIFont systemFontOfSize:24];
    [self addSubview:self.lblTitle];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    /**SetIconImageView*/
    self.imvIcon.center = self.center;
    self.imvIcon.frame = CGRectMake(self.imvIcon.frame.origin.x , self.imvIcon.frame.origin.y, kIconWidthDefault, kIconWidthDefault);
    if (_setSourceFlag.imageForIconFlag){
        UIImage *iconImage = [_setSource imageForIconImageViewInEmptyDataView:self];
        self.imvIcon.image = iconImage;
    }
    if (_setSourceFlag.sizeForIconFlag) {
        CGSize imvIconSize = [_setSource sizeForIconImageViewInEmptyDataView:self];
        self.imvIcon.frame = CGRectMake(0, 0, imvIconSize.width, imvIconSize.height);
    }
    if (_setSourceFlag.vertialOffsetForIconFlag) {
        CGFloat imvIconVertical = [_setSource vertialOffSetForIconImageViewInEmptyDataView:self];
        self.imvIcon.frame = CGRectMake(0, imvIconVertical, self.imvIcon.frame.size.width, self.imvIcon.frame.size.height);
    }
    
    /**SetTitleLabel*/
    self.lblTitle.frame = CGRectMake(0, CGRectGetMaxY(self.imvIcon.frame) + kSpaceTitleDefault, self.frame.size.width, kTitleHeightDefault);
    if (_setSourceFlag.titleForDescriptionFlag) {
        NSString *titleString = [_setSource titleForDescriptionTitleInEmptyDataView:self];
        self.lblTitle.text = titleString;
    }
    if (_setSourceFlag.heightBetweenTitleAndImvFlag) {
        CGFloat spaceHeight = [_setSource spaceHeightBetweenTitleAndIconImageViewInEmptyDataView:self];
        self.lblTitle.frame = CGRectMake(0, self.lblTitle.frame.origin.y + spaceHeight, self., <#CGFloat height#>)
    }
}

#pragma mark - EmptyDataSetSource

- (void)setSetSource:(id<FHEmptyDataSetSource>)setSource
{
    _setSource = setSource;
    if ([_setSource respondsToSelector:@selector(imageForIconImageViewInEmptyDataView:)]) {
        _setSourceFlag.imageForIconFlag = YES;
    }
    if ([_setSource respondsToSelector:@selector(sizeForIconImageViewInEmptyDataView:)]) {
        _setSourceFlag.sizeForIconFlag = YES;
    }
    if ([_setSource respondsToSelector:@selector(vertialOffSetForIconImageViewInEmptyDataView:)]) {
        _setSourceFlag.vertialOffsetForIconFlag = YES;
    }
    if ([_setSource respondsToSelector:@selector(titleForDescriptionTitleInEmptyDataView:)]) {
        _setSourceFlag.titleForDescriptionFlag = YES;
    }
    if ([_setSource respondsToSelector:@selector(spaceHeightBetweenTitleAndIconImageViewInEmptyDataView:)]) {
        _setSourceFlag.heightBetweenTitleAndImvFlag = YES;
    }
    
}

@end
