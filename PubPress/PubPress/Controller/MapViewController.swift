
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
    var isViewApppeared = false
    
    
    //let dataProvider = GoogleDataProvider()
    var searchRadius: Double = 1609.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage = UIImage(named: "icon_profile")
        
        mapView.showsUserLocation = true
        mapView.showsScale = true
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initMapView()
        if currentLatitude == -100{
            isViewApppeared = false
        }
        else {
            getNearbyPubs()
            setRegionForLocation(location : CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude), spanRadius : searchRadius, animated: true)
            
        }
        
    }
    
    
    func getNearbyPubs() {
        
        ApiFunctions.getNearByPubs(latitude: currentLatitude, longitude: currentLongitude, radius: searchRadius, completion: {
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
        if pub.pub_placeid != rootVC.currentPub.pub_placeid{
            rootVC.currentPub = pub
            rootVC.setPubView()
        }
        selectedPub = pub
        showDirection()
        
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
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.fillColor = UIColor.red
        polylineRenderer.lineWidth = 2
        return polylineRenderer
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        currentLatitude = userLocation.coordinate.latitude
        currentLongitude = userLocation.coordinate.longitude
        if !isViewApppeared {
            getNearbyPubs()
            isViewApppeared = true
            setRegionForLocation(location : CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude), spanRadius : searchRadius, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        /*if searchRadius !=
        searchRadius = mapView.visibleMapRect.size.width*/
        
    }
    
    
    func initMapView()
    {
        mapView.removeAnnotations(mapView.annotations)
        for overlay in mapView.overlays{
            mapView.remove(overlay)
        }
        
    }
    
    func showDirection() {
        
        //CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        for overlay in mapView.overlays{
            mapView.remove(overlay)
        }
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: selectedPub.pub_latitude, longitude: selectedPub.pub_longitude), addressDictionary: nil))
        request.requestsAlternateRoutes = false
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.add(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        
    }
    
    
    
}
