//
//  TTManagerData.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 19.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTManagerData : NSObject

+(TTManagerData *)shared;

@property (readonly, nonatomic) NSArray *accountTwits;
@property (readonly, nonatomic) NSArray *searchTwits;
@property (readonly, nonatomic) NSArray *searchUsers;
@property (readonly, nonatomic) ACAccount *twitterAccount;

@property (readonly, nonatomic) NSDictionary *images;

-(void)restoreTwitsList;
-(void)saveTwitsList;


-(void)loadTwitsForUserName:(NSString *)userName;
-(void)searchUser:(NSString *)userName;
-(void)infoUserByName:(NSString *)userName;


-(void)loadImageWithUrl:(NSString *)imageUrl completion:(void (^)(UIImage *image))completionBlock;


@end
