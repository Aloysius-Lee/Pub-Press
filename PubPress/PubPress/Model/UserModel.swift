//
//  UserModel.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class UserModel {
    
    var user_id                         = ""
    var user_name                       = ""
    var user_email                      = ""
    var user_password                   = ""
    var user_profileimageurl            = ""

    
    var user_cardname                   = ""
    var user_cardnumber                 = ""
    var user_expMonth: UInt             = 0
    var user_expYear: UInt              = 0
    var user_cvc                        = ""
    
    var user_tier                       = ""
    var user_credits                    = ""
    var user_netpints                   = ""
    
    
    
}


var currentUser = UserModel()


