//
//  UIImage+Extensions.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 22.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

+(UIImage *)imageWithRoundCornersFromImage:(UIImage*)image cornerWidth:(CGFloat)corner_width cornerHeight:(CGFloat)corner_height;

+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
