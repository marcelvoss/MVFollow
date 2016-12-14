//
//  Follow.swift
//  Example
//
//  Created by Marcel Voß on 09/12/2016.
//  Copyright © 2016 Marcel Voß. All rights reserved.
//

import UIKit
import Accounts
import Social

class Follow: NSObject {
    
    func accounts(completionHandler:@escaping ([ACAccount]?, Bool, Error?) -> Void) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType, options: [:]) {(granted: Bool, error: Error?) -> Void in
            if granted {
                let accounts = accountStore.accounts(with: accountType) as? [ACAccount]
                completionHandler(accounts, true, error)
            }
            completionHandler(nil, false, error)
        }
    }
    
    func follow(username: String, account: ACAccount? = nil, completionHandler:@escaping (Bool, Error?) -> Void) {
        if account != nil {
            let requestParameters = ["follow": "true", "screen_name": username]
            performFollowRequest(account: account, parameters: requestParameters)
        } else {
            let accountStore = ACAccountStore()
            let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
            accountStore.requestAccessToAccounts(with: accountType, options: [:]) {(granted: Bool, error: Error?) -> Void in
                
                if granted {
                    
                } else {
                    self.showProfile(username: username)
                }
                
            }
        }
    }

    func showProfile(username: String) {
        if canOpenApplication(identifier: "twitter://") {
            // Twitter.app
            _ = openApplication(string: "twitter://user?screen_name=\(username)")
        } else if canOpenApplication(identifier: "tweetbot://") {
            // Tweetbot
            _ = openApplication(string: "tweetbot:///user_profile/\(username)")
        } else if canOpenApplication(identifier: "twitterrific://") {
            // Twitterrific
            _ = openApplication(string: "twitterrific:///profile?screen_name=\(username)")
        } else {
            // Web
            _ = openApplication(string: "http://twitter.com/\(username)")
        }
    }
    
    
    // MARK: - Private
    
    private func openApplication(string: String) -> Bool {
        if let url = URL(string: string) {
            return UIApplication.shared.openURL(url)
        }
        return false
    }
    
    private func canOpenApplication(identifier: String) -> Bool {
        if let url = URL(string: identifier) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    private func performFollowRequest(account: ACAccount?, parameters: [String:String]) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .POST,
                                url: URL(string: "https://api.twitter.com/1.1/friendships/create.json"), parameters: parameters)
        request?.account = account
        request?.perform(handler: { (data, response, error) in
            let statusCode = response?.statusCode
            
            if error == nil && (statusCode == 200 || statusCode == 201) {
                
            } else {
                
            }
            
        })
    }
    
    

}


