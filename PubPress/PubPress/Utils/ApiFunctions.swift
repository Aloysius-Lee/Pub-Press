//
//  ApiFuntions.swift
//  PubPress
//
//  Created by Zhuxian on 4/17/17.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation


class ApiFunctions{
    
    static let SERVER_URL                  = "http://35.164.51.96/index.php/Api/"
    
    
    static let REQ_GETNEARBYPUBS            = SERVER_URL + "getNearByPubs"
    static let REQ_GOOGLESEARCH             = SERVER_URL + "getGoogleSearch"
    static let REQ_GETPLACEDETAILS          = SERVER_URL + "getPlaceDetails"
    static let REQ_GETGOOGLEPHOTOES         = SERVER_URL + "getGooglePhotoes"
    static let REQ_GETDIRECTION             = SERVER_URL + "getDirection"
    
    static func getNearByPubs(latitude: Double, longitude: Double, radius: Double,  completion: @escaping (Bool, [PubModel]) -> ()) {
        
        googleSearch(latitude: latitude, longitude: longitude, radius: radius, completion: {
            success, pubs in
            completion(success, pubs)
        })
 
    }
    
    
    static func googleSearch(latitude: Double, longitude: Double, radius: Double,  completion: @escaping (Bool, [PubModel]) -> ()) {
        let params = ["latitude": latitude,
                      "longitude": longitude,
                      "radius": radius] as [String : Any]
        
        Alamofire.request(REQ_GETNEARBYPUBS, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                var locations : [PubModel] = []
                let locationsJSON = json[Constants.KEY_GOOGLE_RESULT].arrayValue
                for locationJSON in locationsJSON {
                    locations.append(ParseHelper.parseGooglePub(locationJSON))
                }
                completion(true, locations)
                
            }
            else {
                completion(false, [])
            }
        }
    }
    
    static func getPlaceDetails(_ placeid: String,  completion: @escaping (Bool, PubModel?) -> ()) {
        let params = ["placeid": placeid]
        
        Alamofire.request(REQ_GETPLACEDETAILS, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                let locationJSON = json[Constants.KEY_GOOGLE_RESULT]["result"]
                completion(true, ParseHelper.parseGooglePub(locationJSON))
                
            }
            else {
                completion(false, nil)
            }
        }
    }
    
    
    static func getGooglePhotoes(_ photo_reference: String,  completion: @escaping (Bool, Data?) -> ()) {
        let params = ["photo_reference": photo_reference]
        
        Alamofire.request(REQ_GETGOOGLEPHOTOES, method: .post, parameters: params).responseData { response in
            if response.result.isSuccess
            {
                completion(true, response.result.value)
                
            }
            else {
                completion(false, nil)
            }
        }
    }
    /*
    static func getDirection(origin: CLLocationCoordinate2D, to: CLLocationCoordinate2D, completion: @escaping (Bool) -> ()) {
        let params = ["originlat": origin.latitude,
                      "originlng": origin.longitude,
                      "destinationlat": to.latitude,
                      "destinationlng": to.longitude,
                      ]
        
        Alamofire.request(REQ_GETGOOGLEPHOTOES, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                completion(true)
                
            }
            else {
                completion(false)
            }
        }
    }*/
    
    
    static func registerPub() {
        
    }
}
