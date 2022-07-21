//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseStorage
import NotificationBannerSwift
import AVFoundation
import AVKit
import MobileCoreServices
import UniformTypeIdentifiers
import CoreLocation

class AddPostViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    
    //MARK: - Contantes
    let ViewModel = ObtenerTweetsViewModel()
    
    // MARK: - Properties
    private var imagePicker: UIImagePickerController?
    private var currentVideoURL: URL?
    private var locationManager: CLLocationManager?
    private var userLocation: CLLocation?
    
    // MARK: - IBAction
    @IBAction func openPreviewAction() {
        guard let currentVideoURL = currentVideoURL else {
            return
        }
        let avPlayer = AVPlayer(url: currentVideoURL)
        
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        
        present(avPlayerController, animated: true) {
            avPlayerController.player?.play()
        }
        
    }
    
    @IBAction func openCameraAction() {
        
        PromptActionSheet2(view: self, items: ["abrir camara","tomar Video"], titulo: "seleccione", subtitle: "") { result in
            
            if result == 1 {
                
                self.openCamera()
                
            }else if result == 2 {
                
                self.openVideoCamera()
                
            }
            
        }
        
    }
    
    
    fileprivate func savePost(UrlImage: String?, videoUrl: String?) {
        
        ViewModel.postTweet(parameters: PostTweetStrutc.init(text: postTextView.text, imageUrl: UrlImage, videoUrl: videoUrl, latitude: userLocation?.coordinate.latitude, longitude: userLocation?.coordinate.longitude)) { (PostInformacion) in
            
            if PostInformacion != nil{
            
            if !PostInformacion!.errores!.isEmpty  {
                
                NotificationBanner(title: "Error", subtitle:PostInformacion!.errores!, style: .warning).show()
                return
                
            }
            
            HomeViewController.dataSource.insert((PostInformacion!), at: 0)
            HomeViewController().viewWillAppear(true)
            self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    @IBAction func addPostAction(){
        
        
        if videoButton.isHidden == false {
            
            uploadVideoToFirebase()
            
            return
        }
        
        if previewImageView.isHidden == false {
            
            uploadPhotoToFirebase()
            
            return
        }
        
        savePost(UrlImage: nil, videoUrl: nil)
        
        
    }
    
    @IBAction func dismissAction(){
        dismiss(animated: true, completion: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoButton.isHidden = true
        requestLocation()
        
    }
    
    //MARK: - Funciones
    
    private func requestLocation() {
        //validamos que el usuario tenga el gps activo y disponible
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
    }
    
    private func openVideoCamera() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.mediaTypes = ["public.movie"]
        imagePicker?.cameraFlashMode = .off
        imagePicker?.cameraCaptureMode = .video
        imagePicker?.videoQuality = .typeMedium
        imagePicker?.videoMaximumDuration = TimeInterval(5)
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker = imagePicker else {
            return
        }
        
        present(imagePicker, animated: true, completion: nil )
    }
    
    private func openCamera() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.cameraFlashMode = .off
        imagePicker?.cameraCaptureMode = .photo
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker = imagePicker else {
            return
        }
        
        present(imagePicker, animated: true, completion: nil )
    }
    
    private func uploadPhotoToFirebase()  {
        //1. asegurarnos de que la foto exista
        guard
            let imageSaved = previewImageView.image,
            //2. Comprimir la imagen y convertirla en data
            let imageSavedData: Data = imageSaved.jpegData(compressionQuality: 0.1) else {
            
            return
            
        }
        SVProgressHUD.show()
        //3. configurar la foto para guardarla en firebase
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"
        
        //4. referencia al storage de firebase
        let storage = Storage.storage()
        
        //5. Crear nombre de la imagen a subir
        let imageName = Int.random(in: 100...1000)
        
        //6. referencia a la carpeta donde se va a guardar la foto
        let folderReference = storage.reference(withPath: "fotos-tweets/\(imageName).jpg")
        
        //7. subir la foto a firebase
        DispatchQueue.global(qos: .background).async {
            folderReference.putData(imageSavedData, metadata: metaDataConfig) { (metaData: StorageMetadata?, error: Error?) in
                DispatchQueue.main.async{
                    //detener la carga
                    SVProgressHUD.dismiss()
                    if let error = error {NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .warning).show()
                        
                        return
                    }
                    
                    //obtener la URL de descarga
                    folderReference.downloadURL { (url: URL?,error: Error?) in
                        //self.UrlDataImage = url?.absoluteString
                        self.savePost(UrlImage: url?.absoluteString, videoUrl: nil)
                    }
                }
            }
        }
    }
    
    private func uploadVideoToFirebase()  {
        //1. asegurarnos de que el video exista
        guard
            let currentVideoSavedURL = currentVideoURL,
            //2. convertirla en data el video
            let videoData: Data = try? Data(contentsOf: currentVideoSavedURL) else {
            
            return
            
        }
        SVProgressHUD.show()
        //3. configurar el video para guardarla en firebase
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "video/MP4"
        
        //4. referencia al storage de firebase
        let storage = Storage.storage()
        
        //5. Crear nombre de el video a subir
        let videoName = Int.random(in: 100...1000)
        
        //6. referencia a la carpeta donde se va a guardar el video
        let folderReference = storage.reference(withPath: "fvideo-tweets/\(videoName).mp4")
        
        //7. subir el video a firebase
        DispatchQueue.global(qos: .background).async {
            folderReference.putData(videoData , metadata: metaDataConfig) { (metaData: StorageMetadata?, error: Error?) in
                DispatchQueue.main.async{
                    //detener la carga
                    SVProgressHUD.dismiss()
                    if let error = error {NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .warning).show()
                        
                        return
                    }
                    
                    //obtener la URL de descarga
                    folderReference.downloadURL { (url: URL?,error: Error?) in
                        //self.UrlDataImage = url?.absoluteString
                        self.savePost(UrlImage: nil, videoUrl: url?.absoluteString)
                    }
                }
            }
        }
    }
    
}

//MARK: - UIImagePickerControllerDelegate
extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info.keys.contains(.originalImage) {
            
            //Cerrar Cámara
            imagePicker?.dismiss(animated: true )
            previewImageView.isHidden = false
            videoButton.isHidden = true
            
            // Obtenemos la imagen tomada
            previewImageView.image = info[.originalImage] as? UIImage
        }
        //Aqui capturamos la URL del video
        
        if info.keys.contains(.mediaURL), let recordedVideoUrl = (info[.mediaURL] as? URL)?.absoluteURL{
            previewImageView.isHidden = true
            videoButton.isHidden = false
            currentVideoURL = recordedVideoUrl
            imagePicker?.dismiss(animated: true )
        }
    }
}
 //MARK: - CLLocationManagerDelegate
extension AddPostViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let bestLocation = locations.last else {
            return
        }
        
        //ya tenemos la ubicacion del usuario 🥸
        userLocation = bestLocation
    }
}
