
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
	
	var status = Constants.MAP_VIEW_MAIN
    
	@IBOutlet weak var searchRadiusSlider: UISlider!
    
    //let dataProvider = GoogleDataProvider()
	@IBOutlet weak var searchRadiusLabel: UILabel!
	
	
	var latitude = -100.0
	var longitude = -100.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage = UIImage(named: "icon_profile")
        
        mapView.showsUserLocation = true
        mapView.showsScale = true
		isViewApppeared = false

		setSearchRadius()
    }
	
	func setSearchRadius() {
		searchRadiusSlider.value = Float(searchRadius / 1609.3 / Constants.MAP_VIEW_MAX_RADIUS)
		searchRadiusLabel.text = String(format: "Radius%.2lf", searchRadius / 1609.3)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    
    
    func getNearbyPubs() {
        
        ApiFunctions.getNearByPubs(latitude: latitude, longitude: longitude, radius: searchRadius, completion: {
            success, pubs in
            if success {
                self.nearMePubs = pubs
                self.arrangePubs()
            }
        })
    }
    
    
    func arrangePubs() {
		
		self.initMapView()
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
		
		self.setRegionForLocation(location: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), spanRadius: searchRadius, animated: true)
        
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
    
	@IBAction func radiusChanged(_ sender: UISlider) {
		
		searchRadius = Double(sender.value) * Constants.MAP_VIEW_MAX_RADIUS * 1609.3
		setSearchRadius()
		
		if sender.isTracking == false {
			getNearbyPubs()
		}
	}
	@IBAction func searchButtonTapped(_ sender: Any) {
		getNearbyPubs()
	}
	
	@IBAction func directionButtonTapped(_ sender: Any) {
		showDirection()
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
		/*let label = UILabel()
		label.text = (view.annotation?.title)!
		label.font = UIFont.systemFont(ofSize: 12)
		label.frame = CGRect(x: 15 - label.intrinsicContentSize.width/2, y: -15, width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
		view.addSubview(label)*/
		
		view.image = #imageLiteral(resourceName: "icon_pub_selected")
		let starbucksAnnotation = view.annotation as! StarbuckAnnotation
        let pub = starbucksAnnotation.pub
        let rootVC = self.parent?.parent?.parent as! RootViewController
        if pub.pub_placeid != rootVC.currentPub.pub_placeid{
            rootVC.currentPub = pub
            rootVC.setPubView()
        }
		
        selectedPub = pub
		
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
			view.image = #imageLiteral(resourceName: "icon_pub")
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
			self.latitude = currentLatitude
			self.longitude = currentLongitude
            getNearbyPubs()
            isViewApppeared = true
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        /*if searchRadius !=
        searchRadius = mapView.visibleMapRect.size.width*/
		if isViewApppeared {
			latitude = mapView.region.center.latitude
			longitude = mapView.region.center.longitude
		}
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
        request.transportType = .any
        
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
