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
    //static let SERVER_URL                  = "http://192.168.1.120:1300/Pub_Press/index.php/Api/"
    
    
    static let REQ_GETNEARBYPUBS            = SERVER_URL + "getNearByPubs"
    static let REQ_GOOGLESEARCH             = SERVER_URL + "getGoogleSearch"
    static let REQ_GETPLACEDETAILS          = SERVER_URL + "getPlaceDetails"
    static let REQ_GETGOOGLEPHOTOES         = SERVER_URL + "getGooglePhotoes"
    static let REQ_GETDIRECTION             = SERVER_URL + "getDirection"
    static let REQ_REGISTERPUB              = SERVER_URL + "registerPub"
    static let REQ_REGISTERUSER             = SERVER_URL + "registerUser"
    static let REQ_UPLOADIMAGE              = SERVER_URL + "uploadImage"
    static let REQ_REGISTERPRODUCT          = SERVER_URL + "registerProduct"
    
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
    
    
    static func registerPub(_ pub: PubModel, completion: @escaping (String, PubModel) -> ()) {
        let params = [Constants.KEY_PUB_NAME_B: pub.pub_name,
                      Constants.KEY_PUB_LATITUDE_B: pub.pub_latitude,
                      Constants.KEY_PUB_LONGITUDE_B: pub.pub_longitude,
                      Constants.KEY_PUB_PLACEID_B: pub.pub_placeid,
                      Constants.KEY_PUB_VINICITY_B: pub.pub_vicinity,
                      Constants.KEY_PUB_OPENHOURS_B: pub.getOpenhourString(),
                      Constants.KEY_PUB_IMAGEURL_B: pub.pub_imageurl
            
        ] as [String: Any]
        Alamofire.request(REQ_REGISTERPUB, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                
                let message = json[Constants.RES_MESSAGE].stringValue
                if message == Constants.PROCESS_SUCCESS {
                    pub.pub_id = json[Constants.KEY_PUB_ID_B].stringValue
                }
                
                completion(message, pub)
                
                
            }
            else {
                completion(Constants.CHECK_NETWORK_ERROR, pub)
            }
        }
    }
    
    static func registerProduct(pubid: String, product: ProductModel,completion: @escaping (String, ProductModel) -> ()) {
        
        let params = [ Constants.KEY_PRODUCT_NAME: product.product_name,
                       Constants.KEY_PRODUCT_PRICE: product.product_price
        ]
        Alamofire.request(REQ_REGISTERPRODUCT, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                
                let message = json[Constants.RES_MESSAGE].stringValue
                if message == Constants.PROCESS_SUCCESS {
                    product.product_id = json[Constants.KEY_PRODUCT_ID].stringValue
                }
                
                completion(message, product)
                
                
            }
            else {
                completion(Constants.CHECK_NETWORK_ERROR, product)
            }
        }
        
    }
    
    static func uploadImage(imageData: Data, completion: @escaping (String, String) -> () ) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "test.jpg", mimeType: "image/jpg")                //multipartFormData.boundary
        },
            to: REQ_UPLOADIMAGE,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        NSLog("\(String(describing: response.result.value))")
                        switch response.result {
                            
                        case .success(let result):
                            let json = JSON(response.result.value!)
                            NSLog("\(result)")
                            let message = json[Constants.RES_MESSAGE].stringValue
                            if message == Constants.PROCESS_SUCCESS {
                                let imageurl = json[Constants.KEY_IMAGEURL].stringValue
                                completion(message, imageurl)
                            }
                            else {
                                completion(message, "")
                            }
                            
                        case .failure(_):
                            
                            completion(Constants.CHECK_NETWORK_ERROR, "")
                            
                        }
                    }
                    
                case .failure(let encodingError):
                    NSLog("\(encodingError)")
                    completion(Constants.CHECK_ENCODING_ERROR, "")
                }
        })
    }
    
    static func registerUser(_ user: UserModel , completion: @escaping (String, UserModel) -> ()) {
        
        let params = [Constants.KEY_USER_NAME: user.user_name,
                      Constants.KEY_USER_EMAIL: user.user_email,
                      Constants.KEY_USER_PASSWORD: user.user_password,
                      Constants.KEY_USER_PROFILEIMAGEURL: user.user_profileimageurl
            ] as [String: Any]
        Alamofire.request(REQ_REGISTERPUB, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                
                let message = json[Constants.RES_MESSAGE].stringValue
                if message == Constants.PROCESS_SUCCESS {
                    user.user_id = json[Constants.KEY_USER_ID].stringValue
                }
                
                completion(message, user)
                
                
            }
            else {
                completion(Constants.CHECK_NETWORK_ERROR, user)
            }
        }
    }
    

    
}
