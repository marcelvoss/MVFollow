# MVFollow
MVFollow is a simple drop-in solution that allows you to follow people on Twitter natively.

## Usage
This project provides three methods: One method to follow someone on Twitter, a second method to show Twitter profiles in installed clients (like Tweetbot, Twitterrific or the official client), and a third to check the user's device for those installed clients (Using URL schemes).

The 3 methods are VERY easy to use and pretty self explanatory. There's also an example project included. Take a look at it!

``` objc
- (void)followUser:(NSString *)username withCompletion:(void (^)(BOOL success, NSError *error))completion;
```   
``` objc
- (void)openProfile:(NSString *)username inClient:(TwitterClient)twitterClient;
```
``` objc
- (void)checkIfClientisInstalled:(TwitterClient)twitterClient;
```
When using ```checkIfClientisInstalled```, you may use the ```isClientInstalled``` boolean to specify cases.
For example, 
``` objc
    MVFollow *clientLib = [[MVFollow alloc] init];
	if (clientLib.isClientInstalled == YES) {
	DO SOMETHING
	} else {
	DO SOMETHING AGAIN
	}
```

If you use CocoaPods you can simply add `pod 'MVFollow'` to your podfile.

##Clients Available
Currently, MVFollow supports the official Twitter.app, Tweetbot, Twitterrific, Tweetings, and the web client (twitter.com) which is opened by Safari.

To specify a certain client to use in your method, simply replace "TwitterClient" with "TwitterClientTweetbot" or whatever client you are looking to use.

Feel free to add more clients!

##Notes
Multiple user account support is a little janky at the moment. If the user has more than one Twitter account saved on their phone, MVFollow automatically selects the most used account. This is going to work a ***lot*** better soon.
## TODO
- ~~Add multi-account support~~ *(Kind of Done)*
- ~~Add a method to find out which Twitter clients are installed~~
