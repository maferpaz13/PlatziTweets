//
//  WelcomeViewController.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    // MARK - Outlets
    @IBOutlet weak var loginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
    }

}
