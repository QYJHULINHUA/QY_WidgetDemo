//
//  QY_Calendar.h
//  QY_WidgetDemo
//
//  Created by ihefe－hulinhua on 16/6/23.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QY_Calendar : UIView<UICollectionViewDelegate , UICollectionViewDataSource>
{
    NSCalendar *currentCalendarr;
    UICollectionView *_collectionView;
    NSDate *datee;
    NSDate *today;

    
}
@property (weak, nonatomic) IBOutlet UILabel *dataLabell;

+ (instancetype)getQY_CalendarViewOnView:(UIView *)superView frame:(CGRect)frame;


@end
