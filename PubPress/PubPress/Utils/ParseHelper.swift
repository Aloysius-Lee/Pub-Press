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
		
        let pub = PubModel()
        pub.pub_id = rawData[Constants.KEY_PUB_ID].nonNullStringValue
        //pub.pub_iconurl = r  awData[Constants.KEY_PUB_ICON].nonNullStringValue
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
        pub.pub_formatted_phone_number = rawData[Constants.KEY_PUB_PHONENUMBER].nonNullStringValue
        pub.pub_formatted_address = rawData[Constants.KEY_PUB_ADDRESS].nonNullStringValue
        
        
        return pub
        
    }
    
    static func parsePub(_ rawData: JSON) -> PubModel{
        let pub = PubModel()
        pub.pub_id = rawData[Constants.KEY_PUB_ID_B].stringValue
		pub.pub_latitude = Double(rawData[Constants.KEY_PUB_LATITUDE_B].stringValue)!
		pub.pub_vicinity = rawData[Constants.KEY_PUB_VINICITY_B].stringValue
		pub.pub_placeid = rawData[Constants.KEY_PUB_PLACEID_B].stringValue
		pub.pub_name = rawData[Constants.KEY_PUB_NAME_B].stringValue
		pub.pub_contactemail = rawData[Constants.KEY_PUB_CONTACTEMAIL_B].stringValue
		pub.pub_contactpassword = rawData[Constants.KEY_PUB_CONTACTPASSWORD_B].stringValue
		
        return pub
    }
    
    static func parseUser(_ rawData: JSON) -> UserModel{
        
        let user = UserModel()
        user.user_id = rawData[Constants.KEY_USER_ID].nonNullStringValue
        user.user_name = rawData[Constants.KEY_USER_NAME].nonNullStringValue
        user.user_profileimageurl = rawData[Constants.KEY_USER_PROFILEIMAGEURL].nonNullStringValue
        user.user_decadence = rawData[Constants.KEY_USER_DECARDENCE].nonNullStringValue
        user.user_tier = rawData[Constants.KEY_USER_TIER].nonNullStringValue
        user.user_netpints = rawData[Constants.KEY_USER_NETPINTS].nonNullStringValue
        user.user_credits = rawData[Constants.KEY_USER_CREDITS].nonNullStringValue
		user.user_email = rawData[Constants.KEY_USER_EMAIL].nonNullStringValue
		
		return user
    }
	
	static func parseProduct(_ rawData: JSON) -> ProductModel{
		let product = ProductModel()
		product.product_id = rawData[Constants.KEY_PRODUCT_ID].stringValue
		product.product_name = rawData[Constants.KEY_PRODUCT_NAME].stringValue
		product.product_price = rawData[Constants.KEY_PRODUCT_PRICE].stringValue
		return product
	}
	
    
}
