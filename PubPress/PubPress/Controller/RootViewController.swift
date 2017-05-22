//
//  RootViewController.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import CarbonKit
import Toast_Swift

class RootViewController: BaseViewController, CarbonTabSwipeNavigationDelegate{

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var cheapestBeerLabel: UILabel!
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var positionImageView: UIImageView!
    @IBOutlet weak var pubNameLabel: UILabel!
    
    
    var currentPub = PubModel()
    
    var selectedVC = 0
    
    var carbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var contentVCs : [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        beerImageView.setImageWith(color: .black)
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        
        //Hide NavigationView
        self.navigationController?.isNavigationBarHidden = true
        
        //set bottom tab bar items
        UITabBar.appearance().backgroundColor = UIColor.white
        
        //set main image color
        
        contentVCs.append((self.storyboard?.instantiateViewController(withIdentifier: "LandingViewController"))!)
        contentVCs.append((self.storyboard?.instantiateViewController(withIdentifier: "MapViewController"))!)
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items:["1", "2"], delegate : self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: contentView)
        style()
        //self.view.isUserInteractionEnabled = false
    }
    
    func style(){
        
        carbonTabSwipeNavigation.setTabBarHeight(0)
        
    }
    @IBAction func beerButtonTapped(_ sender: Any) {
        /*if selectedVC == 0{
            setVC(1)
        }
        else{
            setVC(0)
        }*/
        
            if selectedVC == 0{
                setVC(1)
            }
            else{
                setVC(0)
            }
    }

    //Mark: - CarbonTabSwipeNavigation Delegate
    // required
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController{
       
            return contentVCs[Int(index)]
    }
    
    func setVC(_ index: Int) {
        carbonTabSwipeNavigation.setCurrentTabIndex(UInt(index), withAnimation: true)
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        selectedVC = Int(index)
    }
    
    func setPubView() {
        
        addressLabel.text = currentPub.pub_vicinity
        if currentPub.pub_opennow {
            openTimeLabel.text = "Open now"
            
        }
        else{
            openTimeLabel.text = "Close now"
        }
        pubNameLabel.text = currentPub.pub_name
        self.positionImageView.image = UIImage(named: "image_beer_cup")
        if currentPub.photo_reference.characters.count > 0{
            //showLoadingView()
            self.view.isUserInteractionEnabled = false
            self.positionImageView.startAnimating()
            ApiFunctions.getGooglePhotoes(currentPub.photo_reference, completion: { (success, data) in
                self.view.isUserInteractionEnabled = true
                //self.hideLoadingView()
                
                self.positionImageView.stopAnimating()
                if data != nil {
                    self.positionImageView.image = UIImage(data: data!)
                }
            })
        }
        
        ApiFunctions.getPlaceDetails(currentPub.pub_placeid) { (success, pub) in
            if success{
                self.currentPub = pub!
                
                self.addressLabel.text = pub!.pub_formatted_address
                self.openTimeLabel.text = pub?.getOpenhourString()
                self.pubNameLabel.text = pub!.pub_name
            }
        }
    }

}
