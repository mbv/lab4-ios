//
//  DetailUserViewController.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit
import SDWebImage

class DetailUserViewController: UIViewController {
    
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var userId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = UserModel.sharedInstance.getUsers()[userId]
        labelTitle.text = user.fullName
        if (user.imageBig != nil) {
            imageUser.sd_setImage(with: URL(string: user.imageBig), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        } else {
            imageUser.image = #imageLiteral(resourceName: "placeholder");
        }
        labelDescription.text = user.description
    }

}
