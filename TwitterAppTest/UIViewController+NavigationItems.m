//
//  UIViewController+NavigationItems.m
//  IzhDevCom
//
//  Created by Александр Макаров on 09.06.13.
//  Copyright (c) 2013 Александр Макаров. All rights reserved.
//

#import "UIViewController+NavigationItems.h"

@implementation UIViewController (NavigationItems)

- (UIButton *)setRightButtonWithImage:(UIImage *)bgImage {
    
    UIButton* button = [[UIButton alloc] init];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setImage:bgImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 40, 40);
    
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    return button;
}

- (UIButton *)setBackButton {
    
    UIImage *bgImage = [UIImage imageNamed:@"btn_back"];
    
    UIButton* button = [[UIButton alloc] init];
    
    if (self.navigationController.topViewController != [self.navigationController.viewControllers objectAtIndex: 0]) {
        
        [button setBackgroundColor:[UIColor clearColor]];
        [button setImage:bgImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 40, 40);
        
        UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = buttonItem;
        
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }
    
    return button;
}

- (UIButton *)setMenuButton {
    
    UIImage *bgImage = [UIImage imageNamed:@"btn_menu"];
    
    UIButton* button = [[UIButton alloc] init];
    
    if (self.navigationController.topViewController == [self.navigationController.viewControllers objectAtIndex: 0]) {
        
        [button setBackgroundColor:[UIColor clearColor]];
        [button setImage:bgImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 40, 40);
        
        UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
    
    return button;
}

@end
