//
//  TTSidebarViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 18.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTSidebarViewController.h"

@interface TTSidebarViewController ()

@end

@implementation TTSidebarViewController

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FROM_SIDEBARTABLE_SELECT_ROW object:[tableView cellForRowAtIndexPath:indexPath].reuseIdentifier];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    CALayer *border = [[CALayer alloc] init];
    border.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.bounds.size.height-1, cell.bounds.size.width - cell.textLabel.frame.origin.x, 1);
    border.backgroundColor = tableView.separatorColor.CGColor;
    [cell.contentView.layer addSublayer:border];
}


@end
