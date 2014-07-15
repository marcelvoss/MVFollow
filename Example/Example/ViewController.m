//
//  ViewController.m
//  Example
//
//  Created by Marcel Voß on 01/03/14.
//  Copyright (c) 2014 Marcel Voß. All rights reserved.
//

#import "ViewController.h"

#import "MVFollow.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.usernameTextField.placeholder = @"Enter a Twitter username!";
}

//Follow a specified user using iOS' Native Account Store.
- (IBAction)followButton:(id)sender {
    [self.usernameTextField resignFirstResponder];
    if ([self.usernameTextField.text  isEqual: @""]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Text field is empty!" message:[NSString stringWithFormat:@"You must have atleast 1 character in the text field in order to make a request, silly!"] delegate:self cancelButtonTitle:@"Oh, Okay" otherButtonTitles:nil, nil];
            
            [alert show];
        });
        
    } else {
        MVFollow *followb = [[MVFollow alloc] init];
        [followb.multiaccountsheet showInView:self.view];
        
        MVFollow *followLib = [[MVFollow alloc] init];
        [followLib followUser:self.usernameTextField.text withCompletion:^(BOOL success, NSError *error) {
            
            if (success) {
                NSLog(@"Success!");
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:[NSString stringWithFormat:@"You successfully followed '@%@'", self.usernameTextField.text] delegate:self cancelButtonTitle:@"Hooray!" otherButtonTitles:nil, nil];
                    
                    [alert show];
                });

            } else {
                NSLog(@"Error: %@", error);
                
                if (error == nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't follow user." message:[NSString stringWithFormat:@"Hmm, something went wrong. Your account couldn't follow '@%@'", self.usernameTextField.text] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                        
                        [alert show];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"The following error occured: %@", error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alert show];
                    });
                }
            }
        }];
        
    }
    
    }

//Check all clients to see if they are installed on the user's device (Results are in the log)w
- (IBAction)checkClientInstall:(id)sender {
    MVFollow *clientLib = [[MVFollow alloc] init];
    [clientLib checkIfClientIsInstalled:TwitterClientTwitterrific];
    [clientLib checkIfClientIsInstalled:TwitterClientOfficial];
    [clientLib checkIfClientIsInstalled:TwitterClientWeb];
    [clientLib checkIfClientIsInstalled:TwitterClientTweetings];
    [clientLib checkIfClientIsInstalled:TwitterClientTweetbot];
}

//Open a profile within a client.
- (IBAction)openProfileButton:(id)sender {
    // Replace TwitterClientOfficial with the Twitter client of your choice
    // Check MVFollow.h to find out what clients are currently supported
    [self.usernameTextField resignFirstResponder];
    
    if ([self.usernameTextField.text  isEqual: @""]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Text field is empty!" message:[NSString stringWithFormat:@"You must have atleast 1 character in the text field in order to make a request, silly!"] delegate:self cancelButtonTitle:@"Oh, Okay" otherButtonTitles:nil, nil];
            
            [alert show];
        });} else {

    MVFollow *followLib = [[MVFollow alloc] init];
    [followLib checkIfClientIsInstalled:TwitterClientOfficial];
    if (followLib.isClientInstalled == NO) {
        NSLog(@"Opening profile with web client because requested client is not installed.");
        [followLib openProfile:self.usernameTextField.text inClient:TwitterClientWeb];
    } else {
        [followLib openProfile:self.usernameTextField.text inClient:TwitterClientOfficial];
    }
}
    
}

@end


