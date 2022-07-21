//
//  HomeViewController.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit
import SVProgressHUD
import NotificationBannerSwift
import AVKit

class HomeViewController: UIViewController {
    //MARK IBOutlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: Properties
    private let cellId = "TweetTableViewCell"
    static var dataSource = [ObtenerTweetsModel.DataTweet]()
    static var tableView: UITableView!
    
    let ViewModel = ObtenerTweetsViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        
         HomeViewController.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        setupUI()
        HomeViewController.tableView = tableView
        do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                   }
                   catch {
                       print("Setting category to AVAudioSessionCategoryPlayback failed.")
                   }
        
    }
    
    private func setupUI(){
        //1. asignar data source
        //2. registrar la celda
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
    }
    
    private func getPosts() {
        //indicar la carga al usuario
        SVProgressHUD.show()
        
        //consumir el servicio
        ViewModel.getTweet { (TweetGuardados) in
            
            SVProgressHUD.dismiss()
            
            if TweetGuardados.indices.contains(0){
                
                HomeViewController.dataSource = TweetGuardados
                self.tableView.reloadData()
                
            }else{
                
                HomeViewController.dataSource = []
                
                
            }
        
        }
    }
    
    private func deletePostAt(indexPath: IndexPath){
        
        //1. Indicar carga al usuario
        SVProgressHUD.show()
        
        //2. ID del post que vamos a borrar
        let postId = HomeViewController.dataSource[indexPath.row].id
        
        //3. Consumir el servicio
        ViewModel.deleteTweets(postId: postId ?? "") { (DeleteTweetsInfo) in
            
            SVProgressHUD.dismiss()
            
            if DeleteTweetsInfo != nil {
                
                HomeViewController.dataSource.remove(at: indexPath.row)
                NotificationBanner(title: "Success", subtitle: "Se Borro Tu Tweet", style: .success).show()
                self.tableView.reloadData()
                
            }else{
                
                NotificationBanner(title: "Error", subtitle: "No Se Pudo Borrar El Tweet", style: .warning).show()
                
                
            }
            
        }
        
    }
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Borrar") { _, _ in
            //Aqui borramos el tweet
            self.deletePostAt(indexPath: indexPath)
        }
        return [deleteAction]
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return HomeViewController.dataSource[indexPath.row].author?.email ==  LoginViewController.loginInfo!.user!.email!
    }
    
}
//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    //numero total de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewController.dataSource.count
    }
    //confgurar celda deseada
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? TweetTableViewCell{
            //configurar la celda
            
            cell.setupCellWith(Informacion: HomeViewController.dataSource[index])
            cell.VideoButton.tag = index
            cell.VideoButton.addTarget(self, action: #selector(IrAVideo(sender:)), for: .touchUpInside)
            //cell.needsToShowVideo = { url in}*/
        }
        
        return cell
    }
    
    @objc func IrAVideo(sender: UIButton) {
        
        let index = sender.tag
        
        guard let currentVideoURL = HomeViewController.dataSource[index].videoUrl else {
            return
        }
        let avPlayer = AVPlayer(url: URL(string:currentVideoURL)!)
        
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        
        present(avPlayerController, animated: true) {
            avPlayerController.player?.play()
        }
    }
}
//MARK: - Navigation
extension HomeViewController {
    
    //este metodo se llamara cuando hagamos transiciones entre pantallas (solo con storyboard)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //1. validar que el segue sea el esperado
        
        if segue.identifier == "showMap", let mapViewController = segue.destination as? MapViewController {
            //ya sabemos que si vamos a la pantalla del mapa
            
            mapViewController.posts = HomeViewController.dataSource.filter { $0.hasLocation! }
        }
    }
}
