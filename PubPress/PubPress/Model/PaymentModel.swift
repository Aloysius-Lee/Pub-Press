//
//  PaymentModel.swift
//  PubPress
//
//  Created by Zhuxian on 4/30/17.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class PaymentModel {
    var payment_id: Int64 = 0
    var payment_amount: UInt = 0
    var payment_country = "UK"
    var payment_statementdescripter = ""
    var payment_sender: Int64 = 0
    var payment_receiver: Int64 = 0
}
