//
//  TodayViewController.m
//  Calendar
//
//  Created by ihefe－hulinhua on 16/6/23.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "QY_Calendar.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [QY_Calendar getQY_CalendarViewOnView:self.view frame:CGRectMake(0, 0, self.view.frame.size.width, 352)];
    self.preferredContentSize = CGSizeMake(0, 352);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    
    completionHandler(NCUpdateResultNewData);
    
}

@end
