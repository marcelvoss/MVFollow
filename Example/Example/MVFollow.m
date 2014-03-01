//
//  MVFollow.m
//  Example
//
//  Created by Marcel Voß on 01/03/14.
//  Copyright (c) 2014 Marcel Voß. All rights reserved.
//

#import "MVFollow.h"

#define TWITTER_API_URL @"https://api.twitter.com/1.1/friendships/create.json"

@implementation MVFollow

+ (void)followUser:(NSString *)username
{
    ACAccountStore *accountStore = [ACAccountStore new];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
    {
        if (granted)
        {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            if ([accounts count] > 0)
            {
                // Only one account is available
                NSMutableDictionary *dictionary = [NSMutableDictionary new];
                [dictionary setObject:@"true" forKey:@"follow"];
                [dictionary setObject:username forKey:@"screen_name"];
                
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:TWITTER_API_URL] parameters:dictionary];
                [request setAccount:[accounts objectAtIndex:0]];
                
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                {
                    NSInteger statusCode = [urlResponse statusCode];
                    NSLog(@"Status Code: %li", statusCode);
                    
                    if (statusCode == 404) {
                        NSLog(@"Not Found");
                    }
                    else if (statusCode == 403)
                    {
                        NSLog(@"Forbidden");
                    }
                    else if (statusCode == 200)
                    {
                        NSLog(@"Success");
                    }
                    else if (statusCode == 500)
                    {
                        NSLog(@"Internal Server Error");
                    }
                    else if (statusCode == 502)
                    {
                        NSLog(@"Bad Gateway");
                    }
                    else if (statusCode == 503)
                    {
                        NSLog(@"Service Unavailable");
                    }
                    else if (statusCode == 504)
                    {
                        NSLog(@"Gateway Timeout");
                    }
                    
                    if (error != nil) {
                        NSLog(@"%@", error);
                    }
                }];
            }
        }
    }];
}

+ (void)openProfile:(NSString *)username inClient:(TwitterClient)twitterClient
{
    if (twitterClient == TwitterClientOfficial)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"twitter://user?screen_name=%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    else if (twitterClient == TwitterClientWeb)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"http://twitter.com/%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    else if (twitterClient == TwitterClientTweetbot)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"tweetbot:///user_profile/%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    else if (twitterClient == TwitterClientTwitterrific)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"twitterrific:///profile?screen_name=%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
}

@end