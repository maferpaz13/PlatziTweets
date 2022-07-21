//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SVProgressHUD

class LoginViewController: UIViewController {
    // MARK - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    static var loginInfo: RegisterLoginModel.RegisterLogin? = nil
    
    //MARK: - IBActions
    @IBAction func loginButtonAction() {
        self.view.endEditing(true)
        performLogin()
    }
    
    //MARK: - Constantes
    let ViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    //MARK: - private func
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
    }
    private func performLogin() {
        
        guard let email = emailTextField.text, !email.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes Especificar Tu Correo", style: .warning).show()
            return
        }
    
        guard let password = passwordTextField.text, !password.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes Especificar Tu Contraseña", style: .warning).show()
            return
        }
        
        SVProgressHUD.show()
        
        ViewModel.postLogin(parameters: PostLoginStrutc.init(email: emailTextField.text!, password: passwordTextField.text!)) { (LoginData,losamigosdebarnie)  in
            
            SVProgressHUD.dismiss()
            
            if LoginData != nil {

                LoginViewController.loginInfo = LoginData
                let defaults = UserDefaults.standard
                defaults.set(losamigosdebarnie, forKey: "UserData")
                self.performSegue(withIdentifier: "showHome", sender: nil)
                
            } else {
                
                NotificationBanner(title: "Error", subtitle: "No Se Pudo Iniciar Sesión", style: .warning).show()
                
            }
            
        }
        
    }

}
