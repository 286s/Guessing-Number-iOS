//
//  UsernameViewController.m
//  GuessingNumber
//
//  Created by Dev Perfecular on 7/10/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import "UsernameViewController.h"

@interface UsernameViewController ()

@end

@implementation UsernameViewController

@synthesize usernameTextField = _usernameTextField;
@synthesize confirmButton = _confirmButton;
@synthesize delegate = _delegate;

- (BOOL) textFieldShouldReturn: (UITextField *) theTextField
{
    [self.delegate setUsername:self.usernameTextField.text];
    [theTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[self delegate] setUsername:self.usernameTextField.text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setUsernameTextField:nil];
    [self setConfirmButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.delegate setUsername:self.usernameTextField.text];
//    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
