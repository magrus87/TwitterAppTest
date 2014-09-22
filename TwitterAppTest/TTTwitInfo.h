//
//  TTTwitInfo.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 19.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTUser;

@interface TTTwitInfo : NSObject<NSCoding>

@property (strong, nonatomic) NSString *twitID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) TTUser *user;

@end
