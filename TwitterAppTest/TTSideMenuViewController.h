//
//  TTSideMenuViewController.h
//  TwitterAppTest
//
//  Created by Александр Макаров on 17.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTSideMenuViewController : UIViewController

-(id)initWithMainViewController:(UIViewController *)mainViewController sideViewController:(UIViewController *)sideViewController;

@property (strong, nonatomic) UIViewController *mainViewController;
@property (strong, nonatomic) UIViewController *sideViewController;

@property (assign, nonatomic) CGFloat sideViewWidth;

-(void)moveMainViewController;

@end
