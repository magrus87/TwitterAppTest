//
//  TTTwitInfoViewController.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 18.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTTwitInfoViewController.h"

#define PADDING         10.0f

@interface TTTwitInfoViewController ()
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TTTwitInfoViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.twitInfo.user.name;

    self.screenNameLabel.text = [@"@"stringByAppendingString:self.twitInfo.user.screenName];
    self.screenNameLabel.textColor = [UIColor customBlueColor];

    self.dateLabel.text = convertDate(self.twitInfo.createdDate, 0);
    self.dateLabel.textColor = [UIColor twitNoteTextColor];


    UIFont *fontText = SYSTEM_FONT(15.0);
    NSLineBreakMode lineBreakModeText = NSLineBreakByWordWrapping;
    CGSize textSize = [TTUtilities sizeText:self.twitInfo.text font:fontText lineBreakMode:lineBreakModeText availableSize:CGSizeMake(self.dateLabel.frame.origin.x + self.dateLabel.frame.size.width  - self.screenNameLabel.frame.origin.x , MAXFLOAT)];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.screenNameLabel.frame.origin.x, self.screenNameLabel.frame.origin.y + self.screenNameLabel.frame.size.height + PADDING, textSize.width, textSize.height)];
    textLabel.text = self.twitInfo.text;
    textLabel.font = fontText;
    textLabel.lineBreakMode = lineBreakModeText;
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
}


@end
