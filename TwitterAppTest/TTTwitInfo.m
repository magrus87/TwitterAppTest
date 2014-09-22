//
//  TTTwitInfo.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 19.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTTwitInfo.h"
#import "TTUser.h"


#define kTwitID             @"TwitID"
#define kText               @"Text"
#define kUser               @"User"
#define kCreatedDate        @"CreatedDate"

@implementation TTTwitInfo

-(id)init {

    self = [super init];
    if (self) {

        _twitID = nil;
        _text = nil;
        _user = nil;
        _createdDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return self;
}


#pragma mark NSCoding


- (void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeObject:_twitID forKey:kTwitID];
    [encoder encodeObject:_text forKey:kText];
    [encoder encodeObject:_user forKey:kUser];
    [encoder encodeObject:_createdDate forKey:kCreatedDate];
}

- (id)initWithCoder:(NSCoder *)decoder {

    if (self = [super init]) {
        _twitID = [decoder decodeObjectForKey:kTwitID];
        _text = [decoder decodeObjectForKey:kText];
        _user = [decoder decodeObjectForKey:kUser];
        _createdDate = [decoder decodeObjectForKey:kCreatedDate];
    }
    return self;
}

@end
