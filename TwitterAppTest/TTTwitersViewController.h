//
//  TTTwitersViewController.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 18.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSectionViewController.h"

@interface TTTwitersViewController : TTSectionViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *twitList;

@end
