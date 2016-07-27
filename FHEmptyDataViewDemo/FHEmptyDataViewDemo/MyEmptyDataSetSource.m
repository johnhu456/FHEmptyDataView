//
//  MyEmptyDataSetSource.m
//  FHEmptyDataViewDemo
//
//  Created by MADAO on 16/7/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "MyEmptyDataSetSource.h"

@implementation MyEmptyDataSetSource

- (UIImage *)imageForIconImageViewInEmptyDataView:(FHEmptyDataView *)emptyDataView
{
    switch (emptyDataView.loadState) {
        case EmptyDataViewStateBadNetwork:
            return [UIImage imageNamed:@"prompt_img_badNetwork"];
            break;
        case EmptyDataViewStateLoading:
            return [UIImage animatedImageNamed:@"loading_imv_frame" duration:0.3];
            break;
        case EmptyDataViewStateNoData:
            return [UIImage imageNamed:@"prompt_img_noRecorde"];
            break;
        default:
            return nil;
            break;
    }
}

- (NSAttributedString *)titleForDescriptionTitleInEmptyDataView:(FHEmptyDataView *)emptyDataView
{
    NSString *titleString;
    UIFont *titleFont = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    UIColor *titleColor = [UIColor colorWithRed:204.f/255.f green:204.f/255.f blue:204.f/255.f alpha:1];

    switch (emptyDataView.loadState) {

        case EmptyDataViewStateNoData:
            titleString = @"暂无记录";
            break;
        case EmptyDataViewStateLoading:
            titleString = @"正在努力加载...";
            break;
        case EmptyDataViewStateBadNetwork:
            titleString = @"操作失败";
            break;
        case EmptyDataViewStateDoneLoad: default:
            titleString = @"";
            break;
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName:titleColor,
                                            NSFontAttributeName:titleFont
                                 };
    NSAttributedString *attributesTitle = [[NSAttributedString alloc] initWithString:titleString attributes:attributes];
    return attributesTitle;
}

- (NSAttributedString *)titleForButtonInEmptyDataView:(FHEmptyDataView *)emptyDataView
{
    NSString *buttonTitle;
    UIFont *buttonFont = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    UIColor *buttonColor =  [UIColor colorWithRed:204.f/255.f green:204.f/255.f blue:204.f/255.f alpha:1];

    switch (emptyDataView.loadState) {
        case EmptyDataViewStateBadNetwork:
            buttonTitle = @"点击屏幕,重新加载";
            break;
        case EmptyDataViewStateDoneLoad: case EmptyDataViewStateNoData: case EmptyDataViewStateLoading:default:
            buttonTitle = @"";
            break;
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName:buttonColor,
                                 NSFontAttributeName:buttonFont
                                 };
    NSAttributedString *attributesTitle = [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
    return attributesTitle;
}

@end
