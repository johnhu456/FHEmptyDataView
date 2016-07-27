//
//  ViewController.m
//  FHEmptyDataViewDemo
//
//  Created by MADAO on 16/7/26.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "ViewController.h"
#import "FHEmptyDataView.h"
#import "MyEmptyDataSetSource.h"
@interface ViewController ()<FHEmptyDataDelegate>
{
    EmptyDataViewState _state;
}

@property (nonatomic, weak) FHEmptyDataView *emptyView;

@property (nonatomic, strong) MyEmptyDataSetSource *setSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _state = 0;
    FHEmptyDataView *dataView = [[FHEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 200)];
    MyEmptyDataSetSource *setSource = [[MyEmptyDataSetSource alloc] init];
    self.setSource = setSource;
    self.emptyView = dataView;
    self.emptyView.backgroundColor = [UIColor whiteColor];
    self.emptyView.setSource = setSource;
    self.emptyView.delegate = self;
    self.emptyView.loadState = _state;
    [self.view addSubview:dataView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _state ++;
    if (_state > 3) {
        _state = 0;
    }
    NSLog(@"%lu",(unsigned long)_state);
    self.emptyView.loadState = _state;
}

-(void)handleTapActionWithEmptyDataView:(FHEmptyDataView *)emptyDataView
{
    NSLog(@"tap");
}

- (void)handleButtonOnClickedWithEmptyDataView:(FHEmptyDataView *)emptyDataView
{
    NSLog(@"button");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
