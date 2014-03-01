//
//  MVFollow.h
//  Example
//
//  Created by Marcel Voß on 01/03/14.
//  Copyright (c) 2014 Marcel Voß. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

typedef NS_ENUM(NSInteger, TwitterClient)
{
    TwitterClientWeb,
    TwitterClientTweetbot,
    TwitterClientTwitterrific,
    TwitterClientOfficial
};

@interface MVFollow : NSObject

+ (void)followUser:(NSString *)username;
+ (void)openProfile:(NSString *)username inClient:(TwitterClient)twitterClient;

@end
