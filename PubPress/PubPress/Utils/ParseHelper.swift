//
//  ParseHelper.swift
//  PubPress
//
//  Created by Zhuxian on 4/17/17.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseHelper {
    
    static func parseGooglePub(_ rawData: JSON) -> PubModel {
    
        //Pub result json
        /*
         
         {
            "geometry": {
                "location": {
                    "lat": 42.8970006,
                    "lng": 129.5503531
                },
                "viewport": {
                    "northeast": {
                        "lat": 42.8983047802915,
                        "lng": 129.5517071802915
                    },
                    "southwest": {
                        "lat": 42.8956068197085,
                        "lng": 129.5490092197085
                    }
                }
            },
            "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
            "id": "beb343b4ad1f4d33742d883e253a687906a7edec",
            "name": "Yanji Xiu'ai Food Limited Company",
            "place_id": "ChIJRzuxhta1Sl4RVwYf97OuwxU",
            "reference": "CmRRAAAACE_sprmBnq_Tbx-WCp0oRT3oZZRgpTRZnttp96TiIpd-vhicZi0_63xvWzLCwKu7ULpQK912orFAxc8tySo1j4FERMGfjkkralVpQF6JEHXiNpNc0CGdAD1QRi507aBTEhAFmh-cRPoF2zDZZIEHObIFGhRJJoSarD_8Wu-emb_gmf3azb1SzA",
            "scope": "GOOGLE",
            "types": [
            "point_of_interest",
            "establishment"
            ],
         "vicinity": "Changbaishan East Road, Yanji, Yanbian",
         "opening_hours" : {
         "open_now" : true,
         "weekday_text" : []
         }
         
         }
        */
        
        let pub = PubModel()        
        pub.pub_id = rawData[Constants.KEY_PUB_ID].nonNullStringValue
        pub.pub_iconurl = rawData[Constants.KEY_PUB_ICON].nonNullStringValue
        pub.pub_placeid = rawData[Constants.KEY_PUB_PLACE_ID].nonNullStringValue
        pub.pub_vicinity = rawData[Constants.KEY_PUB_VINICITY].nonNullStringValue
        pub.pub_name = rawData[Constants.KEY_PUB_NAME].nonNullStringValue
        let geometry = rawData[Constants.KEY_PUB_GEOMETRY]
        let location = geometry[Constants.KEY_PUB_LOCATION]
        pub.pub_latitude = location[Constants.KEY_PUB_LAT].nonNullDoubleValue
        pub.pub_longitude = location[Constants.KEY_PUB_LON].nonNullDoubleValue
        let openingHours = rawData[Constants.KEY_PUB_OPENINGHOURS]
        pub.pub_opennow = openingHours[Constants.KEY_PUB_OPENNOW].nonNullBoolValue        
        let weekdayTextArray = openingHours[Constants.KEY_PUB_WEEKDAY_TEXT].arrayValue
        for weekdayObject in weekdayTextArray {
            pub.pub_openhours.append(weekdayObject.nonNullStringValue)
        }
        let photoObject = rawData[Constants.KEY_PUB_PHOTOS].arrayValue
        if photoObject.count > 0{
            pub.photo_reference = photoObject[0][Constants.KEY_PUB_PHOTOREFERENCE].nonNullStringValue
        }
        
        
        return pub
        
    }
    
}
