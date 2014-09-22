//
//  TTChartDataSourceDelegate.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 22.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTChartDataSourceDelegate <NSObject>

@required

//просто массив значание в NSNumber и текст для легенды  (не больше 4, сделано так наспех)
-(NSArray *)series;

@optional

@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSString *captionText;

@end
