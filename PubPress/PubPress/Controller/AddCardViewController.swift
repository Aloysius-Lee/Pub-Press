//
//  AddCardViewController.swift
//  PubPress
//
//  Created by Quan Zhuxian on 22/05/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class AddCardViewController: BaseViewController {

	var status = 0
	@IBOutlet weak var skipButton: UIButton!
	@IBOutlet weak var backButton: UIButton!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		if status == Constants.ADDCARD_VIEW_REGISTER {
			skipButton.isHidden = false
			
		}
		else if status == Constants.ADDCARD_VIEW_MAIN{
			skipButton.isHidden = true
			backButton.isHidden = false
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be 
		
    }
	
	
	@IBAction func skipButtonTapped(_ sender: Any) {
		gotoAddPubPage()
	}
	
	func gotoAddPubPage() {
		let addProductVC = storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
		self.navigationController?.pushViewController(addProductVC, animated: true)
	}

}
