//
//  UIColor+Extensions.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 17.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)


+(UIColor *)activityViewBackgroundColor;

+(UIColor *)twitNoteTextColor;

+(UIColor *)customBlueColor;

+(NSArray *)defaultColorsForChart;

+(NSArray *)getRGBComponentsForColor:(UIColor *)color;

@end
