//
//  TTManagerData.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 19.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTManagerData.h"
#import "Reachability.h"


#define kStoreKeySelfTwit               @"StoreKeySelfTwits"



#define kTwitterAPIProtocol             @"https://"
#define kTwitterAPIHost                 @"api.twitter.com"
#define kTwitterAPIMethodUserTimeline   @"1.1/statuses/user_timeline.json"
#define kTwitterAPIMethodUsersSearch    @"1.1/users/search.json"
#define kTwitterAPIMethodUsersInfo      @"1.1/users/show.json"



@implementation TTManagerData {
    Reachability *internetReachable;
    NSString *_lastSearchUserName;
    NSMutableDictionary *_mutableDictionary;
}

@synthesize twitterAccount = _twitterAccount;


static TTManagerData *instanse;

+(TTManagerData *)shared {

	@synchronized (self) {
		if (!instanse) {
			instanse = [[TTManagerData alloc] init];
		}
		return instanse;
	}
}

-(void)setAccountTwits:(NSArray *)accountTwits {
//    [self willChangeValueForKey:@"twits"];
    _accountTwits = [accountTwits copy];
//    [self didChangeValueForKey:@"twits"];
}

-(void)setSearchTwits:(NSArray *)searchTwits {
    _searchTwits = [searchTwits copy];
}

-(void)setSearchUsers:(NSArray *)searchUsers {
    _searchUsers = [searchUsers copy];
}

-(NSDictionary *)images {
    if (!_mutableDictionary) {
        _mutableDictionary = [NSMutableDictionary new];
    }
    return [NSDictionary dictionaryWithDictionary:_mutableDictionary];
}

-(void)restoreTwitsList {

    dispatch_async(dispatch_get_main_queue(), ^{
        [[TTManagerData shared] loadAccountWithCompletionBlock:^{
            [[TTManagerData shared] loadTwitsForUserName:_twitterAccount.accountDescription isAccountName:YES];
        }];
    });
}

-(void)checkNetworkReachableWithReachBlock:(void (^)(void))reachBlock unreachBlock:(void (^)(void))unreachBlock {

    internetReachable = [Reachability reachabilityWithHostname:kTwitterAPIHost];

    internetReachable.reachableBlock = ^(Reachability *reach) {
        reachBlock();
    };

    internetReachable.unreachableBlock = ^(Reachability *reach) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NOT_NETWORK_CONNECTION object:nil];
        unreachBlock();
    };

    [internetReachable startNotifier];
}


#pragma mark - Persistent Data

-(void)restoreSavedDataByKey:(NSString *)storeKey {

    NSString *filePath = [[TTManagerData shared] twitsListFilePathWithKey:storeKey];

    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {

        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSArray *savedTwitsArray = [unarchiver decodeObjectForKey:storeKey];
        [unarchiver finishDecoding];

        if ([storeKey isEqualToString:kStoreKeySelfTwit]) {
            [[TTManagerData shared] setAccountTwits:savedTwitsArray];
        }
        else {
            [[TTManagerData shared] setSearchTwits:savedTwitsArray];
        }

    }
}

-(NSArray *)parsingResponseTwits:(NSArray *)responseArray {

    NSMutableArray *tempArray = [NSMutableArray new];

    for (NSDictionary *twitObj in responseArray) {

        TTTwitInfo *twit = [TTTwitInfo new];
        twit.twitID = [twitObj objectForKey:@"id"];
        twit.text = [twitObj objectForKey:@"text"];
        twit.createdDate = convertDateFromString([twitObj objectForKey:@"created_at"], @"ccc MMM dd HH:mm:ss Z yyyy", 1);

        NSDictionary *userInfo = [twitObj objectForKey:@"user"];
        if (userInfo) {
            TTUser *user = [TTUser new];
            user.userID = [userInfo objectForKey:@"id"];
            user.name = [userInfo objectForKey:@"name"];
            user.screenName = [userInfo objectForKey:@"screen_name"];
            user.createdDate = convertDateFromString([userInfo objectForKey:@"created_at"], @"ccc MMM dd HH:mm:ss Z yyyy", 1);
            user.imageUrl = [userInfo objectForKey:@"profile_image_url"];

            twit.user = user;
        }

        [tempArray addObject:twit];
    }

    return tempArray;
}

-(NSArray *)parsingResponseUsers:(NSArray *)responseArray {

    NSMutableArray *tempArray = [NSMutableArray new];

    for (NSDictionary *userObj in responseArray) {

        TTUser *user = [TTUser new];
        user.userID = [userObj objectForKey:@"id"];
        user.name = [userObj objectForKey:@"name"];
        user.screenName = [userObj objectForKey:@"screen_name"];
        user.createdDate = convertDateFromString([userObj objectForKey:@"created_at"], @"ccc MMM dd HH:mm:ss Z yyyy", 1);
        user.imageUrl = [userObj objectForKey:@"profile_image_url"];

        [tempArray addObject:user];
    }
    
    return tempArray;
}


-(void)saveTwitsList {

    if (self.accountTwits)
        [self saveData:self.accountTwits storeKey:kStoreKeySelfTwit];
    if (self.searchTwits && _lastSearchUserName)
        [self saveData:self.searchTwits storeKey:[self storeKeyForUserName:_lastSearchUserName]];
}

