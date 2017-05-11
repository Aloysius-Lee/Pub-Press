//
//  Constants.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    //google map key
    
    //static let GOOGLEMAPKEY                 = "AIzaSyBJILF4L98DGEXplgLHP1pIdQrdbQ08skI"
    //error messages 
    
    static let CHECK_EMAIL_EMPTY            = "Please input your email"
    static let CHECK_PASSWORD_EMPTY         = "Please input your password"
    static let CHECK_EMAIL_INVALID          = "Please input valid email"
    static let CHECK_NETWORK_ERROR          = "Network error!"
    static let CHECK_ENCODING_ERROR         = "Encoding error!"
    static let CHECK_NAME_EMPTY             = "Please input your name"
    
    
    //PROCESS VALUES
    
    static let PROCESS_SUCCESS              = "success"
    static let PROCESS_FAIL                 = "fail"
    
    static let RES_MESSAGE                  = "message"
    
    static let KEY_EMAIL                    = "email"
    static let KEY_PASSWORD                 = "password"
    
    //static let PROCESS_
    
    //user model
    
    static let KEY_USER_INFO                = "userInfo"
    
    static let KEY_USER_ID                  = "user_id"
    static let KEY_USER_NAME                = "user_name"
    static let KEY_USER_EMAIL               = "user_email"
    static let KEY_USER_PASSWORD            = "user_password"
    static let KEY_USER_PROFILEIMAGEURL     = "user_profileimageurl"
    static let KEY_USER_DECARDENCE          = "user_decadence"
    static let KEY_USER_TIER                = "user_tier"
    static let KEY_USER_NETPINTS            = "user_netpints"
    static let KEY_USER_CREDITS             = "user_credits"
    
    //pub model keys
    
    static let KEY_PUB_ID                   = "id"
    static let KEY_PUB_GEOMETRY             = "geometry"
    static let KEY_PUB_LOCATION             = "location"
    static let KEY_PUB_LAT                  = "lat"
    static let KEY_PUB_LON                  = "lng"
    static let KEY_PUB_ICON                 = "icon"
    static let KEY_PUB_NAME                 = "name"
    static let KEY_PUB_VINICITY             = "vicinity"
    static let KEY_PUB_PLACE_ID             = "place_id"
    static let KEY_PUB_OPENINGHOURS         = "opening_hours"
    static let KEY_PUB_OPENNOW              = "open_now"
    static let KEY_PUB_PHOTOS               = "photos"
    static let KEY_PUB_PHOTOREFERENCE       = "photo_reference"
    static let KEY_PUB_WEEKDAY_TEXT         = "weekday_text"
    static let KEY_PUB_PHONENUMBER          = "formatted_phone_number"
    static let KEY_PUB_ADDRESS              = "formatted_address"
    
    
    //pub model keys from backend
    static let KEY_PUB_INFO                 = "pubInfo"
    
    static let KEY_PUB_ID_B                 = "pub_id"
    static let KEY_PUB_NAME_B               = "pub_name"
    static let KEY_PUB_LATITUDE_B           = "pub_latitude"
    static let KEY_PUB_LONGITUDE_B          = "pub_longitude"
    static let KEY_PUB_PLACEID_B            = "pub_placeid"
    static let KEY_PUB_VINICITY_B           = "pub_vicinity"
    static let KEY_PUB_OPENHOURS_B          = "pub_openhours"
    static let KEY_PUB_IMAGEURL_B           = "pub_imageurl"
    
    //product key
    
    static let KEY_PRODUCT_NAME             = "product_name"
    static let KEY_PRODUCT_ID               = "product_id"
    static let KEY_PRODUCT_TYPE             = "product_type"
    static let KEY_PRODUCT_PRICE            = "product_price"
    
    //image key
    
    static let KEY_IMAGEURL                 = "image_url"
    //google result

    static let KEY_GOOGLE_RESULT            = "data"
    
    
    
    
    
}

var searchRadius                            = 1609.3
