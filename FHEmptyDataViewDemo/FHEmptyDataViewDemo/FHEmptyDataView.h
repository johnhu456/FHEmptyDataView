//
//  FHEmptyDataView.h
//  FHEmptyDataViewDemo
//
//  Created by MADAO on 16/7/26.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHEmptyDataView;

/**设置代理*/
@protocol FHEmptyDataSetSource <NSObject>
@optional
/**
 *  图片内容
 */
- (UIImage *)imageForIconImageViewInEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  图片大小
 */
- (CGSize)sizeForIconImageViewInEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  图片竖直方向Offset
 */
- (CGFloat)vertialOffSetForIconImageViewInEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  描述标题
 */
- (NSAttributedString *)titleForDescriptionTitleInEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  标题与图标间隔
 */
- (CGFloat)spaceHeightBetweenTitleAndIconImageViewInEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  按钮标题
 */
- (NSAttributedString *)titleForButtonInEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  按钮与标题间隔
 */
- (CGFloat)spaceHeightBetweenButtonAndTitleInEmptyDataView:(FHEmptyDataView *)emptyDataView;

@end

/**事件代理*/
@protocol FHEmptyDataDelegate <NSObject>
@optional
/**
 *  处理普通的Tap事件
 */
- (void)handleTapActionWithEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  处理按钮点击
 */
- (void)handleButtonOnClickedWithEmptyDataView:(FHEmptyDataView *)emptyDataView;

@end

typedef NS_ENUM(NSUInteger, EmptyDataViewState){
    EmptyDataViewStateDoneLoad = 0,
    EmptyDataViewStateLoading,
    EmptyDataViewStateNoData,
    EmptyDataViewStateBadNetwork
};

#pragma mark - Class FHEmptyDataView

@interface FHEmptyDataView : UIView

@property (nonatomic, strong, readonly) UILabel *lblTitle;

@property (nonatomic, weak) id<FHEmptyDataSetSource> setSource;

@property (nonatomic, weak) id<FHEmptyDataDelegate> delegate;

@property (nonatomic, assign) EmptyDataViewState loadState;

/**
 *  更新状态
 */
- (void)refreshState;
@end
