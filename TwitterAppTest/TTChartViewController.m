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

@implementation TTChartViewController

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

@end
