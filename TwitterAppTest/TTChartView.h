//
//  TTChartView.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 22.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTChartDataSourceDelegate.h"

@interface TTChartView : UIView

@property (assign, nonatomic) id<TTChartDataSourceDelegate> delegate;

@end
