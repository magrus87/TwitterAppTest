//
//  UIViewController+NavigationItems.h
//  IzhDevCom
//
//  Created by Александр Макаров on 09.06.13.
//  Copyright (c) 2013 Александр Макаров. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationItems)

- (UIButton *)setRightButtonWithImage:(UIImage *)bgImage;
- (UIButton *)setBackButton;
- (UIButton *)setMenuButton;

@end
