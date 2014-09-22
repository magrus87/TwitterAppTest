//
//  TTViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 17.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTViewController.h"
#import "TTSectionViewController.h"
#import "TTTwitersViewController.h"
#import "TTSearchViewController.h"



#define ACTIVITYINDICATOR_HEIGHT            80.0f
#define ACTIVITYINDICATOR_WIDTH             80.0f


#define kActivityViewTag                    10000


@interface TTViewController ()

@property (strong, nonatomic) UIViewController *SearchViewController;
@property (strong, nonatomic) UIViewController *AccountViewController;
@property (strong, nonatomic) UIView *activityView;

@end

@implementation TTViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMainViewController:) name:NOTIFICATION_FROM_SIDEBARTABLE_SELECT_ROW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveMainViewController) name:NOTIFICATION_SHOW_SIDEBAR_MENU object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountNotFound) name:NOTIFICATION_ACCOUNT_NOT_FOUND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notNetworkConnection) name:NOTIFICATION_NOT_NETWORK_CONNECTION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showActivityView) name:NOTIFICATION_START_NETWORK_REQUEST object:nil];

    _AccountViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Account View Controller"];
    _SearchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Search View Controller"];

    self.mainViewController = _AccountViewController;
    self.sideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Sidebar View Controller"];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showActivityView];
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Activity View

-(void)showActivityView {

    if (!_activityView) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _activityView.backgroundColor = [UIColor activityViewBackgroundColor];
        _activityView.hidden = NO;
        _activityView.tag = kActivityViewTag;

        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(floor((_activityView.bounds.size.width - ACTIVITYINDICATOR_WIDTH)/2), floor((_activityView.bounds.size.height - ACTIVITYINDICATOR_HEIGHT)/2), ACTIVITYINDICATOR_WIDTH, ACTIVITYINDICATOR_HEIGHT)];
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [activityIndicatorView startAnimating];
        [_activityView addSubview:activityIndicatorView];
    }

    if (![self.view viewWithTag:kActivityViewTag]) {
        [self.view addSubview:_activityView];
    }
}

-(void)hideActivityView {
    if ([self.view viewWithTag:kActivityViewTag]) {
        [NSThread detachNewThreadSelector:@selector(removeFromSuperview) toTarget:_activityView withObject:nil];
    }
}




#pragma mark - Observers methods

-(void)changeMainViewController:(NSNotification *)notification {

    if ([notification.object isEqualToString:@"accountCell"]) {
        self.mainViewController = _AccountViewController;
    }
    else if ([notification.object isEqualToString:@"searchCell"]) {
        self.mainViewController = _SearchViewController;
    }

    [self moveMainViewController];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath compare:@"accountTwits"]) {
        ((TTTwitersViewController *)((UINavigationController *)_AccountViewController).topViewController).twitList = [TTManagerData shared].accountTwits;
    }
    else if (![keyPath compare:@"searchTwits"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOADED_TWITS_BY_USER object:nil];
    }
    else if (![keyPath compare:@"searchUsers"]) {
        ((TTSearchViewController *)((UINavigationController *)_SearchViewController).topViewController).userList = [TTManagerData shared].searchUsers;
    }

    [self hideActivityView];
}


-(void)accountNotFound {
    [NSThread detachNewThreadSelector:@selector(setOppsView) toTarget:self withObject:nil];
}

-(void)setOppsView {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Oops View Controller"];
    [self presentViewController:viewController animated:NO completion:^{
        [self hideActivityView];
    }];
}


-(void)notNetworkConnection {

    [self hideActivityView];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"network_fail", @"network_fail") message:NSLocalizedString(@"network_fail_message", @"network_fail_message") delegate:nil cancelButtonTitle:NSLocalizedString(@"close", @"close") otherButtonTitles:nil, nil];
    [NSThread detachNewThreadSelector:@selector(show) toTarget:alert withObject:nil];
}


@end
