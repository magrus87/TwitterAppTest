//
//  TTDateUtilities.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 20.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUtilities : NSObject

NSDate * convertDateFromString(NSString *dateString, NSString *format, int locale);
NSString * convertDate(NSDate *date, int locale);

+(CGSize)sizeText:(NSString *)text font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode availableSize:(CGSize)size;

+(NSString*)SHAdigestForString:(NSString*)inputString;

@end
