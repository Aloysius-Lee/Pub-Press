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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
}
