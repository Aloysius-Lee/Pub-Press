
//
//  ProfileSettingViewController.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ProfileSettingViewController: BaseViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        beerImageView.setImageWith(color: UIColor.black)
    
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

}
