//
//  TTDateUtilities.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 20.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTUtilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation TTUtilities


NSDate * convertDateFromString(NSString *dateString, NSString *format, int locale) {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSString *localeIdentifier = nil;
    if (locale < [NSLocale preferredLanguages].count) {
        localeIdentifier = [[NSLocale preferredLanguages] objectAtIndex:locale];
    }
    else if ([NSLocale preferredLanguages].count > 0) {
        localeIdentifier = [NSLocale preferredLanguages].lastObject;
    }
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];

    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}


NSString * convertDate(NSDate *date, int locale) {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:locale]]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];

    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


+(CGSize)sizeText:(NSString *)text font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode availableSize:(CGSize)size {

    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = lineBreakMode;

    CGSize sizeText = [text boundingRectWithSize:size
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName:font,
                                         NSParagraphStyleAttributeName:paragraphStyle
                                        }
                            context:nil].size;

    return sizeText;
}


+(NSString*)SHAdigestForString:(NSString*)inputString {

    NSString *input = [NSString stringWithFormat:@"%@",inputString ];
	const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:input.length];

	uint8_t digest[CC_SHA1_DIGEST_LENGTH];

	CC_SHA1(data.bytes, data.length, digest);

	NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];

	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];

	return [NSString stringWithString:output];

}


@end
