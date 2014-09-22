//
//  TTChartViewController.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 18.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NChart3D/NChart3D.h>
#import "TTSectionViewController.h"
#import "TTChartView.h"

@interface TTChartViewController : TTSectionViewController<NChartSeriesDataSource, TTChartDataSourceDelegate>

@property (strong, nonatomic) NSArray *twitList;

@end
