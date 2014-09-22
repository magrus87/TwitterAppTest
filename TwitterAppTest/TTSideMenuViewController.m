//
//  TTSideMenuViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 17.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTSideMenuViewController.h"



#define DEFAULT_SIDE_VIEW_WIDTH                 180.0f





@implementation TTSideMenuViewController

-(id)init {
    self = [super init];
    if (self) {
        _sideViewController = nil;
        _mainViewController = nil;
    }
    return self;
}

-(id)initWithMainViewController:(UIViewController *)mainViewController sideViewController:(UIViewController *)sideViewController {
    self = [super init];
    if (self) {
        _sideViewController = sideViewController;
        _mainViewController = mainViewController;
    }
    return self;
}

-(void)initial {
    _sideViewWidth = DEFAULT_SIDE_VIEW_WIDTH;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [self initial];

    self.mainViewController = _mainViewController;
    self.sideViewController = _sideViewController;


    UISwipeGestureRecognizer *gestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestLeft)];
    gestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:gestureRecognizerLeft];

    UISwipeGestureRecognizer *gestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestRight)];
    gestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:gestureRecognizerRight];
}



#pragma mark - Setters

-(void)setSideViewController:(UIViewController *)sideViewController {
    if (!sideViewController) {
        return;
    }
    if (_sideViewController) {
        [_sideViewController.view removeFromSuperview];
    }

    _sideViewController = sideViewController;
    _sideViewController.view.frame = CGRectMake(0, 0, self.sideViewWidth, self.view.bounds.size.height);
    _sideViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _sideViewController.view.hidden = YES;

    if (_mainViewController.view) {
        [self.view insertSubview:_sideViewController.view belowSubview:_mainViewController.view];
    }
    else {
        [self.view addSubview:_sideViewController.view];
    }
}

-(void)setMainViewController:(UIViewController *)mainViewController {
    if (!mainViewController) {
        return;
    }
    if (_mainViewController) {
        [_mainViewController.view removeFromSuperview];
    }

    _mainViewController = mainViewController;
    _mainViewController.view.layer.shadowOpacity = 0.5;
    _mainViewController.view.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    _mainViewController.view.layer.shadowRadius = 3;
    _mainViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainViewController.view.layer.masksToBounds = NO;


    if (_sideViewController.view && _sideViewController.view.hidden) {
        _mainViewController.view.frame = self.view.bounds;
    }
    else {
        _mainViewController.view.frame = CGRectMake(_sideViewController.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    if (_sideViewController.view) {
        [self.view insertSubview:_mainViewController.view aboveSubview:_mainViewController.view];
    }
    else {
        [self.view addSubview:_mainViewController.view];
    }
}



#pragma mark - Move

-(void)moveMainViewController {

    [UIView animateWithDuration:0.2 animations:^{

        CGRect frame = _mainViewController.view.frame;
        if (_sideViewController.view.hidden) {
            _sideViewController.view.hidden = NO;
            frame.origin.x = DEFAULT_SIDE_VIEW_WIDTH;
        }
        else {
            frame.origin.x = 0.0;
        }
        _mainViewController.view.frame = frame;

    } completion:^(BOOL finished) {

        if (_mainViewController.view.frame.origin.x == 0 && !_sideViewController.view.hidden) {
            _sideViewController.view.hidden = YES;
        }
    }];
}



#pragma mark - SEL

-(void)gestLeft {

    if (_sideViewController.view.hidden)
        return;
    [self moveMainViewController];
}

-(void)gestRight {

    if (!_sideViewController.view.hidden)
        return;
    [self moveMainViewController];
}


@end
