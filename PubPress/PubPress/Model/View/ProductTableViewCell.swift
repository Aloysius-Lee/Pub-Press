//
//  ProductTableViewCell.swift
//  PubPress
//
//  Created by Quan Zhuxian on 22/05/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

	@IBOutlet weak var productImageView: UIImageView!
	@IBOutlet weak var productNameLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setCell(_ product: ProductModel) {
		productImageView.sd_setImage(with: URL(string: product.product_image), placeholderImage: UIImage(named: "image_beer_cup"))
		productNameLabel.text = product.product_name
		priceLabel.text = product.product_price + "￡"
	}

}
