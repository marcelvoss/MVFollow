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
    
    var availableAccounts: [ACAccount]?
    
    func actionSheet(accounts: [ACAccount]?, username: String) -> UIAlertController? {
        if let accountArray = accounts {
            let actionSheet = UIAlertController(title: nil, message: "Choose account for following @\(username)", preferredStyle: .actionSheet)
            
            for item in accountArray {
                actionSheet.addAction(UIAlertAction(title: item.username, style: .default, handler: { (action) in
                    self.follow(username: username, account: item, completionHandler: { (success, error) in
                        actionSheet.dismiss(animated: true, completion: {
                            if error != nil {
                                let alertController = UIAlertController(title: "Error", message: "Couldn't follow @\(username) with error \(error?.localizedDescription).", preferredStyle: .alert)
                                
                                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }
                        })
                    })
                }))
            }
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            return actionSheet
        }
        return nil
    }
    
    func accounts(completionHandler:@escaping ([ACAccount]?, Bool, Error?) -> Void) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType, options: nil) {(granted: Bool, error: Error?) -> Void in
            if granted {
                let accounts = accountStore.accounts(with: accountType) as? [ACAccount]
                self.availableAccounts = accounts
                completionHandler(accounts, true, error)
            }
            completionHandler(nil, false, error)
        }
    }
    
    func follow(username: String, account: ACAccount, completionHandler:@escaping (Bool, Error?) -> Void) {
        let requestParameters = ["follow": "true", "screen_name": username]
        performFollowRequest(account: account, parameters: requestParameters, completionHandler: { (error) in
            if error == nil {
                completionHandler(false, error)
            } else {
                completionHandler(true, error)
            }
        })
    }
    
    func showProfile(username: String) -> Bool {
        if canOpenApplication(identifier: "twitter://") {
            // Twitter.app
            return openApplication(string: "twitter://user?screen_name=\(username)")
        } else if canOpenApplication(identifier: "tweetbot://") {
            // Tweetbot
            return openApplication(string: "tweetbot:///user_profile/\(username)")
        } else if canOpenApplication(identifier: "twitterrific://") {
            // Twitterrific
            return openApplication(string: "twitterrific:///profile?screen_name=\(username)")
        } else {
            // Web
            return openApplication(string: "http://twitter.com/\(username)")
        }
    }
    
    
    // MARK: - Private
    
    private func openApplication(string: String) -> Bool {
        if let url = URL(string: string) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                // TODO: Add handling
            })
        }
        return false
    }
    
    private func canOpenApplication(identifier: String) -> Bool {
        if let url = URL(string: identifier) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    private func performFollowRequest(account: ACAccount?, parameters: [String:String], completionHandler:@escaping (Error?) -> Void) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .POST,
                                url: URL(string: "https://api.twitter.com/1.1/friendships/create.json"), parameters: parameters)
        request?.account = account
        request?.perform(handler: { (data, response, error) in
            let statusCode = response?.statusCode
            
            if error == nil && (statusCode == 200 || statusCode == 201) {
                completionHandler(nil)
            } else {
                completionHandler(error)
            }
        })
    }
    
    
    
}


