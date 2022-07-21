//
//  ValidationView.swift
//  PlatziTweets
//
//  Created by Maria Fernanda Paz Rodriguez on 6/06/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit

class ValidationView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.validaciones()
    }
    
    func validaciones() {
        
        let defaults = UserDefaults.standard
        
        if let loginInfo = defaults.object(forKey: "UserData") as? Data{
            
            if let data = try? JSONDecoder().decode(RegisterLoginModel.RegisterLogin.self, from: loginInfo) as RegisterLoginModel.RegisterLogin {
                
                LoginViewController.loginInfo = data
                
            }
            
            self.performSegue(withIdentifier: "ValidacionHome", sender: nil)
            
        }else{
            
           self.performSegue(withIdentifier: "ValidacionWelcome", sender: nil)
            /*let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
            let svc = storyboard.instantiateViewController(withIdentifier: "ValidacionWelcome") as! UINavigationController
            svc.modalPresentationStyle = .fullScreen
            self.present(svc, animated: true)*/
            
        }
            
        
    }

}
