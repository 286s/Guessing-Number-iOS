//
//  UsernameViewController.h
//  GuessingNumber
//
//  Created by Dev Perfecular on 7/10/12.
//  Copyright (c) 2012 Perfecular Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UsernameViewControllerDelegate <NSObject>

@optional 
- (void) setUsername:(NSString *)username;

@end

@interface UsernameViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (retain) id<UsernameViewControllerDelegate> delegate;

@end
