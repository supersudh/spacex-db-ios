//
//  SideMenuController.swift
//  SpaceX-Dashboard
//
//  Created by iOS Dev on 02/08/21.
//

import UIKit

class SideMenuController: UIViewController {

    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var menuTable: UITableView!
    var menuItems = ["Popular Movies"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Blank footer view
        self.menuTable.tableFooterView = UIView()
        self.menuTable.dataSource = self
        
        let userName = AppUserDefaults.value(forKey: .loggedInUserName, fallBackValue: "").stringValue
        usernameLable.text = userName
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        AppUserDefaults.removeLoggedInUserData()
        if let drawerVC = self.parent as? KYDrawerController {
            drawerVC.setDrawerState(.closed, animated: true)
        }
        let objAppDelegate = UIApplication.shared.delegate as? AppDelegate
        objAppDelegate?.manageFirstScreen()
    }
}
extension SideMenuController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count + 1 // For Logout button
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row <= menuItems.count - 1 {
            // Show Menu cell
            let menuItemCell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
            menuItemCell.lblMenuItem.text = menuItems[indexPath.row]
            // currently we have only one screen so making first cell background color to gray to identify this screen is active
            if indexPath.row == 0 {
                menuItemCell.backgroundColor = .lightGray
            } else {
                menuItemCell.backgroundColor = .clear
            }
            menuItemCell.selectionStyle = .none
            return menuItemCell
        } else {
            // Show Logout button
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "MenuButtonCell", for: indexPath) as! MenuButtonCell
            buttonCell.selectionStyle = .none
            return buttonCell
        }
    }
    
}
