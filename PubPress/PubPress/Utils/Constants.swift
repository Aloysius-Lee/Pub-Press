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
	
	
	static let CHECK_EMAIL_EMPTY            = "Please input your email!"
	static let CHECK_PASSWORD_EMPTY         = "Please input your password!"
	static let CHECK_EMAIL_INVALID          = "Please input valid email!"
	static let CHECK_NAME_EMPTY				= "Please input your name!"
	
	
	static let CHECK_NETWORK_ERROR			= "Nework error!"	
	
	static let CHECK_ENCODING_ERROR			= "Encodign error!"
	
	
	
	//error messages for check payment card
	static let CHECK_CARDNO_ERROR			= "Card number is not valid!"
	static let CHECK_COUNTRY_ERROR			= "Country is required!"
	static let CHECK_ROUTING_EMPTY			= "Routing is empty!"
	static let CHECK_DOB_ERROR				= "DOB error!"
	static let CHECK_FIRSTNAME_EMPTY		= "First name is empty!"
	static let CHECK_LASTNAME_EMPTY			= "Last name is empty!"
	static let CHECK_CITY_EMPTY				= "City is empty!"
	static let CHECK_LINE1_EMPTY			= "Line1 is empty!"
	static let CHECK_POSTALCODE_EMPTY		= "Postal code is empty!"
	static let CHECK_STATE_EMPTY			= "State is empty!"
	static let CHECK_SSNLAST4_ERROR			= "Please input valid code!"
	
	
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
	static let KEY_PUB_CONTACTEMAIL_B		= "pub_contactemail"
	static let KEY_PUB_CONTACTPASSWORD_B	= "pub_contactpassword"
	static let KEY_PUB_PRODUCTS_B			= "pub_products"
    
    //product key
    
    static let KEY_PRODUCT_NAME             = "product_name"
    static let KEY_PRODUCT_ID               = "product_id"
    static let KEY_PRODUCT_TYPE             = "product_type"
    static let KEY_PRODUCT_PRICE            = "product_price"
    
    //image key
    
    static let KEY_IMAGEURL                 = "image_url"
    //google result

    static let KEY_GOOGLE_RESULT            = "data"
    
    
    //constants for status
	
	//mapview controller status
	
	static let MAP_VIEW_MAIN				= 1
	static let MAP_VIEW_REGISTER			= 2
	
	//mapview controller max radius
	
	static let MAP_VIEW_MAX_RADIUS			= 4.0
	
	//add cardviewcontroller status 
	
	static let ADDCARD_VIEW_REGISTER		= 1
	static let ADDCARD_VIEW_MAIN			= 2
	
	
	//stripe payment keys
	
	static let RES_STATUS					= "status"
	static let RES_ACCOUNT_DATA				= "account_data"
	static let KEY_ACCOUNT_ID				= "accountid"
	
	
	//bank account keys 
	
	static let KEY_BANK_ACCOUNT_NUMBER		= "acc_number"
	static let KEY_BANK_ACCOUNT_COUNTRY		= "acc_country"
	static let KEY_BANK_ACCOUNT_ROUTING		= "acc_routing"
	static let KEY_BANK_DOB_DAY				= "dob_day"
	static let KEY_BANK_DOB_MONTH			= "dob_month"
	static let KEY_BANK_BOD_YEAR			= "dob_year"
	static let KEY_BANK_FIRST_NAME			= "first_name"
	static let KEY_BANK_LAST_NAME			= "last_name"
	static let KEY_BANK_CITY				= "city"
	static let KEY_BANK_LINE1				= "line1"
	static let KEY_BANK_POSTAL_CODE			= "postal_code"
	static let KEY_BANK_STATE				= "state"
	static let KEY_BANK_SSN_LAST4			= "ssn_last_4"
	
	//payment keys
	
	static let KEY_PAYMENT_EMAIL			= "providerEmail"
	static let KEY_PAYMENT_PRODUCTPRICE		= "productPrice"
	static let KEY_PAYMENT_STRIPE_TOKEN		= "stripeToken"
	static let KEY_PAYMENT_CUSTOMEREMAIL	= "customerEmail"
	
	
	static let VIEW_FROM_PAYMENT			= 1
	
	
	
    
    
}

var searchRadius                            = 1609.3
