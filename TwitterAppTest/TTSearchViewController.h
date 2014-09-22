//
//  TTSearchViewController.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 21.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTSectionViewController.h"

@interface TTSearchViewController : TTSectionViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *userList;

@end
