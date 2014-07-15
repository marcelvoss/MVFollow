//
// MVFollow.h
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

// CURRENTLY SUPPORTED CLIENTS: Twitter.app, Tweetbot, Twitterrific, and Tweetings.

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

typedef enum {
    TwitterClientWeb,
    TwitterClientTweetbot,
    TwitterClientTwitterrific,
    TwitterClientOfficial,
    TwitterClientTweetings
} TwitterClient;

@interface MVFollow : NSObject

/**
 Follows a user directly without a client and simply accesses the iOS account store.
 @param username The username to follow.
*/
- (void)followUser:(NSString *)username withCompletion:(void (^)(BOOL success, NSError *error))completion;

/**
 Shows the Twitter profile of the selected user in an installed client.
 @param username The username to show.
 @param twitterClient The client to show the user profile in.
*/
- (void)openProfile:(NSString *)username inClient:(TwitterClient)twitterClient;

- (void)checkIfClientIsInstalled:(TwitterClient)twitterClient;

@property BOOL isClientInstalled;
@property UIActionSheet *multiaccountsheet;


@end
