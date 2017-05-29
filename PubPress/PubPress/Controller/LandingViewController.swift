//
//  LandingViewController.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class LandingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	@IBAction func logoutButtonTapped(_ sender: Any) {
		if UserDefaults.standard.value(forKey: Constants.KEY_EMAIL) != nil {
			UserDefaults.standard.removeObject(forKey: Constants.KEY_EMAIL)
			UserDefaults.standard.removeObject(forKey: Constants.KEY_PASSWORD)
			currentUser = UserModel()
			currentPub = PubModel()
		}
		let startVC = storyboard?.instantiateViewController(withIdentifier: "StartViewController")
		self.navigationController?.viewControllers = [startVC!]
	}
	@IBAction func settingsButtonTapped(_ sender: Any) {
		if currentPub.pub_id.characters.count > 0 {
			let pubDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PubDetailViewController") as! PubDetailViewController
			pubDetailVC.pub = currentPub
			self.navigationController?.pushViewController(pubDetailVC, animated: true)
		}
		else if currentUser.user_id.characters.count > 0 {
			

			let userSettingVC = storyboard?.instantiateViewController(withIdentifier: "ProfileSettingViewController") as! ProfileSettingViewController
			self.navigationController?.pushViewController(userSettingVC, animated: true)
			
			
		}
		else {
			logoutButtonTapped("")
		}
	}
}
