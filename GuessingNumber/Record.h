//
//  Record.h
//  GuessingNumber
//
//  Created by Dev Perfecular on 7/9/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Record : NSManagedObject

@property (nonatomic, retain) NSNumber * timeOfGuess;
@property (nonatomic, retain) NSNumber * timespend;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSDate * timestamp;

@end
