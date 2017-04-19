
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
    
    var nearMePubs : [PubModel] = []
    
    var selectedPub = PubModel()
    
    //let dataProvider = GoogleDataProvider()
    let searchRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage = UIImage(named: "icon_profile")
        mapView.showsUserLocation = true
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setRegionForLocation(location : CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude), spanRadius : 1609.00 * 5, animated: true)
        getNearbyPubs()
        
    }
    
    func initMapView()
    {
        mapView.removeAnnotations(mapView.annotations)
        for overlay in mapView.overlays{
            mapView.remove(overlay)
        }
        
        //mapView.remove
    }
    
    
    
    func getNearbyPubs() {
        
        ApiFunctions.getNearByPubs(latitude: currentLatitude, longitude: currentLongitude, radius: 1609.00 * 5, completion: {
            success, pubs in
            if success {
                self.nearMePubs = pubs
                self.arrangePubs()
            }
        })
    }
    
    
    func arrangePubs() {
        var index = 0
        
        for pub in nearMePubs{
            index += 1
            let info = StarbuckAnnotation(coordinate: CLLocationCoordinate2D(latitude: pub.pub_latitude, longitude: pub.pub_longitude))
            info.pub = pub
            
            info.title = pub.pub_name
            info.subtitle = pub.pub_vicinity
            //info.subtitle = friend.friend_user.user_currentLocationName
            mapView.addAnnotation(info)
        }
        
    }
    
    func setRegionForLocation(
        location:CLLocationCoordinate2D,
        spanRadius:Double,
        animated:Bool)
    {
        let span = 2.0 * spanRadius
        let region = MKCoordinateRegionMakeWithDistance(location, span, span)
        mapView.setRegion(region, animated: animated)
    }
    
}




extension MapViewController: MKMapViewDelegate{
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
    
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        
        let image = UIImage(named: "icon_pub")
        annotationView?.image = image
        return annotationView
        
    }
    
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        
        let starbucksAnnotation = view.annotation as! StarbuckAnnotation
        let pub = starbucksAnnotation.pub
        let rootVC = self.parent?.parent?.parent as! RootViewController
        rootVC.addressLabel.text = pub.pub_vicinity
        if pub.pub_opennow {
            rootVC.openTimeLabel.text = "Opened now"
        }
        else{
            rootVC.openTimeLabel.text = "Not opened now"
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
            view.layer.masksToBounds = true
        }
    }
    
    
    
}