-(void)saveData:(NSArray *)dataToKeep storeKey:(NSString *)storeKey {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [self twitsListFilePathWithKey:storeKey];

        NSError *error;
        if ([fileManager fileExistsAtPath:filePath]) {
            [fileManager removeItemAtPath:filePath error:&error];
        }
        if (![fileManager fileExistsAtPath:[filePath stringByDeletingLastPathComponent]]) {
            [fileManager createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:&error];
        }

        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:dataToKeep forKey:storeKey];
        [archiver finishEncoding];
        [data writeToFile:filePath atomically:YES];
    });
}


#pragma mark - Account

-(ACAccount *)twitterAccount {
    return _twitterAccount;
}

-(void)loadAccountWithCompletionBlock:(void (^)(void))completionBlock {

    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSArray *arrayOfAccounts = [accountStore accountsWithAccountType:accountType];

            if (arrayOfAccounts.count > 0) {
                _twitterAccount = [arrayOfAccounts lastObject];
                completionBlock();
            }
            else
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ACCOUNT_NOT_FOUND object:nil userInfo:nil];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


#pragma mark - API methods


-(void)loadTwitsForUserName:(NSString *)userName {
    [self loadTwitsForUserName:userName isAccountName:NO];
}

-(void)loadTwitsForUserName:(NSString *)userName isAccountName:(BOOL)accountName {

    if (!accountName) _lastSearchUserName = userName;

    [self checkNetworkReachableWithReachBlock:^{

        [self executeRequestForAPIURLMethod:kTwitterAPIMethodUserTimeline parameters:[[TTManagerData shared] parametersForRequestTimelineForUserName:userName] completionBlock:^(NSArray *responce) {
            NSArray *twitsArray = [[TTManagerData shared] parsingResponseTwits:responce];
            if (accountName) {
                [self setAccountTwits:twitsArray];
                [[TTManagerData shared] saveData:self.accountTwits storeKey:kStoreKeySelfTwit];
            }
            else {
                [self setSearchTwits:twitsArray];
                [[TTManagerData shared] saveData:self.searchTwits storeKey:[self storeKeyForUserName:userName]];
            }
        }];
    } unreachBlock:^{

        if (accountName) {
            [[TTManagerData shared] restoreSavedDataByKey:kStoreKeySelfTwit];
        }
        else {
            [[TTManagerData shared] restoreSavedDataByKey:[self storeKeyForUserName:userName]];
        }
    }];


}

-(void)searchUser:(NSString *)userName {

    if (!internetReachable.isReachable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NOT_NETWORK_CONNECTION object:nil];
        return;
    }

    [self executeRequestForAPIURLMethod:kTwitterAPIMethodUsersSearch parameters:[[TTManagerData shared] parametersForRequestUsersSearchByName:userName] completionBlock:^(NSArray *responce) {
        NSArray *usersArray = [[TTManagerData shared] parsingResponseUsers:responce];
        [self setSearchUsers:usersArray];
    }];
}

-(void)infoUserByName:(NSString *)userName {

    if (!internetReachable.isReachable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NOT_NETWORK_CONNECTION object:nil];
        return;
    }

    [self executeRequestForAPIURLMethod:kTwitterAPIMethodUsersInfo parameters:[[TTManagerData shared] parametersForRequestUsersInfoByName:userName] completionBlock:^(NSArray *responce) {
        //todo;
    }];
}


-(void)executeRequestForAPIURLMethod:(NSString *)method parameters:(NSDictionary *)parameters completionBlock:(void (^)(NSArray *responce))completionBlock {

    NSURL *requestAPIUrl = [NSURL URLWithString:[[TTManagerData shared] getTwitsAPIURLMethod:method]];

    SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestAPIUrl parameters:parameters];
    posts.account = [[TTManagerData shared] twitterAccount];

    [posts performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        completionBlock([NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error]);
    }];
}



#pragma mark - Parameters

-(NSDictionary *)parametersForRequestTimelineForUserName:(NSString *)userName {
    return @{
             @"count": @"200",
             @"include_rts": @"1",
             @"screen_name": userName
             };
}

-(NSDictionary *)parametersForRequestUsersSearchByName:(NSString *)userName {
    return @{
             @"q": userName
             };
}

-(NSDictionary *)parametersForRequestUsersInfoByName:(NSString *)userName {
    return @{
             @"screen_name": userName
             };
}



#pragma mark - Utils

-(NSString *)twitsListFilePathWithKey:(NSString *)storedKey {
    return [[[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"PersistentData"] stringByAppendingPathComponent:[TTUtilities SHAdigestForString:storedKey]] stringByAppendingPathExtension:@"plist"];
}

-(NSString *)getTwitsAPIURLMethod:(NSString *)method {
    return [NSString stringWithFormat:@"%@%@", kTwitterAPIProtocol, [kTwitterAPIHost stringByAppendingPathComponent:method]];
}

-(NSString *)storeKeyForUserName:(NSString *)userName {
    return [NSString stringWithFormat:@"storeKeyFor%@", userName];
}




#pragma mark - Images

-(void)loadImageWithUrl:(NSString *)imageUrl completion:(void (^)(UIImage *image))completionBlock {


    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:imageUrl]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (data) {
                                   UIImage *image = [UIImage imageWithData:data];
                                   [_mutableDictionary setObject:image forKey:imageUrl];
                                   completionBlock(image);
                                   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                               }
                                                          }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}






@end
