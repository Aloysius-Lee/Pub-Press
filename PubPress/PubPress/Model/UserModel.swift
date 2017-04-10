//
//  UserModel.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class UserModel {
    
    var user_id : Int64 = 0
    var user_firstname = ""
    var user_lastname = ""
    var user_email = ""
    var user_password = ""
    var user_profileimageurl = "https://s-media-cache-ak0.pinimg.com/236x/c0/2a/2e/c02a2ed987f8a55a38be617d3d470f4f.jpg"
    var user_latitude = 0.0
    var user_longitude = 0.0
    
}


var currentUser = UserModel()


