# MVFollow
MVFollow is a tiny drop-in solution that allows you to follow people on Twitter.

This library requires **iOS 8 or later**.

## Installation
### CocoaPods
MVFollow is available via CocoaPods. Simply add this to your Podfile: `pod 'MVFollow', '~> 0.2.0'` and install it with `pod install`. Boom!

### Carthage



### Manually
Download the latest version, add the MVFollow folder to your project and import it.

## Usage

### Following Accounts


### Handling Multiple Twitter Accounts
If Follow finds more than one Twitter account, it will return an array of ACAccount objects. You should present your user with some kind of UI (for example a UIAlertController with sheet style) and let them select their preferred account.

You can then pass the selected account instance back to MVFollow.


### Showing Profiles using Installed Clients

Although, it's a bit inconvient, you'll have to add the following schemes to the LSApplicationQueriesSchemes array in your application's Info.plist, in order to enable MVFollow to query for installed Twitter clients. Otherwise, iOS will always fail opening it. 

| Scheme| App |
|:--|:--|
|tweetbot|[Tweetbot](http://tapbots.com/tweetbot/)|
|twitter|[Twitter](https://twitter.com)|
|twitteriffic|[Twitteriffic](http://twitterrific.com/ios/)|

![](https://raw.githubusercontent.com/marcelvoss/MVFollow/develop/Preview/preview.png)

## License
MVFollow is available under the MIT license. See the [LICENSE](https://github.com/marcelvoss/MVFollow/blob/master/LICENSE.md) file for more information.
