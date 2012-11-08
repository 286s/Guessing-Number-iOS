//
//  RecordTableViewCell.h
//  GuessingNumber
//
//  Created by Dev Perfecular on 7/9/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *username;
@property (nonatomic, weak) IBOutlet UILabel *rank;
@property (nonatomic, weak) IBOutlet UILabel *timeOfGuess;
@property (nonatomic, weak) IBOutlet UILabel *timeSpend;

@end
