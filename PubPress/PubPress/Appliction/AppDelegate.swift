//
//  AppDelegate.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyA25SsUim8a0a5zBw0oxhsvU8bc3qx9myA")
        GMSPlacesClient.provideAPIKey("AIzaSyA25SsUim8a0a5zBw0oxhsvU8bc3qx9myA")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        updateTimer()
        locationManager.requestLocation()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    


}

extension AppDelegate : CLLocationManagerDelegate {
    //MARK: --- location functions
    
    func updateTimer(){
        
        Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
    }
    
    func updateLocation()
    {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first
        
        currentLatitude = (location?.coordinate.latitude)! as Double
        currentLongitude = (location?.coordinate.longitude)! as Double
        if(currentUser.user_id > 0){
            /*CLGeocoder().reverseGeocodeLocation(location!, completionHandler: {
             placemarks, error in
             var placeMark: CLPlacemark!
             placeMark = placemarks?.last
             
             
             var addressString = ""
             
             if(placeMark != nil){
             // Location name
             if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
             addressString = locationName as String
             }
             
             }
             
             })*/
            currentUser.user_latitude = currentLatitude
            currentUser.user_longitude = currentLongitude
            
            /*
             FirebaseUserAuthentication.getAllUsers(completion: {
             users in
             globalUsersArray = users
             var friendsArray : [FriendModel] = []
             for friend in myFriends{
             let user = FirebaseUserAuthentication.getUserFromUserid(friend.friend_user.user_id)
             if user != nil{
             friend.friend_user = user!
             friendsArray.append(friend)
             }
             }
             myFriends = friendsArray
             })*/
            
            
        }
        manager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }


}

//MARK: - current location

var currentLatitude = 0.0
var currentLongitude = 0.0

