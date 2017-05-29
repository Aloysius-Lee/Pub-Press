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
    
    static let SERVER_URL                  = "http://34.209.33.44/index.php/Api/"
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
    static let REQ_LOGIN                    = SERVER_URL + "login"
	static let REQ_CHECKEMAILVALID			= SERVER_URL + "checkEmailValid"
	
	//stripe request (backend)
	
	static let STRIPE_URL = "http://34.209.33.44/index.php/Stripe/act/"
	static let REQ_CREATE_STRIPEACCOUNT		= STRIPE_URL + "account_create"
	
	static let REQ_UPDATE_STRIPEACCOUNT		= STRIPE_URL + "account_update_required"
	static let REQ_ACCOUNT_DETAILS			= STRIPE_URL + "account_details"
	static let REQ_PRODUCT_BUY				= STRIPE_URL + "product_buy"
	
	
    
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
				let pub = ParseHelper.parseGooglePub(locationJSON)
				let backendObject = json["pub"]
				pub.pub_contactemail = backendObject["pub"][Constants.KEY_PUB_CONTACTEMAIL_B].stringValue
				let productObject = backendObject["cheap_product"]
				let product = ParseHelper.parseProduct(productObject)
				pub.pub_cheap_product = product
                completion(true, pub)
                
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
                      Constants.KEY_PUB_IMAGEURL_B: pub.pub_imageurl,
                      Constants.KEY_PUB_CONTACTEMAIL_B: pub.pub_contactemail,
                      Constants.KEY_PUB_CONTACTPASSWORD_B: pub.pub_contactpassword
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
                       Constants.KEY_PRODUCT_PRICE: product.product_price,
                       Constants.KEY_PUB_ID_B: pubid
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
        Alamofire.request(REQ_REGISTERUSER, method: .post, parameters: params).responseJSON { response in
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
    
    static func login(email: String, password: String, completion: @escaping (String, AnyObject) -> ()) {
        let params = [
                      Constants.KEY_EMAIL: email,
                      Constants.KEY_PASSWORD: password
            ]
        Alamofire.request(REQ_LOGIN, method: .post, parameters: params).responseJSON { response in
            if response.result.isSuccess
            {
                let json = JSON(response.result.value!)
                
                let message = json[Constants.RES_MESSAGE].stringValue
                if message == Constants.PROCESS_SUCCESS {
                    if json[Constants.KEY_USER_INFO].array != nil {
                        let userObject = json[Constants.KEY_USER_INFO].arrayValue
                        completion(Constants.PROCESS_SUCCESS, ParseHelper.parseUser(userObject[0]) as AnyObject)
                    }
                    else {
                        let pubObject = json[Constants.KEY_PUB_INFO]
						let pub = ParseHelper.parsePub(pubObject)
						
						let productsObject = json[Constants.KEY_PUB_PRODUCTS_B].arrayValue
						for productObject in productsObject {
							pub.pub_products.append(ParseHelper.parseProduct(productObject))
						}
                        completion(Constants.PROCESS_SUCCESS, pub as AnyObject)
                    }
                }
                else {
                    completion(message, "" as AnyObject)
                }
                
                
            }
            else {
                completion(Constants.CHECK_NETWORK_ERROR, "" as AnyObject)
            }
        }
    }
	
	static func checkEmailValid(_ email: String, completion: @escaping (String) -> ()) {
		let params = [
			Constants.KEY_EMAIL: email
		]
		Alamofire.request(REQ_CHECKEMAILVALID, method: .post, parameters: params).responseJSON { response in
			if response.result.isSuccess
			{
				let json = JSON(response.result.value!)
				
				let message = json[Constants.RES_MESSAGE].stringValue
				completion(message)
				
			}
			else {
				completion(Constants.CHECK_NETWORK_ERROR)
			}
		}
	}
	
	//MARK - stripe payment backend
	
	static func accountCreate(_ pub: PubModel, completion: @escaping (String) -> ()) {
		let params = [
			Constants.KEY_EMAIL: pub.pub_contactemail
		]
		Alamofire.request(REQ_CREATE_STRIPEACCOUNT, method: .post, parameters: params).responseJSON { response in
			if response.result.isSuccess
			{
				let json = JSON(response.result.value!)
				let success = json[Constants.RES_STATUS].stringValue
				if success == Constants.PROCESS_SUCCESS {
					pub.pub_bankaccount.account_status = json[Constants.RES_ACCOUNT_DATA][Constants.RES_STATUS].stringValue
					completion(Constants.PROCESS_SUCCESS)
				}
				else  {
					
					completion(success)
				}
				
			}
			else {
				completion(Constants.CHECK_NETWORK_ERROR)
			}
		}
	}
	
	static func accountUpdate(_ pub: PubModel, completion: @escaping (String) -> ()) {
		let bank = pub.pub_bankaccount
		let params = [
			Constants.KEY_EMAIL: pub.pub_contactemail,
			Constants.KEY_BANK_ACCOUNT_NUMBER : bank.acc_number,
			Constants.KEY_BANK_ACCOUNT_COUNTRY : bank.acc_country,
			Constants.KEY_BANK_ACCOUNT_ROUTING : bank.acc_routing,
			Constants.KEY_BANK_BOD_YEAR: bank.dob_year,
			Constants.KEY_BANK_DOB_MONTH : bank.dob_month,
			Constants.KEY_BANK_DOB_DAY : bank.dob_day,
			Constants.KEY_BANK_FIRST_NAME : bank.first_name,
			Constants.KEY_BANK_LAST_NAME : bank.last_name,
			Constants.KEY_BANK_CITY : bank.city,
			Constants.KEY_BANK_LINE1 : bank.line1,
			Constants.KEY_BANK_POSTAL_CODE : bank.postal_code,
			Constants.KEY_BANK_STATE : bank.state,
			Constants.KEY_BANK_SSN_LAST4 : bank.ssn_last_4
		]
		
		Alamofire.request(REQ_UPDATE_STRIPEACCOUNT, method: .post, parameters: params).responseJSON { response in
			if response.result.isSuccess
			{
				let json = JSON(response.result.value!)
				let success = json[Constants.RES_STATUS].stringValue
				if success == Constants.PROCESS_SUCCESS {
					pub.pub_bankaccount.account_status = json[Constants.RES_ACCOUNT_DATA][Constants.RES_STATUS].stringValue
					completion(Constants.PROCESS_SUCCESS)
				}
				else  {
					
					completion(success)
				}
				
			}
			else {
				completion(Constants.CHECK_NETWORK_ERROR)
			}
		}
	}
	
	static func getAccountDetails (_ pub: PubModel, completion: @escaping (String) -> ()) {
		
		let params = [
			Constants.KEY_EMAIL: pub.pub_contactemail
		]
		Alamofire.request(REQ_ACCOUNT_DETAILS, method: .post, parameters: params).responseJSON { response in
			if response.result.isSuccess
			{
				let json = JSON(response.result.value!)
				let success = json[Constants.RES_STATUS].stringValue
				if success == Constants.PROCESS_SUCCESS {
					pub.pub_bankaccount.account_status = json[Constants.RES_ACCOUNT_DATA][Constants.RES_STATUS].stringValue
					completion(Constants.PROCESS_SUCCESS)
				}
				else  {
					
					completion(success)
				}
				
			}
			else {
				completion(Constants.CHECK_NETWORK_ERROR)
			}
		}
	}
	
	static func buyProduct(_ pubEmail: String, token: String, price: String, userEmail: String,completion: @escaping (String) -> ()) {
		
		let params = [
			Constants.KEY_PAYMENT_EMAIL: pubEmail,
			Constants.KEY_PAYMENT_PRODUCTPRICE : "\(Double(price)! * 100)",
			Constants.KEY_PAYMENT_STRIPE_TOKEN : token,
			Constants.KEY_PAYMENT_CUSTOMEREMAIL : userEmail
		]
		Alamofire.request(REQ_PRODUCT_BUY, method: .post, parameters: params).responseJSON { response in
			
			if response.result.isSuccess
			{
				let json = JSON(response.result.value!)
				let message = json[Constants.RES_STATUS].stringValue
				if message == Constants.PROCESS_SUCCESS {
					completion(Constants.PROCESS_SUCCESS)
				}
				else  {
					completion(json["data"]["message"].stringValue)
				}
				
			}
			else {
				completion(Constants.CHECK_NETWORK_ERROR)
			}
		}
	}
	
	

	
}
