//
//  QY_Calendar.m
//  QY_WidgetDemo
//
//  Created by ihefe－hulinhua on 16/6/23.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "QY_Calendar.h"

@interface QY_CalendarCell : UICollectionViewCell
{
    UIImageView *imgView;

}

@property (nonatomic , strong) UILabel *dateLabel;
@property (nonatomic , assign) BOOL isToday;

@end

@implementation QY_CalendarCell

- (void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    if (isToday) {
        if (!imgView) {
            imgView = [[UIImageView alloc] initWithFrame:self.bounds];
            imgView.image = [UIImage imageNamed:@"today"];
            [self addSubview:imgView];
        }
        imgView.hidden = NO;
        
    }else
    {
        if (imgView) {
            [imgView removeFromSuperview];
            imgView = nil;
        }
    }
}


- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}


@end

@implementation QY_Calendar

+ (instancetype)getQY_CalendarViewOnView:(UIView *)superView frame:(CGRect)frame
{
    QY_Calendar *calendarPicker = [[[NSBundle mainBundle] loadNibNamed:@"QY_Calendar" owner:self options:nil] firstObject];
    calendarPicker->currentCalendarr = [NSCalendar currentCalendar];
    calendarPicker.frame = frame;
    calendarPicker->today = [NSDate date];
    calendarPicker->datee = calendarPicker->today;
    [calendarPicker initCollectionView:frame];
    calendarPicker.backgroundColor = [UIColor grayColor];
    [superView addSubview:calendarPicker];
    return calendarPicker;
}

- (void)initCollectionView:(CGRect)frame
{
    frame.origin.y = 44;
    frame.size.height = frame.size.height - 44;
    CGFloat item_w = frame.size.width / 7;
    CGFloat item_h = frame.size.height / 7;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(item_w, item_h);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[QY_CalendarCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self addSubview:_collectionView];
    
    _dataLabell.text = [NSString stringWithFormat:@"%.2ld-%ld",[self month:datee],[self year:datee]];
    
}

- (NSArray *)getWeakDayArray
{
    return  @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}

- (CGFloat)itemWidth
{
    return _collectionView.frame.size.width / 7;
}

- (CGFloat)itemHeight
{
    return _collectionView.frame.size.height / 7;
}


// 一个月的天数
- (NSUInteger)getTotalNumDayInThisMonth:(NSDate*)date
{
    return [currentCalendarr rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

// 这个月的第一个星期的第一天
- (NSUInteger)firstWeekdayInThisMonth:(NSDate *)date{
    
    [currentCalendarr setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [currentCalendarr components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [currentCalendarr dateFromComponents:comp];
    return [currentCalendarr ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate] - 1;
}

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

- (IBAction)leftBtn:(UIButton *)sender {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        datee = [self lastMonth:datee];
        [_collectionView reloadData];
        _dataLabell.text = [NSString stringWithFormat:@"%.2ld-%ld",[self month:datee],[self year:datee]];
    } completion:nil];
}


- (IBAction)rightBtn:(UIButton *)sender {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        datee = [self nextMonth:datee];
        [_collectionView reloadData];
        _dataLabell.text = [NSString stringWithFormat:@"%.2ld-%ld",[self month:datee],[self year:datee]];
    } completion:nil];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    } else {
        return 42;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    QY_CalendarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell.dateLabel setText:[self getWeakDayArray][indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor colorWithRed:21/255.f green:204/255.f blue:156/255.f alpha:1]];
        
    }else
    {
        if (cell.isToday == YES) {
            cell.isToday = NO;
        }
        NSUInteger numDaysInMonth = [self getTotalNumDayInThisMonth:datee];
        NSUInteger firstDay = [self firstWeekdayInThisMonth:datee];
        if (indexPath.row < firstDay) {
            [cell.dateLabel setText:@""];
            
        }else if(indexPath.row < firstDay + numDaysInMonth)
        {
            [cell.dateLabel setText:[NSString stringWithFormat:@"%ld",indexPath.row - firstDay + 1]];
            [cell.dateLabel setTextColor:[UIColor blackColor]];
        }else
        {
            [cell.dateLabel setText:@""];
        }
        if ([today isEqualToDate:datee]) {
            NSInteger i = [self day:today];
            if (indexPath.row - firstDay + 1 == i) {
                cell.isToday = YES;
            }
            
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



