//
//  UIImage+Extensions.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 22.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+(UIImage *)imageWithRoundCornersFromImage:(UIImage*)image cornerWidth:(CGFloat)corner_width cornerHeight:(CGFloat)corner_height {

    UIImage * newImage = nil;

    if (nil != image) {
        CGFloat w = image.size.width;
        CGFloat h = image.size.height;

        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);

        CGContextBeginPath(context);
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        addRoundedRectToPath(context, rect, corner_width, corner_height);
        CGContextClosePath(context);
        CGContextClip(context);

        CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);

        CGImageRef imageMasked = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);

        newImage = [UIImage imageWithCGImage:imageMasked];
        CGImageRelease(imageMasked);
    }
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
