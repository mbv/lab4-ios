//
//  WeatherViewController.swift
//  lab4
//
//  Created by Konstantin Terehov on 3/17/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSwipeGesture();
    }
    
    private func setupSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes))
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeRight)
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .right) {
            tabBarController?.selectedIndex = (tabBarController?.selectedIndex)! - 1
        }
    }
}
