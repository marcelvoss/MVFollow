# MVFollow
![](https://img.shields.io/cocoapods/v/MVFollow.svg) ![](https://img.shields.io/badge/Swift-3.0-orange.svg)

MVFollow is a tiny drop-in solution that allows you to follow people on Twitter.

This library requires **iOS 10 or later**.

Since Apple *deprecated* Twitter integration in iOS 11, **don't expect any future updates to MVFollow**. 

![](https://github.com/marcelvoss/MVFollow/blob/master/Preview/Deprecation.png?raw=true)


## Installation
### CocoaPods
MVFollow is available via CocoaPods. Simply add this to your Podfile: `pod 'MVFollow', '~> 0.3.0'` and install it with `pod install`. Boom!

### Manually
Download the latest version, add the MVFollow folder to your project and import it.

## Usage

### Following Accounts

You basically need to use two different methods to follow an account: the `accounts(completionHandler:)` and the `follow(username:, account:, completionHandler:)` method. 

The `accounts(completionHandler:)` method returns a closure with an array of `ACAccount` instances that represent all Twitter accounts on the user's device. You should also check wether the boolean in the closure is set to `true` and wether the error instance is nil, in order to present your user with an appropriate UI in case of an error.

After accessing the Twitter accounts, you can call the `follow(username:, account:, completionHandler:)` method and pass it the username you want to follow and the ACAccount instance that is supposed to follow.

### Handling Multiple Twitter Accounts
Since the `accounts(completionHandler:)` method returns an array of ACAccount instances, you should check if the array's count is greater than one.

If that is the case, you should present your user with some kind of UI (for example a UIAlertController with action sheet style) and let them select their preferred Twitter account. MVFollow also provides a quite simple method that takes care of that setup.

The `actionSheet(accounts:, username:)` method takes an array of ACAccounts, the username you want to follow and returns a UIAlertController with action sheet style and a UIAlertAction for every found Twitter account.


### Showing Profiles using Installed Clients

Although, it's a bit inconvient, you'll have to add the following schemes to the `LSApplicationQueriesSchemes` array in your application's Info.plist, in order to enable MVFollow to query for installed Twitter clients. Otherwise, iOS will always fail trying to open it. 

| Scheme| App |
|:--|:--|
|tweetbot|[Tweetbot](http://tapbots.com/tweetbot/)|
|twitter|[Twitter](https://twitter.com)|
|twitteriffic|[Twitteriffic](http://twitterrific.com/ios/)|

![](https://raw.githubusercontent.com/marcelvoss/MVFollow/develop/Preview/preview.png)

## License
MVFollow is available under the MIT license. See the [LICENSE](https://github.com/marcelvoss/MVFollow/blob/master/LICENSE.md) file for more information.
