# MVFollow
MVFollow is a simple drop-in solution that allows you to follow people on Twitter natively.

This library requires **iOS 6 or later**.

## Installation
### CocoaPods
MVFollow is available via CocoaPods. Simply add this to your Podfile: `pod 'MVFollow', '~> 0.2.0'` and install it with `pod install`. Boom!

### Without CocoaPods
Download the latest version, add the MVFollow folder to your project and import it.

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
For example:
``` objc
MVFollow *followLib = [[MVFollow alloc] init];
	if (clientLib.isClientInstalled == YES) {
		// DO SOMETHING
	} else {
		// DO SOMETHING AGAIN
}
```

If you use CocoaPods you can simply add `pod 'MVFollow'` to your podfile.

## Clients Available
Currently, MVFollow supports the official Twitter.app, Tweetbot, Twitterrific, Tweetings, and the web client (twitter.com) which is opened by Safari.

To specify a certain client to use in your method, simply replace "TwitterClient" with "TwitterClientTweetbot" or whatever client you are looking to use.

## Notes
Multiple user account support is a little janky at the moment. If the user has more than one Twitter account saved on their phone, MVFollow automatically selects the most used account. This is going to work a ***lot*** better soon.

## License
MVFollow is available under the MIT license. See the [LICENSE](https://github.com/marcelvoss/MVFollow/blob/master/LICENSE.md) file for more information.
