//
//  PubModel.swift
//  PubPress
//
//  Created by Zhuxian on 4/17/17.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class PubModel {
    
    var pub_id                  = ""
    var pub_name                = ""
    var pub_latitude            = 0.0
    var pub_longitude           = 0.0
    var pub_placeid             = ""
    var pub_vicinity            = ""
    var pub_opennow             = false
    var photo_reference         = ""
    var pub_openhours: [String] = []
    var pub_imageurl            = ""
    var pub_contactemail        = ""
    var pub_contactpassword     = ""
    var pub_formatted_phone_number         = ""
    var pub_formatted_address   = ""
    
    var pub_products: [ProductModel] = []
    
    
    func getOpenhourString() -> String {
        var result = ""
        if pub_opennow {
            result = "Open now"
        }
        else{
            result = "Close now"
        }
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        let weekdayString = CommonUtils.getWeekDayString(weekday)
        for time in pub_openhours {

            if time.hasPrefix(weekdayString)
            {
                result +=  time.replacingOccurrences(of: weekdayString, with: "")
                break
                
            }
        }
        
        return result
    }
}

var currentPub = PubModel()
