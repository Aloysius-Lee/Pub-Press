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
	var product = ProductModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	


}
