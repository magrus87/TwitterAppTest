//
//  UIColor+Extensions.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 17.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+(UIColor *)activityViewBackgroundColor {
    return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:220.0/255.0];
}

+(UIColor *)twitNoteTextColor {
    return [UIColor colorWithRed:168.0/255.0 green:170.0/255.0 blue:173.0/255.0 alpha:255.0/255.0];
}

+(UIColor *)customBlueColor {
    return [UIColor colorWithRed:0.0/255.0 green:107.0/255.0 blue:181.0/255.0 alpha:255.0/255.0];
}

+(NSArray *)defaultColorsForChart {

    return @[
             [UIColor colorWithRed:136.0/255.0 green:201.0/255.0 blue:249.0/255.0 alpha:255.0/255.0],
             [UIColor colorWithRed:85.0/255.0 green:172.0/255.0 blue:238.0/255.0 alpha:255.0/255.0],
             [UIColor colorWithRed:42.0/255.0 green:144.0/255.0 blue:199.0/255.0 alpha:255.0/255.0],
             [UIColor colorWithRed:14.0/255.0 green:124.0/255.0 blue:183.0/255.0 alpha:255.0/255.0],
             ];
}

+(NSArray *)getRGBComponentsForColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);

    NSMutableArray *result = [NSMutableArray array];

    for (int component = 0; component < 4; component++) {
        [result addObject:@(resultingPixel[component] / 255.0f)];
    }

    return result;
};


@end
