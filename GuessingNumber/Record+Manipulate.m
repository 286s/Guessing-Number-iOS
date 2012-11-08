//
//  Record+Manipulate.m
//  GuessingNumber
//
//  Created by Dev Perfecular on 6/30/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import "Record+Manipulate.h"

@implementation Record (Manipulate)

+ (Record *)addRecordWithUser:(NSString *)username 
               bySpendingTime:(NSNumber *)time 
              withTimeOfGuess:(NSNumber *)guess
                       atTime:(NSDate *)date
       inManagedObjectContext:(NSManagedObjectContext *)context{
    
    Record *record = nil;
    
    record = [NSEntityDescription insertNewObjectForEntityForName:@"Record" 
                                           inManagedObjectContext:context];
    record.username = username;
    record.timespend = time;
    record.timeOfGuess = guess;
    record.timestamp = date;
    
    return record;
}
                         
+ (NSArray *)fetchTopRecordsinManagedObjectContext:(NSManagedObjectContext *)context{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Record"];
    //    request.predicate;
    //predicate goes default, which will be all of the records;
    request.fetchLimit = 20;
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"timeOfGuess"
                                                                     ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"timespend"
                                                                      ascending:YES];
    NSSortDescriptor *sortDescriptor3 = [NSSortDescriptor sortDescriptorWithKey:@"timestamp"
                                                                      ascending:YES];
    NSSortDescriptor *sortDescriptor4 = [NSSortDescriptor sortDescriptorWithKey:@"username"
                                                                      ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, sortDescriptor3, sortDescriptor4, nil];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || [matches count] == 0) {
        return nil;
    } else {
        return matches;
    }
}

+ (void)clearAllTheRecordsinManagedObjectContext:(NSManagedObjectContext *)context{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Record"];
    //    request.predicate;
    //predicate goes default, which will be all of the records;
    request.fetchLimit = 10;
    NSSortDescriptor *sortDescriptor3 = [NSSortDescriptor sortDescriptorWithKey:@"username"
                                                                      ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor3];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches){
        NSLog(@"%@", error.localizedFailureReason);
    } else {
        
        for (NSManagedObject *record in matches) {
            [context deleteObject:record];
        }
    }
}

@end
