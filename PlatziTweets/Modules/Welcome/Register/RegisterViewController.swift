//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SVProgressHUD

class RegisterViewController: UIViewController {
    // MARK - Outlets
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var namesTextField: UITextField!
    
    
    //MARK: - IBActions
    @IBAction func RegisterButtonAction() {
        self.view.endEditing(true)
        performRegister()
    }
    
    //MARK: Constantes
    
    let ViewModel = RegisterViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        registerButton.layer.cornerRadius = 25
    }
    
    private func performRegister() {
        guard let email = emailTextField.text, !email.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes Especificar Tu Correo", style: .warning).show()
            
            return
        }
    
        guard let password = passwordTextField.text, !password.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes Especificar Tu Contraseña", style: .warning).show()
    
            return
        }
        
        guard let names = namesTextField.text, !names.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes Especificar Tu Nombre y Apellido", style: .warning).show()
    
            return
            }
        SVProgressHUD.show()
        
        ViewModel.postRegister(parameters: PostRegister.init(email: emailTextField.text!, password: passwordTextField.text!, names: namesTextField.text!)) { (RegisInfo) in
            
            SVProgressHUD.dismiss()
            
            print("RegisInfo data \(RegisInfo)")
            
            if RegisInfo != nil {
                
                
                NotificationBanner(title: "Success", subtitle: "Su Registro Ha Sido Exitoso", style: .success).show()
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    
                    self.performSegue(withIdentifier: "showHome", sender: nil)
                    
                }
                
            }else{
                
                NotificationBanner(title: "MEEEEJJJ", subtitle: "No se pudo registrar", style: .danger).show()
                
            }
            
        }
        
        //Registrarnos aquí
    }

}
