//
//  TTUser.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 19.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUser : NSObject<NSCoding>

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSString *imageUrl;

@end
