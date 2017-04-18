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
    
    static func parsePub(_ rawData: JSON) -> PubModel {
    
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
            "vicinity": "Changbaishan East Road, Yanji, Yanbian"
         
         }
        */
        let pub = PubModel()
        
        pub.pub_id = rawData[Constants.KEY_PUB_ID].stringValue
        pub.pub_iconurl = rawData[Constants.KEY_PUB_ICON].stringValue
        pub.pub_placeid = rawData[Constants.KEY_PUB_PLACE_ID].stringValue
        pub.pub_vicinity = rawData[Constants.KEY_PUB_VINICITY].stringValue
        pub.pub_name = rawData[Constants.KEY_PUB_NAME].stringValue
        let geometry = rawData[Constants.KEY_PUB_GEOMETRY]
        let location = geometry[Constants.KEY_PUB_LOCATION]
        pub.pub_latitude = location[Constants.KEY_PUB_LAT].doubleValue
        pub.pub_longitude = location[Constants.KEY_PUB_LON].doubleValue
        
        return pub
        
    }
    
}
