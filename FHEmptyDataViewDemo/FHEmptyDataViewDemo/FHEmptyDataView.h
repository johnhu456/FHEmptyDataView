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
- (NSString *)titleForDescriptionTitleInEmptyDataView:(FHEmptyDataView *)emptyDataView;
/**
 *  标题与图标间隔
 */
- (CGFloat)spaceHeightBetweenTitleAndIconImageViewInEmptyDataView:(FHEmptyDataView *)emptyDataView;

@end

/**事件代理*/
@protocol FHEmptyDataDelegate <NSObject>


@end

@interface FHEmptyDataView : UIView
//
//@property (nonatomic, strong, readonly) UIImageView *imvIcon;

@property (nonatomic, strong, readonly) UILabel *lblTitle;
//
//@property (nonatomic, strong, readonly) UIButton *lblButton;

@property (nonatomic, weak) id<FHEmptyDataSetSource> setSource;

@property (nonatomic, weak) id<FHEmptyDataDelegate> delegate;

@end
