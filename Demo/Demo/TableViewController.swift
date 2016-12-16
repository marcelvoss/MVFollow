//
//  TableViewController.swift
//  Demo
//
//  Created by Marcel Voß on 13/12/2016.
//  Copyright © 2016 Marcel Voss. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    struct RecommendedFollow {
        var name: String?
        var handle: String?
    }
    
    let textField = UITextField()
    let followSwitch = UISwitch()
    let follow = Follow()
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var recommendedFollows = [RecommendedFollow(name: "Marcel Voss", handle: "uimarcel"),
                              RecommendedFollow(name: "Julia Grill", handle: "juliastic"),
                              RecommendedFollow(name: "Alex Akers", handle: "a2"),
                              RecommendedFollow(name: "Elon Musk", handle: "elonmusk"),
                              RecommendedFollow(name: "New York Times", handle: "nytimes"),
                              RecommendedFollow(name: "Apple", handle: "apple"),
                              RecommendedFollow(name: "Bernie Sanders", handle: "BernieSanders"),
                              RecommendedFollow(name: "Hillary Clinton", handle: "HillaryClinton"),
                              RecommendedFollow(name: "The Verge", handle: "verge")]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Demo"
        //navigationItem.na = activityView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Custom Follow"
        } else if section == 1 {
            return "Settings"
        } else if section == 2 {
            return "Recommended Accounts"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return "If set to off, the demo app will open the selected profile either inside an installed Twitter client or in Safari."
        }
        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return recommendedFollows.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")

        if indexPath.section == 0 {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
            if indexPath.row == 0 {
                cell?.selectionStyle = .none
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.returnKeyType = .done;
                textField.placeholder = "Twitter handle"
                textField.textAlignment = .center
                cell!.contentView.addSubview(textField)
                
                cell?.addConstraint(NSLayoutConstraint(item: textField, attribute: .centerX, relatedBy: .equal, toItem: cell?.contentView, attribute: .centerX, multiplier: 1.0, constant: 0))
                
                cell?.addConstraint(NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: cell?.contentView, attribute: .centerY, multiplier: 1.0, constant: 0))
                
                cell?.addConstraint(NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem: cell?.contentView, attribute: .width, multiplier: 1.0, constant: -60))
                
                
            } else if indexPath.row == 1 {
                cell!.textLabel?.textAlignment = .center
                cell!.textLabel?.text = "Follow"
                cell!.textLabel?.textColor = UIColor(red:0.47, green:0.67, blue:0.98, alpha:1.00)
               
            }
        } else if indexPath.section == 1 {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
            if indexPath.row == 0 {
                cell?.textLabel?.text = "Follow"
                cell?.accessoryView = followSwitch
                
                followSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
                followSwitch.setOn(UserDefaults.standard.bool(forKey: "FollowPerson"), animated: false)
            }
        } else if indexPath.section == 2 {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
            let follow = recommendedFollows[indexPath.row]
            cell!.textLabel?.text = follow.name
            cell!.detailTextLabel?.text = "@\(follow.handle!)"
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFollow = recommendedFollows[indexPath.row]
        
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                followPerson(handle: textField.text)
            }
        } else if indexPath.section == 2 {
            if UserDefaults.standard.bool(forKey: "FollowPerson") {
                followPerson(handle: currentFollow.handle)
            } else {
                _ = follow.showProfile(username: currentFollow.handle!)
            }
        }
    
    }
    
    func followPerson(handle: String?) {
        if let username = handle {
            follow.accounts { (accounts, granted, error) in
                if error == nil && granted {
                    if let actionSheet = self.follow.actionSheet(accounts: accounts, username: username) {
                        DispatchQueue.main.sync {
                            self.present(actionSheet, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func switchValueChanged() {
        UserDefaults.standard.set(followSwitch.isOn, forKey: "FollowPerson")
        UserDefaults.standard.synchronize()
    }
    
}
