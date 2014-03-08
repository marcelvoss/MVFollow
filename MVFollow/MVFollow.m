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

+ (void)followUser:(NSString *)username
{
    ACAccountStore *accountStore = [ACAccountStore new];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted == YES) {
            // Account Access was granted
            NSLog(@"Access to Account Store was granted.");
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            if ([accounts count] == 1) {
                // Only one account is available
                NSMutableDictionary *dictionary = [NSMutableDictionary new];
                [dictionary setObject:@"true" forKey:@"follow"];
                [dictionary setObject:username forKey:@"screen_name"];
                
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:TWITTER_API_URL] parameters:dictionary];
                [request setAccount:[accounts objectAtIndex:0]];
                
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    NSInteger statusCode = [urlResponse statusCode];
                    NSLog(@"Status Code: %li", (long)statusCode);
                    
                    if (statusCode == 404) {
                        NSLog(@"Not Found");
                    }
                    else if (statusCode == 403) {
                        NSLog(@"Forbidden");
                    }
                    else if (statusCode == 200) {
                        NSLog(@"Success");
                    }
                    else if (statusCode == 500) {
                        NSLog(@"Internal Server Error");
                    }
                    else if (statusCode == 502) {
                        NSLog(@"Bad Gateway");
                    }
                    else if (statusCode == 503) {
                        NSLog(@"Service Unavailable");
                    }
                    else if (statusCode == 504) {
                        NSLog(@"Gateway Timeout");
                    }
                    
                    if (error != nil) {
                        NSLog(@"%@", error);
                    }
                }];
            } else {
                // If more than one account is available
                NSString *baseURL = @"http://twitter.com/";
                NSString *twitterURL = [baseURL stringByAppendingString:username];
                NSLog(@"URL: %@", twitterURL);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:twitterURL]];
            }
        } else {
            // Account Access was not granted
            NSLog(@"Access to Account Store was NOT granted.");
            [self openProfile:username inClient:TwitterClientWeb];
        }
    }];
}

+ (void)openProfile:(NSString *)username inClient:(TwitterClient)twitterClient
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

@end