//
//  RecordsViewController.m
//  GuessingNumber
//
//  Created by Dev Perfecular on 6/30/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import "RecordsTableViewController.h"
#import "Record+Manipulate.h"
#import "RecordTableViewCell.h"

@interface RecordsViewController ()
@end

@implementation RecordsViewController
@synthesize document = _document;

- (void)setupFetchedResultsController{
    
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

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request 
                                                                        managedObjectContext:self.document.managedObjectContext 
                                                                          sectionNameKeyPath:nil 
                                                                                   cacheName:nil];
}

- (void)setDocument:(UIManagedDocument *)document{
    if (_document != document) {
        _document = document;
        self.title = @"ScoreBoard";
        [self useDocument];
    }
}

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.document.fileURL path]]) {
        [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.document.documentState == UIDocumentStateClosed) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.document.documentState == UIDocumentStateNormal) {
        [self setupFetchedResultsController];
    }
}

- (IBAction)clearRecords:(UIBarButtonItem *)sender {
    
    [Record clearAllTheRecordsinManagedObjectContext:self.document.managedObjectContext];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    self.document = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellOfRecords";
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Record *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.rank.text = [NSString stringWithFormat:@"%02d", [indexPath row] + 1];
    cell.username.text = record.username;
    cell.timeOfGuess.text = [NSString stringWithFormat:@"%d", [record.timeOfGuess intValue]];
    cell.timeSpend.text = [NSString stringWithFormat:@"%d", [record.timespend intValue]];

    return cell;
}
@end
