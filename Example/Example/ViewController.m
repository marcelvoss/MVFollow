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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.usernameTextField.placeholder = @"Enter a Twitter username!";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)followButton:(id)sender
{
    MVFollow *followLib = [[MVFollow alloc] init];
    [followLib followUser:self.usernameTextField.text withCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Success!");
        } else {
            NSLog(@"Error: %@", error);
            
            if (error == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't follow" message:[NSString stringWithFormat:@"Couldn't follow %@", self.usernameTextField.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
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

- (IBAction)openProfileButton:(id)sender
{
    // Replace TwitterClientOfficial with the Twitter client of your choice
    // Check MVFollow.h to find out what clients are currently supported
    MVFollow *followLib = [[MVFollow alloc] init];
    [followLib openProfile:self.usernameTextField.text inClient:TwitterClientWeb];
}

@end
