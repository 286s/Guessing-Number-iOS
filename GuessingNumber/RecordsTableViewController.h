//
//  RecordsViewController.h
//  GuessingNumber
//
//  Created by Dev Perfecular on 6/30/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface RecordsViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *document;

@end
