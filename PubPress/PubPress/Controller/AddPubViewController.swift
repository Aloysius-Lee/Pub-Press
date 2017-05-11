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

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = pub.pub_name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func getGoogleDataButtonTapped(_ sender: Any) {
        searchRadius = 300
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController")
        self.navigationController?.pushViewController(mapVC!, animated: true)
    }


}
