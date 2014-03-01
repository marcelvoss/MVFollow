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
    
    self.usernameTextField.placeholder = @"Handle";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)followButton:(id)sender
{
    [MVFollow followUser:self.usernameTextField.text];
}

- (IBAction)openProfileButton:(id)sender
{
    // Replace TwitterClientOfficial with the Twitter client of your choice
    [MVFollow openProfile:self.usernameTextField.text inClient:TwitterClientOfficial];
}

@end
