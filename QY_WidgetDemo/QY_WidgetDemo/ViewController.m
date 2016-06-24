//
//  ViewController.m
//  QY_WidgetDemo
//
//  Created by ihefe－hulinhua on 16/6/23.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "ViewController.h"
#import "QY_Calendar.h"

@interface ViewController ()
{
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    QY_Calendar *calendar = [QY_Calendar getQY_CalendarViewOnView:self.view frame:CGRectMake(0, 100, self.view.frame.size.width, 352)];
    self.view.backgroundColor = [UIColor redColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
