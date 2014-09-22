//
//  TTUser.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 19.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTUser.h"

#define kUserID             @"UserID"
#define kName               @"Name"
#define kScreenName         @"ScreenName"
#define kCreatedDate        @"CreatedDate"
#define kImageUrl           @"ImageUrl"



@implementation TTUser


-(id)init {

    self = [super init];
    if (self) {

        _userID = nil;
        _name = nil;
        _screenName = nil;
        _createdDate = [NSDate dateWithTimeIntervalSince1970:0];
        _imageUrl = nil;
    }
    return self;
}


#pragma mark NSCoding


- (void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeObject:_userID forKey:kUserID];
    [encoder encodeObject:_name forKey:kName];
    [encoder encodeObject:_screenName forKey:kScreenName];
    [encoder encodeObject:_createdDate forKey:kCreatedDate];
    [encoder encodeObject:_imageUrl forKey:kImageUrl];
}

- (id)initWithCoder:(NSCoder *)decoder {

    if (self = [super init]) {
        _userID = [decoder decodeObjectForKey:kUserID];
        _name = [decoder decodeObjectForKey:kName];
        _screenName = [decoder decodeObjectForKey:kScreenName];
        _createdDate = [decoder decodeObjectForKey:kCreatedDate];
        _imageUrl = [decoder decodeObjectForKey:kImageUrl];
    }
    return self;
}




@end
