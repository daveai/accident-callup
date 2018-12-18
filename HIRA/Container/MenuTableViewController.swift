//
//  MenuTableViewController.swift
//  HIRA
//
//  Created by Debashis  on 26/12/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit
protocol MenuViewDelegate {
    func didSelectAMenu(selectedMenu:[String:String])
}
class MenuTableViewController: UITableViewController {
    var menuViewDelegate:MenuViewDelegate?
    let menus = [
        [
            ["name":"Dashboard", "root":"DASHBOARD"],
            ["name":"Refer", "root":"UPDATE_PROFILE"],
            ["name":"Profile", "root":"CHANGE_PASSWORD"]
        ],
        [
            ["name":"", "root":""],
            ["name":"Refer", "root":"REFER"]
        ],
        [
            ["name":"", "root":""],
            ["name":"", "root":""]
        ]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuViewDelegate?.didSelectAMenu(selectedMenu: menus[indexPath.section][indexPath.row])
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        UserDefaults.standard.setValue(nil, forKey: "x_auth_token")
        UserDefaults.standard.setValue(nil, forKey: "current_user_id")
        let containerStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = containerStoryBoard.instantiateViewController(withIdentifier: "login_nav") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = initialViewController
    }
}
