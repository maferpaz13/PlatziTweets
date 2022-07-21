//
//  ViewController.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/25/22.
//  Copyright © 2022 christians bonilla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

}
func PromptActionSheet2(view:UIViewController, items:[String], titulo:String, subtitle: String,completion: @escaping (_ result: Int)->()) {
    
    var miAux:[(id:Int, texto:String)] = []
    
    var aux = 1
    
    for i in items {
        
        miAux.append((id:aux, texto:i))
        aux = aux + 1
        
    }
    
    DispatchQueue.main.async(execute: {
        
        let miActionSheet = UIAlertController(title: titulo, message: subtitle, preferredStyle: UIAlertController.Style.actionSheet)
        
        for i in miAux {
            
            let nuevoItem = UIAlertAction(title: i.texto, style: UIAlertAction.Style.default, handler: {
                
                void in
                completion(i.id)
                
            })
            
            miActionSheet.addAction(nuevoItem)
            
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: {
            
            void in
            completion(0)
            
        })
        
        miActionSheet.addAction(cancelar)
        view.present(miActionSheet, animated: true, completion: nil)
        
    })
    
}
