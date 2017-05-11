
//
//  ProfileSettingViewController.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileSettingViewController: BaseViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var decadenceView: UIView!
    @IBOutlet weak var tierView: UIView!
    @IBOutlet weak var decadenceAmountConstraint: NSLayoutConstraint!
    @IBOutlet weak var tierAmountConstraint: NSLayoutConstraint!
    @IBOutlet weak var decadenceLabel: UILabel!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var netPintsLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        beerImageView.setImageWith(color: UIColor.black)
        settingImageView.setImageWith(color: UIColor.darkGray)
        giftImageView.setImageWith(color: UIColor.darkGray)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    func setUser(_ user: UserModel) {
        //set user imageview
        if user.user_profileimageurl.characters.count > 0 {
            profileImageView.sd_setImage(with: URL(string: user.user_profileimageurl)!, placeholderImage: UIImage(named: "profile"))
        }
        else {
            profileImageView.image = UIImage(named: "profile")
            
        }
        decadenceAmountConstraint.constant = decadenceView.bounds.width * CGFloat(Float(user.user_decadence)!)
        decadenceLabel.text = user.user_decadence + "%"
        tierAmountConstraint.constant = tierView.bounds.width * CGFloat(Float(user.user_tier)!)
        tierLabel.text = user.user_tier + "%"
        
        netPintsLabel.text = user.user_netpints
        creditsLabel.text = user.user_credits
        
        
    }
    
    @IBAction func changeImageButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func giftButtonTapped(_ sender: Any) {
        
    }
    
}
