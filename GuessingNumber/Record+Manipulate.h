//
//  Record+Manipulate.h
//  GuessingNumber
//
//  Created by Dev Perfecular on 6/30/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import "Record.h"

@interface Record (Manipulate)

+ (Record *)addRecordWithUser:(NSString *)username 
               bySpendingTime:(NSNumber *)time 
              withTimeOfGuess:(NSNumber *)guess
                       atTime:(NSDate *)date
       inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)fetchTopRecordsinManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)clearAllTheRecordsinManagedObjectContext:(NSManagedObjectContext *)context;

@end
