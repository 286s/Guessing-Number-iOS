//
//  RecordTableViewCell.m
//  GuessingNumber
//
//  Created by Dev Perfecular on 7/9/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

@synthesize username = _username;
@synthesize rank = _rank;
@synthesize timeOfGuess = _timeOfGuess;
@synthesize timeSpend = _timeSpend;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
