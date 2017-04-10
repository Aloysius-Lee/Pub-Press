
//
//  MapViewController.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import GoogleMaps
import SDWebImage

class MapViewController: BaseViewController , GMSMapViewDelegate{

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var profileIamgeView: UIImageView!
    
    var london: GMSMarker?
    var londonView: UIImageView?
    
    var userImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage = UIImage(named: "icon_profile")
        
        /*
        let returnedPlaces: NSArray? = jsonResult["results"] as? NSArray
        
        if returnedPlaces != nil {
            
            for index in 0..<returnedPlaces!.count {
                
                if let returnedPlace = returnedPlaces?[index] as? NSDictionary {
                    
                    var placeName = ""
                    var latitude = 0.0
                    var longitude = 0.0
                    
                    if let name = returnedPlace["name"] as? NSString {
                        placeName = name as String
                    }
                    
                    if let geometry = returnedPlace["geometry"] as? NSDictionary {
                        if let location = geometry["location"] as? NSDictionary {
                            if let lat = location["lat"] as? Double {
                                latitude = lat
                            }
                            
                            if let lng = location["lng"] as? Double {
                                longitude = lng
                            }
                        }
                    }
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(latitude, longitude)
                    marker.title = placeName
                    marker.map = self.mapView
                }
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            self.londonView?.tintColor = .blue
        }, completion: {(finished) in
            // Stop tracking view changes to allow CPU to idle.
            self.london?.tracksViewChanges = false
        })
    }
}
