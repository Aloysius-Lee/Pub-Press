//
//  PaymentGateWayUtils.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import Stripe

class PaymentGatewayUtils {
    
    /*static func createSource(_ paymentModel: PaymentModel) {
        let sourceParams = STPSourceParams.sofortParams(withAmount: paymentModel.payment_amount,
                                                        returnURL: StripeConstants.STRIPE_RETURN_URL,
                                                        country: paymentModel.payment_country ,
                                                        statementDescriptor: paymentModel.payment_country)
        STPAPIClient.shared().createSource(with: sourceParams, completion: {(source, error) in
            if let e = error {
                self.handleError(e)
            } else {
                self.source = source
                self.presentPollingUI()
                NotificationCenter.default.addObserver(self, selector: #selector(handleAppForeground), name: .UIApplicationWillEnterForeground, object: nil)
                UIApplication.shared.openURL(url)
            }
        })
    }
    
    static func createSourceWithCard(_ user: UserModel) {
        let cardParams = STPCardParams()
        cardParams.name = user.user_cardname
        cardParams.number = user.user_cardnumber
        cardParams.expMonth = user.user_expMonth
        cardParams.expYear = user.user_expYear
        cardParams.cvc = user.user_cvc
        
        let sourceParams = STPSourceParams.cardParams(withCard: cardParams)
        STPAPIClient.shared().createSource(with: sourceParams) { (source, error) in
            if let s = source, s.flow == .none && s.status == .chargeable {
                
                .createBackendChargeWithSourceID(s.stripeID)
            }
        }
    }*/
	
	
	
	static func getTokenFromStripe(_ card: CardModel, completion: @escaping (String, String) -> ()) {
		let cardParams = STPCardParams()
		cardParams.number = card.cardnumber
		cardParams.expMonth = card.expMonth
		cardParams.expYear = card.expYear
		cardParams.cvc = card.cvc
		STPAPIClient.shared().createToken(withCard: cardParams) { (token, error) in
			if error == nil {
				completion(Constants.PROCESS_SUCCESS, token!.tokenId)
			}
			else {
				completion(error.debugDescription, "")
			}
		}
	}
	
	static func accountCreate(_ email: String, completion: @escaping (String) -> ()) {
		
	}
	
	
	
	
}

