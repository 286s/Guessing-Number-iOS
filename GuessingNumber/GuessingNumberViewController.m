//
//  GuessingNumberViewController.m
//  GuessingNumber
//
//  Created by Dev Perfecular on 6/4/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import "GuessingNumberViewController.h"
#import "Record+Manipulate.h"
#import "RecordsTableViewController.h"
#import "UsernameViewController.h"

@interface GuessingNumberViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UsernameViewControllerDelegate>

#pragma mark Global variables
@property (nonatomic, strong) NSString *guess;
@property (nonatomic, strong) NSString *number1;
@property (nonatomic, strong) NSString *number2;
@property (nonatomic, strong) NSString *number3;
@property (nonatomic, strong) NSString *number4;
@property (nonatomic, strong) NSMutableArray *record;
@property (nonatomic, strong) NSArray *candidateNumbers;

#pragma mark UIPickerViews
@property (strong, nonatomic) IBOutlet UIPickerView *picker1;
@property (strong, nonatomic)  IBOutlet UIPickerView *picker2;
@property (strong, nonatomic) IBOutlet UIPickerView *picker3;
@property (strong, nonatomic) IBOutlet UIPickerView *picker4;

#pragma mark Other UIs
@property (strong, nonatomic) IBOutlet UITextView *logs;
@property (strong, nonatomic) IBOutlet UIButton *guessButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *startButton;

#pragma mark NSDate
@property (strong, nonatomic) NSDate *startTime;
@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) UsernameViewController *usernameVC;

@end

@implementation GuessingNumberViewController

@synthesize document = _document;

@synthesize guess = _guess;
@synthesize number1 = _number1;
@synthesize number2 = _number2;
@synthesize number3 = _number3;
@synthesize number4 = _number4;
@synthesize record = _record;
@synthesize candidateNumbers;// = _candidateNumbers;

@synthesize picker1 = _picker1;
@synthesize picker2 = _picker2;
@synthesize picker3 = _picker3;
@synthesize picker4 = _picker4;
@synthesize logs = _logs;

@synthesize startButton = _startButton;
@synthesize guessButton = _guessButton;

@synthesize startTime = _startTime;
@synthesize username = _username;

@synthesize usernameVC = _usernameVC;

#pragma mark All of the getters;
- (NSString *)number1{
    if(!_number1){
        _number1 = [[NSString alloc] init];
    }
    return _number1;
}

- (NSString *)number2{
    if(!_number2){
        _number2 = [[NSString alloc] init];
    }
    return _number2;
}

- (NSString *)number3{
    if(!_number3){
        _number3 = [[NSString alloc] init];
    }
    return _number3;
}

- (NSString *)number4{
    if(!_number4){
        _number4 = [[NSString alloc] init];
    }
    return _number4;
}

- (NSMutableArray *)record{
    if(!_record){
        _record = [[NSMutableArray alloc] init];
    }
    return _record;
}

- (void)useDocument{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.document.fileURL path]]) {
        [self.document saveToURL:self.document.fileURL 
                forSaveOperation:UIDocumentSaveForCreating 
               completionHandler:NULL];
        
    } else if (self.document.documentState == UIDocumentStateClosed) {
        [self.document openWithCompletionHandler:NULL];
    }
}

- (void)setDocument:(UIManagedDocument *)document{
    if (_document != document) {
        _document = document;
        [self useDocument];
    }
}

- (void)setUsernameVC:(UsernameViewController *)usernameVC{
    
    if (_usernameVC != usernameVC) {
        _usernameVC = usernameVC;
        _usernameVC.delegate = self;
    }
}


- (NSString *)guess{
    if(!_guess){
        _guess = [[NSString alloc] init];
    }
    return _guess;
}

#pragma mark View Functions;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picker1.delegate = self;
    self.picker1.dataSource = self;
    self.picker1.tag = 0;
    self.picker2.delegate = self;
    self.picker2.dataSource = self;
    self.picker2.tag = 1;
    self.picker3.delegate = self;
    self.picker3.dataSource = self;
    self.picker3.tag = 2;
    self.picker4.delegate = self;
    self.picker4.dataSource = self;
    self.picker4.tag = 3;
    
    [self.guessButton setEnabled:NO];
    self.candidateNumbers = [[NSArray alloc] initWithObjects: @"1",@"2",@"3",@"4",@"5",
                             @"6",@"7",@"8",@"9", nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload{
    self.picker1 = nil;
    self.picker2 = nil;
    self.picker3 = nil;
    self.picker4 = nil;
    self.guess = nil;
    self.number1 = nil;
    self.number2 = nil;
    self.number3 = nil;
    self.number4 = nil;
    self.logs = nil;
    self.guessButton = nil;
    self.candidateNumbers = nil;
    self.startButton = nil;
    self.record = nil;
//    self.alert = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    if(!self.document){
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        url = [url URLByAppendingPathComponent:@"Default Guessing Number Record Database"];
        self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue 
                 sender:(id)sender{

    if ([segue.destinationViewController respondsToSelector:@selector(setDocument:)]){
        [segue.destinationViewController setDocument:self.document];
    } else if ([segue.identifier isEqualToString:@"filloutUsername"]) {
        [segue.destinationViewController setDelegate:self];
//        [segue.destinationViewController setTitle:@"Username" forState:UIControlStateNormal];
    }
}


#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [self.candidateNumbers count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return [self.candidateNumbers objectAtIndex:row];
}



#pragma mark PickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView 
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 0:
            self.number1 = [self.candidateNumbers objectAtIndex:row];
            break;
        case 1:
            self.number2 = [self.candidateNumbers objectAtIndex:row];
            break;
        case 2:
            self.number3 = [self.candidateNumbers objectAtIndex:row];
            break;
        case 3:
            self.number4 = [self.candidateNumbers objectAtIndex:row];
            break;
        default:
            break;
    }
}


