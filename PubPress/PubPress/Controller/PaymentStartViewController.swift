//
//  PaymentStartViewController.swift
//  PubPress
//
//  Created by Zhuxian on 4/30/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import Stripe

class PaymentStartViewController: BaseViewController {

	@IBOutlet weak var cardNumberTextField: STPPaymentCardTextField!
	@IBOutlet weak var priceLabel: UILabel!
	
	var pub_email = ""
	var product = ProductModel()
	
	var token = ""
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		priceLabel.text = "price: \(product.product_price)£"
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func buyButtonTapped(_ sender: Any) {
		showLoadingView()
		STPAPIClient.shared().createToken(withCard: cardNumberTextField.cardParams) { (token, error) in
			if error != nil {
				self.hideLoadingView()
				self.showToastWithDuration(string: error.debugDescription, duration: 3.0)
			}
			else {
				ApiFunctions.buyProduct(self.pub_email, token: (token?.tokenId)!, price: self.product.product_price, userEmail: currentUser.user_email, completion: {
					message in
					self.hideLoadingView()
					if message == Constants.PROCESS_SUCCESS {
						RootViewController.message = "Payment done successfully"
						self.navigationController?.popViewController(animated: true)
					}
					else {
						RootViewController.message = message
						self.navigationController?.popViewController(animated: true)
					}
				})
			}
		}
		
	}
	
	@IBAction func cancelButtonTapped(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
}
/*
extension PaymentStartViewController: STPAddCardViewControllerDelegate
{
    
    func buyButtonTapped() {
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        // STPAddCardViewController must be shown inside a UINavigationController.
        let navigationController = UINavigationController(rootViewController: addCardViewController)
		self.present(navigationController, animated: true, completion: nil)
    }

    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
		if token.tokenId.characters.count > 0 {
			self.dismiss(animated: true, completion: nil)
		}
    }
    
}*/

