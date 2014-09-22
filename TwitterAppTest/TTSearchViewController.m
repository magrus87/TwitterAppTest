//
//  TTSearchViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 21.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTSearchViewController.h"

#define SEARCH_BAR_TEX_DEFAULT      @"Поиск пользователей"

#define kImageCornerRadiusWidth     25.0f
#define kImageCornerRadiusHeight    25.0f
#define kImageWidth                 30.0f
#define kImageHeight                30.0f

@interface TTSearchViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation TTSearchViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Setters

-(void)setUserList:(NSArray *)userList {
    _userList = userList;
    [NSThread detachNewThreadSelector:@selector(reloadData) toTarget:self.tableView withObject:nil];
}


#pragma Table View Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.userList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *CellIdentifier = @"CellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    TTUser *user = [self.userList objectAtIndex:indexPath.row];

    cell.textLabel.text = user.name;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = SYSTEM_FONT(15.0);

    if ([[[TTManagerData shared] images] objectForKey:user.imageUrl]) {
        UIImage *image = [UIImage imageWithRoundCornersFromImage:[[[TTManagerData shared] images] objectForKey:user.imageUrl] cornerWidth:kImageCornerRadiusWidth cornerHeight:kImageCornerRadiusHeight];
        cell.imageView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(kImageWidth, kImageHeight)];
    }
    else {
        UIImage *image = [UIImage imageWithRoundCornersFromImage:[UIImage imageNamed:@"default_profile_4_normal"] cornerWidth:kImageCornerRadiusWidth cornerHeight:kImageCornerRadiusHeight];
        cell.imageView.image = [UIImage imageWithImage:image scaledToSize:CGSizeMake(kImageWidth, kImageHeight)];

        [[TTManagerData shared] loadImageWithUrl:user.imageUrl completion:^(UIImage *image) {
            UIImage *imageLoaded = [UIImage imageWithRoundCornersFromImage:image cornerWidth:kImageCornerRadiusWidth cornerHeight:kImageCornerRadiusHeight];
            cell.imageView.image = [UIImage imageWithImage:imageLoaded scaledToSize:CGSizeMake(kImageWidth, kImageHeight)];
        }];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TTUser *user = [_userList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segue_toTwitsByUser" sender:user];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    return indexPath;
}


#pragma mark - SearchBar Delegate


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

    searchBar.showsCancelButton = YES;
    if ([searchBar.text isEqualToString:SEARCH_BAR_TEX_DEFAULT]) {
        searchBar.text = @"";
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    if (searchBar.text.length == 0) {
        searchBar.text = SEARCH_BAR_TEX_DEFAULT;
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //todo: запустить поиск (если успею)
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = SEARCH_BAR_TEX_DEFAULT;
    searchBar.showsCancelButton = NO;
    [self setUserList:@[]];
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START_NETWORK_REQUEST object:nil];
    [[TTManagerData shared] searchUser:searchBar.text];
    [searchBar resignFirstResponder];
}



#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"segue_toTwitsByUser"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START_NETWORK_REQUEST object:nil];
        [[TTManagerData shared] loadTwitsForUserName:((TTUser *)sender).screenName];
    }
}


@end
