//
//  CommonUtils.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreLocation

class CommonUtils: AnyObject{
    
    static func isValidEmail(_ email: String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        
        let rect = CGRect(x:0, y: 0, width : targetSize.width, height : targetSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func getSortedString(_ strings: [String]) -> [String]{
        let sortedArray = strings.sorted {
            $0 < $1
        }
        return sortedArray
    }
    
    static func getStringForTags(){
        
    }
    
    static func getRandomNumber(_ maxValue : Int) -> Int{
        return Int(arc4random_uniform(UInt32(maxValue)))
    }
    /*
    static func getDistance(location1 : (Double, Double) , location2 : (Double, Double)) -> Double{
        var distance : Double = 0
        return distance
    }
    */
    
    static func getDistanceFromMe(_ user: UserModel) -> Double{
        let mylocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        let userlocaiton = CLLocation(latitude: user.user_latitude, longitude: user.user_longitude)
        return mylocation.distance(from: userlocaiton) / 1609.344
    }
    
    static func getWeekDayString(_ weekday: Int) -> String{
        var result = ""
        switch weekday {
        case 0:
            result = "Monday"
            break
        case 1:
            result = "Tuesday"
            break
        case 2:
            result = "Wednesday"
            break
        case 3:
            result = "Thursday"
            break
        case 4:
            result = "Friday"
            break
        case 5:
            result = "Saturday"
            break
        case 6:
            result = "Sunday"
            
        default:
            break
        }
        return result
    }
    
    
    
    

    
    
}



