
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
	@IBOutlet weak var searchRadiusLabel: UILabel!
	
	@IBOutlet weak var pubNameLabel: UILabel!
	
	var latitude = -100.0
	var longitude = -100.0
    
	@IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
		
        super.viewDidLoad()
        userImage = UIImage(named: "icon_profile")
        mapView.showsUserLocation = true
		isViewApppeared = false
		mapView.mapType = .standard
		mapView.showsTraffic = true
		mapView.showsBuildings = true
		mapView.showsCompass = true

		if status == Constants.MAP_VIEW_MAIN {
			backButton.isHidden = true
			pubNameLabel.isHidden = true
		}
		else {
			backButton.isHidden = false
			pubNameLabel.isHidden = false
		}
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
		if latitude != -100 {
			
			if sender.isTracking == false {
				getNearbyPubs()
			}
		}
	}
	@IBAction func searchButtonTapped(_ sender: Any) {
		if latitude != -100 {
			getNearbyPubs()
		}
	}
	
	@IBAction func directionButtonTapped(_ sender: Any) {
		showDirection()
	}
	
	@IBAction func backButtonTapped(_ sender: Any) {
		let registerVC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] as! AddPubViewController
		let previousPub = registerVC.pub
		selectedPub.pub_contactemail = previousPub!.pub_contactemail
		selectedPub.pub_contactpassword = previousPub!.pub_contactpassword
		registerVC.pub = selectedPub
		self.navigationController?.popViewController(animated: true)
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
		
		
		view.image = #imageLiteral(resourceName: "icon_pub_selected")
		let starbucksAnnotation = view.annotation as! StarbuckAnnotation
        let pub = starbucksAnnotation.pub
		if status == Constants.MAP_VIEW_MAIN {
			let rootVC = self.parent?.parent?.parent as! RootViewController
			if pub.pub_placeid != rootVC.selectedPub.pub_placeid{
				rootVC.selectedPub = pub
				rootVC.setPubView()
			}
		}
		else if status == Constants.MAP_VIEW_REGISTER {
			self.showLoadingView()
			ApiFunctions.getPlaceDetails(pub.pub_placeid, completion: {
				success, detailedPub in
				self.hideLoadingView()
				if success {
					self.selectedPub = detailedPub!
				}
			})
			pubNameLabel.text = pub.pub_name
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
		if selectedPub.pub_name.characters.count > 0 {
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
	
	
    
    
    
}
