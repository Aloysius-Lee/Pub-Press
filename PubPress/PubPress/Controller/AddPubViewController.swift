//
//  AddPubViewController.swift
//  PubPress
//
//  Created by Zhuxian on 5/1/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class AddPubViewController: BaseViewController {
    
    var pub: PubModel!

	@IBOutlet weak var latitudeTextField: UITextField!
	@IBOutlet weak var longitudeTextField: UITextField!
	@IBOutlet weak var openhoursTextField: UITextField!
	
	
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		showPubData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func getGoogleDataButtonTapped(_ sender: Any) {
		let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
		mapVC.status = Constants.MAP_VIEW_REGISTER
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
	
	func showPubData() {
		
		nameLabel.text = pub.pub_name
		latitudeTextField.text = "\(pub.pub_latitude)"
		longitudeTextField.text = "\(pub.pub_longitude)"
		openhoursTextField.text = pub.getOpenhourString()
		
	}

	@IBAction func registerButtonTapped(_ sender: Any) {
		showLoadingView()
		ApiFunctions.registerPub(pub, completion: {
			message, registeredPub in
			self.hideLoadingView()
			currentPub = registeredPub
			if message == Constants.PROCESS_SUCCESS {
				UserDefaults.standard.set(registeredPub.pub_contactemail, forKey: Constants.KEY_EMAIL)
				UserDefaults.standard.set(registeredPub.pub_contactpassword, forKey: Constants.KEY_PASSWORD)
				self.gotoMainScene()
			}
			else {
				self.showToastWithDuration(string: message, duration: 3.0)
			}
			
		})
	}
	
}
