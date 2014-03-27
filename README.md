# MVFollow
MVFollow is a drop-in solution that allows you to follow people on Twitter.

## Usage
This project provides two methods: One method to follow someone on Twitter and a second method to show Twitter profiles in installed clients (like Tweetbot, Twitterrific or the official client).

Both methods are VERY easy to use and pretty much self explanatory. There's also an example project included. Take a look at it!

``` objc
+ (void)followUser:(NSString *)username;  
```   
``` objc
+ (void)openProfile:(NSString *)username inClient:(TwitterClient)twitterClient;
```

If you use CocoaPods you can simply add `pod 'MVFollow'` to your podfile.

Feel free to add more Twitter clients!

## TODO
- <del>Add multi-account support</del>
- Add a method to find out which Twitter clients are installed
