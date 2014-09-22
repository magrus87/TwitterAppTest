//
//  TTTwitersViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 18.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTTwitersViewController.h"
#import "TTCustomTableCell.h"
#import "TTChartViewController.h"
#import "TTTwitInfoViewController.h"

@interface TTTwitersViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *chartBarButton;

@end

@implementation TTTwitersViewController 

static BOOL registerXib;

- (void)viewDidLoad
{
    [super viewDidLoad];

    registerXib = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadedTwitsByUser:) name:NOTIFICATION_LOADED_TWITS_BY_USER object:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setters

-(void)setTwitList:(NSArray *)twitList {
    _twitList = twitList;
    [NSThread detachNewThreadSelector:@selector(reloadData) toTarget:self.tableView withObject:nil];
}




#pragma mark - Table View Delegates

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TABLE_CELL_DEFAULT_HEIGHT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _twitList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"CustomCellIdentifier";
    if (!registerXib) {
        [tableView registerNib:[UINib nibWithNibName:@"TTCustomTableCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        registerXib = YES;
    }

    TTCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    TTTwitInfo *twitInfo = [_twitList objectAtIndex:indexPath.row];

    cell.text = twitInfo.text;
    cell.userName = twitInfo.user.name;
    cell.userScreenName = twitInfo.user.screenName;
    cell.date = convertDate(twitInfo.createdDate, 0);
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TTTwitInfo *twitInfo = [_twitList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segue_toTwitInfo" sender:twitInfo];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"segue_toChart"]) {
        ((TTChartViewController *)segue.destinationViewController).twitList = self.twitList;
    }
    else if ([segue.identifier isEqualToString:@"segue_toTwitInfo"]) {
        ((TTTwitInfoViewController *)segue.destinationViewController).twitInfo = (TTTwitInfo *)sender;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"segue_toChart"]) {
        if (self.twitList.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"info", @"info") message:NSLocalizedString(@"no_twits", @"no_twits") delegate:nil cancelButtonTitle:NSLocalizedString(@"close", @"close") otherButtonTitles:nil, nil];
            [NSThread detachNewThreadSelector:@selector(show) toTarget:alert withObject:nil];
            return NO;
        }
    }
    return YES;
}



#pragma mark - Observers methods

-(void)loadedTwitsByUser:(NSNotification *)notification {
    [self performSelectorOnMainThread:@selector(setTwitList:) withObject:[[TTManagerData shared] searchTwits] waitUntilDone:YES];
}


@end
