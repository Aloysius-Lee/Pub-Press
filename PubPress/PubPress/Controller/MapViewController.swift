
//
//  MapViewController.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var profileIamgeView: UIImageView!
    
    var userImage : UIImage!
    
    
    
    //let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage = UIImage(named: "icon_profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLatitude,
                                              longitude: currentLongitude,
                                              zoom: 14)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
        
        mapView.delegate = self
        
        //let house = userImage.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: UIImage(named: "icon_profile"))
        //markerView.tintColor = .red
        londonView = markerView
        
        let position = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        let marker = GMSMarker(position: position)
        marker.title = "My location"
        marker.iconView = markerView
        marker.tracksViewChanges = true
        marker.map = mapView
        london = marker
    }
    
    func initView() {
        
    }
    
    
    @IBAction func pickPlace(_ sender: UIButton) {
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            else {
                
            }
            
        })
    }
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        // 1
        mapView.clear()
        // 2
        
        /*dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
            for place: GooglePlace in places {
                // 3
                let marker = PlaceMarker(place: place)
                // 4
                marker.map = self.mapView
            }
        }*/
        
        ApiFunctions.getNearByPubs(latitude: currentLatitude, longitude: currentLongitude, radius: 20000, completion: {
            success, pubs in
            if success {
                for pub in pubs {
                    let marker = PlaceMarker
                }
            }
        })
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            self.londonView?.tintColor = .blue
        }, completion: {(finished) in
            // Stop tracking view changes to allow CPU to idle.
            self.london?.tracksViewChanges = false
        })
    }
}
