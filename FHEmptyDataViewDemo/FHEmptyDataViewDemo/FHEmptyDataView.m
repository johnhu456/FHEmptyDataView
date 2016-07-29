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
        unsigned int verticalCenterFlag:1;
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

static CGFloat const kIconWidthDefault = 120.f;
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
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self setupSubViews];
    [self setupTapGesture];
}

#pragma mark - UserInterface

- (void)setupSubViews
{
    self.imvIcon = [[UIImageView alloc] init];
    [self addSubview:self.imvIcon];
    self.imvIcon.backgroundColor = [UIColor clearColor];
    self.imvIcon.contentMode = UIViewContentModeScaleAspectFill;
    self.imvIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.lblTitle = [[UILabel alloc] init];
    [self addSubview:self.lblTitle];
    [self.lblTitle setBackgroundColor:[UIColor clearColor]];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    self.lblTitle.font = [UIFont systemFontOfSize:26];
    self.lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btnClick];
    [self.btnClick setBackgroundColor:[UIColor clearColor]];
    [self.btnClick setTitleColor:[UIColor colorWithWhite:0.6 alpha:1.0] forState:UIControlStateNormal];
    [self.btnClick.titleLabel setFont:[UIFont systemFontOfSize:17]];
    self.btnClick.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnClick addTarget:self action:@selector(handleButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    self.btnClick.translatesAutoresizingMaskIntoConstraints = NO;
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
    CGFloat totalHeight;
    /**SetIconImageView*/
    self.imvIcon.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.imvIcon.frame = CGRectMake(self.imvIcon.frame.origin.x , self.imvIcon.frame.origin.y, kIconWidthDefault, kIconWidthDefault);

    if (_setSourceFlag.imageForIconFlag){
        UIImage *iconImage = [_setSource imageForIconImageViewInEmptyDataView:self];
        self.imvIcon.image = iconImage;
    }
    if (_setSourceFlag.sizeForIconFlag) {
        CGSize imvIconSize = [_setSource sizeForIconImageViewInEmptyDataView:self];
        self.imvIcon.frame = CGRectMake(self.imvIcon.frame.origin.x, self.imvIcon.frame.origin.y, imvIconSize.width, imvIconSize.height);
    }
    
    CGFloat imvIconVertical = 0.f;
    if (_setSourceFlag.vertialOffsetForIconFlag) {
        imvIconVertical = [_setSource vertialOffSetForIconImageViewInEmptyDataView:self];
    }
    self.imvIcon.frame = CGRectMake(self.imvIcon.frame.origin.x, self.imvIcon.frame.origin.y + imvIconVertical, self.imvIcon.frame.size.width, self.imvIcon.frame.size.height);
    totalHeight += self.imvIcon.frame.size.height;
    
    /**SetTitleLabel*/
    if (_setSourceFlag.titleForDescriptionFlag) {
        NSAttributedString *titleString = [_setSource titleForDescriptionTitleInEmptyDataView:self];
        [self.lblTitle setAttributedText:titleString];
    }
    CGFloat spaceHeight = kSpaceTitleDefault;
    if (_setSourceFlag.heightBetweenTitleAndImvFlag) {
        spaceHeight = [_setSource spaceHeightBetweenTitleAndIconImageViewInEmptyDataView:self];
    }
    self.lblTitle.frame = CGRectMake(0, CGRectGetMaxY(self.imvIcon.frame) + spaceHeight, self.lblTitle.frame.size.width, kTitleHeightDefault);
    totalHeight += (spaceHeight + self.lblTitle.frame.size.height);
    
    /**SetButton*/
    self.btnClick.frame = CGRectMake(0, CGRectGetMaxY(self.lblTitle.frame) + kSpaceButtonClick, self.bounds.size.width, kButtonHeightDefault);
    if (_setSourceFlag.titleForButtonFlag) {
        NSAttributedString *buttonTitle = [_setSource titleForButtonInEmptyDataView:self];
        [self.btnClick setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    }
    CGFloat spaceBetweenButton = kSpaceButtonClick;
    if (_setSourceFlag.heightBetweenButtonAndTitleFlag) {
        spaceBetweenButton = [_setSource spaceHeightBetweenButtonAndTitleInEmptyDataView:self];
    }
    self.btnClick.frame = CGRectMake(0, CGRectGetMaxY(self.lblTitle.frame) + spaceBetweenButton, self.bounds.size.width, kButtonHeightDefault);

    totalHeight += (spaceBetweenButton + self.btnClick.frame.size.height);
    
    /**VerticalCenter*/
    if (_setSourceFlag.verticalCenterFlag && ![_setSource shouldVerticalBeCentedInEmptyDataView:self]) {
        return;
    }else
    {
        CGFloat originY = (self.bounds.size.height - totalHeight)/2.f;
        
        [self removeConstraints:self.constraints];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imvIcon
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:originY]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imvIcon
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lblTitle
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.imvIcon
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:spaceHeight]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lblTitle
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnClick
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.lblTitle
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:spaceBetweenButton]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnClick
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
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
    if ([_setSource respondsToSelector:@selector(shouldVerticalBeCentedInEmptyDataView:)]){
        _setSourceFlag.verticalCenterFlag = YES;
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

