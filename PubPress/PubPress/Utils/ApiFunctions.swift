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


class ApiFunctions{
    
    static let SERVER_URL                  = "http://35.164.51.96/index.php/Api/"
    static let REQ_GETNEARBYPUBS           = SERVER_URL + "getNearByPubs"
    
    static func getNearByPubs(latitude: Double, longitude: Double, radius: Double,  completion: @escaping (Bool, [PubModel]) -> ()) {
        let params = ["latitude": latitude,
                      "longitude": longitude,
                      "radius": radius]
        
        Alamofire.request(REQ_GETNEARBYPUBS, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                var pubsArray : [PubModel] = []
                let pubsJSON = json[Constants.KEY_GOOGLE_RESULT].arrayValue
                for pubJSON in pubsJSON {
                    pubsArray.append(ParseHelper.parsePub(pubJSON))
                }
                completion(true, pubsArray)
                
            }
            else {
                completion(false, [])
            }
        }
 
    }
}
