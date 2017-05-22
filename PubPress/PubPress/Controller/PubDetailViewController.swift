//
//  PubDetailViewController.swift
//  PubPress
//
//  Created by Quan Zhuxian on 10/05/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class PubDetailViewController: BaseViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var decriptionTextView: UITextView!
	@IBOutlet weak var productsTableView: UITableView!
	
	var pub = PubModel()
	
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
    }

	override func viewWillAppear(_ animated: Bool) {
		showPubDetail()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func showPubDetail() {
		var description = ""
		description.append("Name: \(pub.pub_name)\n")
		description.append("Vicinity: \(pub.pub_vicinity)\n")
		description.append("Open hours: \(pub.getOpenhourString())")
		description.append("Contact Email: \(pub.pub_contactemail)")
		decriptionTextView.text = description
	}
    

}

extension PubDetailViewController : UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pub.pub_products.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
		let index = indexPath.row
		cell.setCell(pub.pub_products[index])
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55.0
	}
}
