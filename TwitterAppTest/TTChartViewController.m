//
//  TTChartViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 18.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTChartViewController.h"

@interface TTChartViewController ()

@end

@implementation TTChartViewController {
    NChartView *m_view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [self createChart];

    CGSize navbarSize = self.navigationController.navigationBar.bounds.size;
    CGSize statusBar = [[UIApplication sharedApplication] statusBarFrame].size;
    TTChartView *chartView = [[TTChartView alloc] initWithFrame:CGRectMake(0, navbarSize.height + statusBar.height, self.view.bounds.size.width, self.view.bounds.size.height - navbarSize.height - statusBar.height)];
    chartView.delegate = self;
    [self.view addSubview:chartView];
}


#pragma mark - TTChartDataSource

-(NSString *)captionText {
    return [NSString stringWithFormat:@"График активности пользователя @%@", ((TTTwitInfo *)[self.twitList lastObject]).user.screenName];
}

-(NSArray *)series {

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSInteger countTwitsInHour0_6 = 0;
    NSInteger countTwitsInHour6_12 = 0;
    NSInteger countTwitsInHour12_18 = 0;
    NSInteger countTwitsInHour18_0 = 0;

    for (TTTwitInfo *twitInfo in self.twitList) {
        if (!twitInfo.createdDate)
            continue;
        NSDateComponents *dateComponents = [calendar components:NSHourCalendarUnit fromDate:twitInfo.createdDate];
        NSUInteger hour = [dateComponents hour];
        if (hour > 0 && hour <= 6) {
            countTwitsInHour0_6++;
        }
        else if (hour > 6 && hour <= 12) {
            countTwitsInHour6_12++;
        }
        else if (hour > 12 && hour <= 18) {
            countTwitsInHour12_18++;
        }
        else if (hour > 18 && hour <= 0) {
            countTwitsInHour18_0++;
        }
    }

    return @[
             @[@(countTwitsInHour0_6), @"от 0 до 6 часов"],
             @[@(countTwitsInHour6_12), @"от 6 до 12 часов"],
             @[@(countTwitsInHour12_18), @"от 12 до 18 часов"],
             @[@(countTwitsInHour18_0), @"от 18 до 0 часов"],
             ];
}



#pragma mark - NChartSeriesDataSource



///  Взято из примера ColumnChart2D


-(void)createChart {

//    // Create a chart view that will display the chart.
//    m_view = [[NChartView alloc] initWithFrame:CGRectZero];
//
//    // Paste your license key here.
//    m_view.chart.licenseKey = @"XyAkQb1afJt8lYUvRQE4sbvRtDREVxoi86eUURVfhFzqwZJhCBpPKnMrXpdAxEHFvZ9B90Iy6W0+imL3dHPdnZQbT4bOSUlUWbJtayghBSX3yq0qyLYCx1RUiUdWXLMebcXTMmGMNnqI2Te+Q2TNjMF/nDShb2E7EVFeYBYMC71b74bM+glJAL4YcX+KjptrWjMJ7uQAaQLZI1hLJhvo1To1Y0qHRhpQsppesilvpMnIb6zsOu6LVAUDf8NABMDUYHNOqF+XV5RVefhFfRzMK9nEydqRahSVF9Hf3unHcNSd1CxQd4xLEySOEDOFLeJ+jU7LdoH11iqJcLq9ZeNBlyAa0oh6Zd8dWIBEVrCSCVDy/zRbzu2quXfDsyzm1ra078nMtk9J7zI6LE1a5HbuXDMk3id8IO6zyiNjbGQqLMdqBjNiLZI+YKSKCiUt7hBWcphCvZQ3mR9SeMmLc3F2AVZ1XKe5KrY7BB1UpTqQ+Eufny5xwqYnYjVMO4DVHHIQTxNTSBNrzR4cvZG6Eu2Q81pcCi81QQo+WfiP0pKq9EuqW0n3gVzG8bc3RE0u+GXOz0JG0BctNnStlfk8EsMmKE1xtc7oiHLNBalbJVPcAVk/tJrqa6ATBjGQK5G/A4bVj2qGjW3DT3Qo9N0c+LsxFTaKno9jkFUyJlKci69Mvqs=";
//
//    // Margin to ensure some free space for the iOS status bar.
//    m_view.chart.cartesianSystem.margin = NChartMarginMake(10.0f, 10.0f, 10.0f, 20.0f);
//
//    // Create series that will be displayed on the chart.
//    NChartColumnSeries *series = [NChartColumnSeries new];
//
//    // Set brush that will fill that series with color.
//    series.brush = [NChartSolidColorBrush solidColorBrushWithColor:[UIColor colorWithRed:0.38f green:0.8f blue:0.91f alpha:1.0f]];
//
//    // Set data source for the series.
//    series.dataSource = self;
//
//    // Add series to the chart.
//    [m_view.chart addSeries:series];
//
//    // Update data in the chart.
//    [m_view.chart updateData];
//
//    // Set chart view to the controller.
//    self.view = m_view;
//
//    // Uncomment this line to get the animated transition.
//    //    [m_view.chart playTransition:1.0f reverse:NO];
}

//#pragma mark - NChartSeriesDataSource
//
- (NSArray *)seriesDataSourcePointsForSeries:(NChartSeries *)series
{
    NSMutableArray *result = [NSMutableArray array];
//    for (int i = 0; i <= 10; ++i)
//        [result addObject:[NChartPoint pointWithState:[NChartPointState pointStateAlignedToXWithX:i Y:(rand() % 30) + 1] forSeries:series]];
    return result;
}
//
- (NSString *)seriesDataSourceNameForSeries:(NChartSeries *)series
{
    return @"My series";
}

@end
