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
    
    /// Generates a UIAlertController with action sheet style, including actions for every Twitter account that was found in the ACAccountStore. The actions are configured as well and will follow the specified user with an account selected by the user.
    ///
    /// - Parameters:
    ///   - accounts: The account array that shall be used to generate the action sheet.
    ///   - username: The username that shall be followed.
    /// - Returns: A UIAlertController with action sheet style.
    func actionSheet(accounts: [ACAccount]?, username: String) -> UIAlertController? {
        if let accountArray = accounts {
            let actionSheet = UIAlertController(title: nil, message: "Choose account for following @\(username)", preferredStyle: .actionSheet)
            
            for account in accountArray {
                actionSheet.addAction(UIAlertAction(title: account.username, style: .default, handler: { (action) in
                    self.follow(username: username, account: account, completionHandler: { (success, error) in
                        actionSheet.dismiss(animated: true, completion: {
                            if error != nil {
                                let alertController = UIAlertController(title: "Error", message: "Couldn't follow @\(username). \(error?.localizedDescription).", preferredStyle: .alert)
                                
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
    
    /// Retrieves an array of ACAccounts with the ACAccountTypeIdentifierTwitter.
    ///
    /// - Parameter completionHandler: A closure with an array of ACAccounts, a boolean determining wether the retrival was succesful and an error instance containing a more described error description.
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
    
    /// Follows the user with the specified username with the specified account.
    ///
    /// - Parameters:
    ///   - username: The user to follow.
    ///   - account: The account that shall follow.
    ///   - completionHandler: A closure containing a boolean for determining wether following was successful and an error instance containing a more described error description.
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
    
    /// Opens the profile of the specified user in an installed Twitter client or in Safari.
    ///
    /// - Parameter username: The user's Twitter handle.
    /// - Returns: A boolean determining wether it was possible to open the Twitter profile.
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
        var successful = false
        if let url = URL(string: string) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                successful = success
            })
        }
        return successful
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


