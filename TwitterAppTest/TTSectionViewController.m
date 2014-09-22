//
//  TTSectionViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 18.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTSectionViewController.h"

@interface TTSectionViewController ()

@end

@implementation TTSectionViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    if (self.navigationController.topViewController != [self.navigationController.viewControllers objectAtIndex:0]) {

        UIButton *backButton = [self setBackButton];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    }
    else {

        UIButton *menuButton = [self setMenuButton];
        [menuButton addTarget:self action: @selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showMenu:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOW_SIDEBAR_MENU object:nil userInfo:nil];
}

@end