- (void)popupMessageWithTitle: (NSString *)title 
                   andMessage: (NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:msg
                                                   delegate:self 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)setUsername:(NSString *)username{
    self.username = username;
}

- (void)setupUsername:(id)sender{
    if (self.usernameVC == nil) {
        self.usernameVC = [[UsernameViewController alloc] init];
    }
    
    [self.usernameVC setDelegate:self];
//    [self.navigationController pushViewController:self.usernameVC animated:YES];
    [self performSegueWithIdentifier:@"filloutUsername" sender:sender];
}

- (IBAction)haveATry:(id)sender {
    NSString *result = [NSString stringWithFormat:@"%@%@%@%@", self.number1,self.number2, self.number3, self.number4];
    
    if([self checkUniquenessOf:result] == NO){
        [self popupMessageWithTitle:@"Error" andMessage:@"All digits must be distinct"];
        return;
    }

    if([self.record containsObject:result]){
        [self popupMessageWithTitle:@"Notice" andMessage:@"Already Guessed"];
        return; 
    }
    
    [self.record addObject:result];
    
    if([result isEqualToString:self.guess]){

        self.logs.text = [self.logs.text stringByAppendingFormat:@"Congratulations.\n"];
        
        NSDate *now = [NSDate date];
        
        NSTimeInterval interval = [now timeIntervalSinceDate:self.startTime];

        // Fill out the username;
        [self setupUsername:sender];
        // Add data in the database;
        [Record addRecordWithUser:self.username 
                   bySpendingTime:[NSNumber numberWithDouble:interval] 
                  withTimeOfGuess:[NSNumber numberWithInteger:[self.record count]]
                           atTime:now 
           inManagedObjectContext:self.document.managedObjectContext];
        
//        [self popupMessageWithTitle:@"Win" andMessage:@"Congratulations."];

        [self endOfGame];
    }else{
        
        self.logs.text = [self.logs.text stringByAppendingFormat:@"%@: A%dB%d\n", result, [self checkFullyRight:result], [self checkPartiallyRight:result]];
        if([self.record count] >= 8){
            [self endOfGame];
            [self popupMessageWithTitle:@"Game over" andMessage:[NSString stringWithFormat: @"The answer is %@ You have tried %d times w/o success, good luck on next one", self.guess, 8]];
        }
    }
}

- (NSInteger)checkFullyRight:(NSString *)msg{
    int count = 0;
    for(NSInteger i=0; i<msg.length; i++){
        if([self.guess characterAtIndex:i] == [msg characterAtIndex:i])
            count++;
    }
    NSLog(@"%d", count);
    return count;
}

- (NSInteger)checkPartiallyRight:(NSString *)msg{
    int count = 0;
    for(NSInteger i=0; i<msg.length; i++){
        if([self.guess characterAtIndex:i] == [msg characterAtIndex:i]){
            continue;
        }
        for(NSInteger j=0; j<self.guess.length; j++){
            if([self.guess characterAtIndex:j] == [msg characterAtIndex:i]){
                count++;
                break;
            }
        }
    }
//    NSLog(@"%d", count);
//    [self popupMessageWithTitle:@"Partially" andMessage:[NSString stringWithFormat:@"%@", self.guess]];
    return count;
}

- (void)endOfGame{
    
    [self.picker1 selectRow:[self.candidateNumbers count] / 2 inComponent:0 animated:YES];
    [self.picker2 selectRow:[self.candidateNumbers count] / 2 inComponent:0 animated:YES];
    [self.picker3 selectRow:[self.candidateNumbers count] / 2 inComponent:0 animated:YES];
    [self.picker4 selectRow:[self.candidateNumbers count] / 2 inComponent:0 animated:YES];
    
    self.number1 = [self.candidateNumbers objectAtIndex:[self.candidateNumbers count]/2 ];
    self.number2 = [self.candidateNumbers objectAtIndex:[self.candidateNumbers count]/2 ];
    self.number3 = [self.candidateNumbers objectAtIndex:[self.candidateNumbers count]/2 ];
    self.number4 = [self.candidateNumbers objectAtIndex:[self.candidateNumbers count]/2 ];
    
    self.logs.text = @"";
    [self.guessButton setEnabled:NO];
    self.startButton.title = @"New";
    
    [self.record removeAllObjects];
}

- (BOOL)checkUniquenessOf:(NSString *) msg{
    for(NSInteger index = 0; index < msg.length; index++){
        for (NSInteger j=index+1; j<msg.length; j++) {
            if([msg characterAtIndex:index] == [msg characterAtIndex:j])
                return NO;
        }
    }
    return  YES;
}

- (IBAction)startNewGame:(id)sender {
    [self endOfGame];
    self.startButton.title = @"Start";
    [self.guessButton setEnabled:true];
    self.guess = [self generateRandomNumber];
    self.logs.text = @"";
    [self popupMessageWithTitle:@"Result: " andMessage:self.guess];
    
    self.startTime = [NSDate date];
}

- (NSString *)generateRandomNumber{
    NSString *result = nil;
    int a, b, c, d;
    a = arc4random() % 9 + 1;
    do{
        b = arc4random() % 9 + 1;
    }while (a==b);
    
    do{
        c = arc4random() % 9 + 1;
    }while(a==c || b==c);
    
    do{
        d = arc4random() % 9 + 1;
    }while(a==d || b==d || c==d);
    
    result = [NSString stringWithFormat:@"%d%d%d%d", a,b,c,d];
    return result;
}
@end