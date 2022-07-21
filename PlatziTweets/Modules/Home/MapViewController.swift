//
//  MapViewController.swift
//  PlatziTweets
//
//  Created by Maria Fernanda Paz Rodriguez on 7/06/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: - Properties
    var posts = [ObtenerTweetsModel.DataTweet]()
    private var map: MKMapView?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
    }
        
    private func setupMap() {
        
        map = MKMapView(frame: mapContainer.bounds)
        mapContainer.addSubview(map ?? UIView())
        
        setupMarkers()
    }
    
    private func setupMarkers() {
        posts.forEach { item in
            
            if item.location?.latitude != nil && item.location?.longitude != nil {
                
                let marker = MKPointAnnotation()
                
                marker.coordinate = CLLocationCoordinate2D(latitude: item.location!.latitude!, longitude: item.location!.longitude!)
                marker.title = item.text
                marker.subtitle = item.author?.names
                
                map?.addAnnotation(marker)
                
            }
            //buscamos el ultimo post del arreglo
            guard let lastPost = posts.first else {
                return
            }
            
            if lastPost.location?.latitude != nil && lastPost.location?.longitude != nil {
                
                let lastPostLocation = CLLocationCoordinate2D(latitude: lastPost.location!.latitude!, longitude: lastPost.location!.longitude!)
                
                guard let heading = CLLocationDirection(exactly: 12) else {
                    return
                }
                
                map?.camera = MKMapCamera(lookingAtCenter: lastPostLocation, fromDistance: 30, pitch: 0, heading: heading)
            }
        }
    }
}
