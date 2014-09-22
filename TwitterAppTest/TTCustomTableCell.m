//
//  TTCustomTableCell.m
//  TwitterAppTest
//
//  Created by Александр Макаров on 20.09.14.
//  Copyright (c) 2014 Александр Макаров. All rights reserved.
//

#import "TTCustomTableCell.h"

#define PADDING_BETWEEN_NAME_LABELS     5.0f


@interface TTCustomTableCell()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *textTwitLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TTCustomTableCell

-(void)setUserName:(NSString *)userName {
    _userName = [userName copy];
    self.nameLabel.text = _userName;
}

-(void)setUserScreenName:(NSString *)userScreenName {
    _userScreenName = [userScreenName copy];
    self.screenNameLabel.text = [@"@" stringByAppendingString:_userScreenName];
}

-(void)setText:(NSString *)text {
    _text = [text copy];
    self.textTwitLabel.text = _text;
}

-(void)setDate:(NSString *)date {
    _date = [date copy];
    self.dateLabel.text = _date;
}

-(void)layoutSubviews {
//    [super layoutSubviews];

    CGSize sizeText = [TTUtilities sizeText:self.nameLabel.text font:self.nameLabel.font lineBreakMode:self.nameLabel.lineBreakMode availableSize:CGSizeMake(self.bounds.size.width - self.nameLabel.frame.origin.x*2, self.nameLabel.bounds.size.height)];

    CGRect frame;

    frame = self.nameLabel.frame;
    frame.size.width = sizeText.width;
    self.nameLabel.frame = frame;

    frame = self.screenNameLabel.frame;
    frame.origin.x = self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + PADDING_BETWEEN_NAME_LABELS;
    self.screenNameLabel.frame = frame;

    self.dateLabel.textColor = [UIColor twitNoteTextColor];
    self.screenNameLabel.textColor = [UIColor twitNoteTextColor];
}

@end
