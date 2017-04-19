//
//  RootViewController.swift
//  PubPress
//
//  Created by Big Shark on 08/04/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import CarbonKit

class RootViewController: UIViewController, CarbonTabSwipeNavigationDelegate{

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var cheapestBeerLabel: UILabel!
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
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
        if currentLatitude > -100{
            if selectedVC == 0{
                setVC(1)
            }
            else{
                setVC(0)
            }
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


}
