//
//  MVFollow.m
//  Example
//
//  Created by Marcel Voß on 01/03/14.
//  Copyright (c) 2014 Marcel Voß. All rights reserved.
//

#import "MVFollow.h"

@implementation MVFollow

+ (void)followUser:(NSString *)username
{
    
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
        NSString *clientWithUsername = [NSString stringWithFormat:@"tweetbot://%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
    else if (twitterClient == TwitterClientTwitterrific)
    {
        NSString *clientWithUsername = [NSString stringWithFormat:@"twitterrific://profile?=screen_name=%@", username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clientWithUsername]];
    }
}

@end
