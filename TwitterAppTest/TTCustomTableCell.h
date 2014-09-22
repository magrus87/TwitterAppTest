//
//  TTCustomTableCell.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 20.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <Foundation/Foundation.h>


#define TABLE_CELL_DEFAULT_HEIGHT       105.0f


@interface TTCustomTableCell : UITableViewCell

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userScreenName;

@end
