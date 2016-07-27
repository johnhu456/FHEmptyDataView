//
//  FHEmptyDataView.m
//  FHEmptyDataViewDemo
//
//  Created by MADAO on 16/7/26.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHEmptyDataView.h"



#pragma mark - FHEmptyDataDefaultSetSource Implemention

#pragma mark - FHEmptyDataView Implemention

@interface FHEmptyDataView()<UIGestureRecognizerDelegate>
{
    struct {
        unsigned int imageForIconFlag: 1;
        unsigned int sizeForIconFlag: 1;
        unsigned int vertialOffsetForIconFlag:1;
        unsigned int titleForDescriptionFlag:1;
        unsigned int heightBetweenTitleAndImvFlag:1;
        unsigned int titleForButtonFlag:1;
        unsigned int heightBetweenButtonAndTitleFlag:1;
    }_setSourceFlag;
    
    struct {
        unsigned int handleTapFlag : 1;
        unsigned int handleButtonOnClick : 1;
    }_delegateFlag;
}
@property (nonatomic, strong) UIImageView *imvIcon;

@property (nonatomic, strong, readwrite) UILabel *lblTitle;

@property (nonatomic, strong) UIButton *btnClick;
@end

static CGFloat const kIconWidthDefault = 100.f;
static CGFloat const kTitleHeightDefault = 30.f;
static CGFloat const kSpaceTitleDefault = 15.f;
static CGFloat const kButtonHeightDefault = 30.f;
static CGFloat const kSpaceButtonClick = 15.f;

@implementation FHEmptyDataView

- (instancetype)init
{
    if (self = [super init]){
        [self initialize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self setupSubViews];
    [self setupTapGesture];
}

#pragma mark - UserInterface

- (void)setupSubViews
{
    self.imvIcon = [[UIImageView alloc] init];
    self.imvIcon.backgroundColor = [UIColor clearColor];
    self.imvIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imvIcon];
    
    self.lblTitle = [[UILabel alloc] init];
    [self.lblTitle setBackgroundColor:[UIColor clearColor]];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    self.lblTitle.font = [UIFont systemFontOfSize:26];
    [self addSubview:self.lblTitle];
    
    
    self.btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnClick setBackgroundColor:[UIColor clearColor]];
    [self.btnClick setTitleColor:[UIColor colorWithWhite:0.6 alpha:1.0] forState:UIControlStateNormal];
    [self.btnClick.titleLabel setFont:[UIFont systemFontOfSize:17]];
    self.btnClick.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnClick addTarget:self action:@selector(handleButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnClick];
}

- (void)setupTapGesture
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer)];
    tapGestureRecognizer.delaysTouchesBegan = YES;
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    /**SetIconImageView*/
    self.imvIcon.center = self.center;
    self.imvIcon.frame = CGRectMake(self.imvIcon.frame.origin.x , self.imvIcon.frame.origin.y, kIconWidthDefault, kIconWidthDefault);
    if (_setSourceFlag.imageForIconFlag){
        UIImage *iconImage = [_setSource imageForIconImageViewInEmptyDataView:self];
        self.imvIcon.image = iconImage;
    }
    if (_setSourceFlag.sizeForIconFlag) {
        CGSize imvIconSize = [_setSource sizeForIconImageViewInEmptyDataView:self];
        self.imvIcon.frame = CGRectMake(self.imvIcon.frame.origin.x, self.imvIcon.frame.origin.y, imvIconSize.width, imvIconSize.height);
    }
    if (_setSourceFlag.vertialOffsetForIconFlag) {
        CGFloat imvIconVertical = [_setSource vertialOffSetForIconImageViewInEmptyDataView:self];
        self.imvIcon.frame = CGRectMake(self.imvIcon.frame.origin.x, self.imvIcon.frame.origin.y + imvIconVertical, self.imvIcon.frame.size.width, self.imvIcon.frame.size.height);
    }
    
    /**SetTitleLabel*/
    self.lblTitle.frame = CGRectMake(0, CGRectGetMaxY(self.imvIcon.frame) + kSpaceTitleDefault, self.frame.size.width, kTitleHeightDefault);
    if (_setSourceFlag.titleForDescriptionFlag) {
        NSAttributedString *titleString = [_setSource titleForDescriptionTitleInEmptyDataView:self];
        [self.lblTitle setAttributedText:titleString];
    }
    if (_setSourceFlag.heightBetweenTitleAndImvFlag) {
        CGFloat spaceHeight = [_setSource spaceHeightBetweenTitleAndIconImageViewInEmptyDataView:self];
        self.lblTitle.frame = CGRectMake(0, self.lblTitle.frame.origin.y + spaceHeight, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    }
    
    /**SetButton*/
    self.btnClick.frame = CGRectMake(0, CGRectGetMaxY(self.lblTitle.frame) + kSpaceButtonClick, self.frame.size.width, kButtonHeightDefault);
    if (_setSourceFlag.titleForButtonFlag) {
        NSAttributedString *buttonTitle = [_setSource titleForButtonInEmptyDataView:self];
        [self.btnClick setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    }
    if (_setSourceFlag.heightBetweenButtonAndTitleFlag) {
        CGFloat spaceBetweenButton = [_setSource spaceHeightBetweenButtonAndTitleInEmptyDataView:self];
        self.btnClick.frame = CGRectMake(0, self.btnClick.frame.origin.y + spaceBetweenButton, self.frame.size.width, kButtonHeightDefault);
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
    if ([_setSource respondsToSelector:@selector(titleForButtonInEmptyDataView:)]){
        _setSourceFlag.titleForButtonFlag = YES;
    }
    if ([_setSource respondsToSelector:@selector(spaceHeightBetweenButtonAndTitleInEmptyDataView:)]){
        _setSourceFlag.heightBetweenButtonAndTitleFlag = YES;
    }
}

#pragma mark - Delegate

- (void)setDelegate:(id<FHEmptyDataDelegate>)delegate
{
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(handleTapActionWithEmptyDataView:)]){
        _delegateFlag.handleTapFlag = YES;
    }
    if ([_delegate respondsToSelector:@selector(handleButtonOnClickedWithEmptyDataView:)]){
        _delegateFlag.handleButtonOnClick = YES;
    }
}

#pragma mark - PrivateMethod
- (void)setLoadState:(EmptyDataViewState)loadState
{
    _loadState = loadState;
    self.hidden = _loadState == EmptyDataViewStateDoneLoad ? YES : NO;
    NSAttributedString *buttonTitle = [_setSource titleForButtonInEmptyDataView:self];
    self.btnClick.enabled = [buttonTitle.string isEqualToString:@""] ? NO : YES;
    [self refreshState];
}

- (void)handleButtonOnClick
{
    if (_delegateFlag.handleButtonOnClick) {
        [_delegate handleButtonOnClickedWithEmptyDataView:self];
    }
}

- (void)handleTapGestureRecognizer
{
    if (_delegateFlag.handleTapFlag) {
        [_delegate handleTapActionWithEmptyDataView:self];
    }
}

#pragma mark  - PublicMethod
- (void)refreshState
{
    [self layoutSubviews];
}

@end

