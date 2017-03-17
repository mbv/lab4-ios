//
//  UserTableViewController.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeGesture()
    }
    
    private func setupSwipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes))
        swipeLeft.direction = .left
        
        view.addGestureRecognizer(swipeLeft)
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            tabBarController?.selectedIndex = (tabBarController?.selectedIndex)! + 1
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserModel.sharedInstance.getUsers().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = UserModel.sharedInstance.getUsers()[indexPath.row]
        
        cell.textLabel?.text = user.fullName
        cell.imageView?.sd_setImage(with: URL(string: user.image), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueUserDetailView") {
            let detailViewController = segue.destination as! DetailUserViewController
            detailViewController.userId = self.tableView.indexPathForSelectedRow?.row
        }
    }

}
