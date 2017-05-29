//
//  AddProductViewController.swift
//  PubPress
//
//  Created by Zhuxian on 5/1/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class AddProductViewController: BaseViewController {
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var priceTextField: UITextField!
	@IBOutlet weak var descriptionTextView: UITextView!
	var pubId = ""
	var product = ProductModel()
	
	var status = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	
	func initView() {
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func cancelButtonTapped(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}


	@IBAction func addProductButtonTapped(_ sender: Any) {
		product.product_name = nameTextField.text!
		product.product_price = priceTextField.text!
		showLoadingView()
		ApiFunctions.registerProduct(pubid: pubId, product: product, completion: {
			message, product in
			if message == Constants.PROCESS_SUCCESS {
				let pubDetailVC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] as! PubDetailViewController
				pubDetailVC.pub.pub_products.append(product)
				self.navigationController?.popViewController(animated: true)
			}
			else {
				self.showToastWithDuration(string: message, duration: 3.0)
			}
		})
	}
}
