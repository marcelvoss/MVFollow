//
// MVFollow.m
//
// Copyright (c) 2014 Marcel Voß. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MVFollow.h"
#define TWITTER_API_URL @"https://api.twitter.com/1.1/friendships/create.json"

@implementation MVFollow

- (void)followUser:(NSString *)username withCompletion:(void (^)(BOOL success, NSError *error))completion
{
    ACAccountStore *accountStore = [ACAccountStore new];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted == YES) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            if ([accounts count] == 1) {
             // Only one account is available
                NSLog(@"Only one account is available (%@", accounts);
                
                NSMutableDictionary *parameters = [NSMutableDictionary new];
                [parameters setObject:@"true" forKey:@"follow"];
                [parameters setObject:username forKey:@"screen_name"];
                
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:TWITTER_API_URL] parameters:parameters];
                [request setAccount:[accounts objectAtIndex:0]];
                
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    NSInteger statusCode = [urlResponse statusCode];
                    NSLog(@"Status Code: %li", (long)statusCode);
                    
                    if (statusCode == 200) {
                        BOOL success = YES;
                        completion(success, error);
                    } else {
                        BOOL success = NO;
                        completion(success, error);
                    }
                }];
            } else {
                // If more than one account is available than select the most used one and use it (a better solution is being worked on).
                NSLog(@"Twitter Accounts Stored On Device: %@", accounts);
                NSArray *accounts = [accountStore accountsWithAccountType:accountType];
                    NSMutableDictionary *parameters = [NSMutableDictionary new];
                    [parameters setObject:@"true" forKey:@"follow"];
                    [parameters setObject:username forKey:@"screen_name"];
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:TWITTER_API_URL] parameters:parameters];
                    [request setAccount:[accounts objectAtIndex:0]];
                
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    NSInteger statusCode = [urlResponse statusCode];
                    
                    if (statusCode == 200) {
                        NSLog(@"Status Code: %li (Request was successful)", (long)statusCode);
                        BOOL success = YES;
                        completion(success, error);
                    } else {
                        NSLog(@"Status Code: %li (Something went wrong, could not follow user)", (long)statusCode);
                        BOOL success = NO;
                        completion(success, error);
                    }
                }];

            }
        } else {
            // Account Access was not granted or account not found
            [self openProfile:username inClient:TwitterClientWeb];
        }
    }];
    
}

- (void)openProfile:(NSString *)username inClient:(TwitterClient)twitterClient
{
    // Twitter.app
    if (twitterClient == TwitterClientOfficial)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"twitter://user?screen_name=%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    // Website
    else if (twitterClient == TwitterClientWeb)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"http://twitter.com/%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    // Tweetbot <3
    else if (twitterClient == TwitterClientTweetbot)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"tweetbot:///user_profile/%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    // Twitterrific
    else if (twitterClient == TwitterClientTwitterrific)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"twitterrific:///profile?screen_name=%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    // Tweetings
    else if (twitterClient == TwitterClientTweetings)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"tweetings:///user?screen_name=%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
}


//Check if a certain client is installed (Official Client, Web Client, Tweetbot, Tweetings, Twitterrific). This method will return a YES for true or a FALSE for false. Example: ("TRUE, Tweetbot is installed).
- (void)checkIfClientIsInstalled:(TwitterClient)twitterClient {

if (twitterClient == TwitterClientOfficial) {
    
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]])
        {
            _isClientInstalled = YES;
            NSLog(@"%@, Twitter is installed.", (_isClientInstalled ? @"YES" : @"NO"));

            
        } else {
            _isClientInstalled = NO;
            NSLog(@"%@, Twitter is not installed and cannot be used.", (_isClientInstalled ? @"YES" : @"NO"));

        }
}
    

if (twitterClient == TwitterClientWeb) {
    
        NSLog(@"YES, Safari can open the web client");
    
        //No if statement as Safari itself does not have "http://" registered as a native URL scheme, So it would return NO even though it can open "http://" requests.
    }
    
    
if (twitterClient == TwitterClientTweetbot) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]])
        {
            _isClientInstalled = YES;
            NSLog(@"%@, Tweetbot is installed.", (_isClientInstalled ? @"YES" : @"NO"));
            
        } else {
            _isClientInstalled = NO;
            NSLog(@"%@, Tweetbot is not installed and cannot be used.", (_isClientInstalled ? @"YES" : @"NO"));
        }
    }
    
    if (twitterClient == TwitterClientTwitterrific) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]])
        {
            _isClientInstalled = YES;
            NSLog(@"%@, Twitterrific is installed.", (_isClientInstalled ? @"YES" : @"NO"));
            
        } else {
            _isClientInstalled = NO;
            NSLog(@"%@, Twitterrific is not installed and cannot be used.", (_isClientInstalled ? @"YES" : @"NO"));
        }
    }
    
    if (twitterClient == TwitterClientTweetings) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings://"]])
        {
            _isClientInstalled = YES;
            NSLog(@"%@, Tweetings is installed.", (_isClientInstalled ? @"YES" : @"NO"));
            
        } else {
            _isClientInstalled = NO;
            NSLog(@"%@, Tweetings is not installed and cannot be used.", (_isClientInstalled ? @"YES" : @"NO"));

        }
    }
    
    
}


@end