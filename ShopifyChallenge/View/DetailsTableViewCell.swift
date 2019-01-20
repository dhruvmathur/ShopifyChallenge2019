//
//  DetailsTableViewCell.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-19.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectImage: UIImageView!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var inventoryCount: UILabel!
    @IBOutlet weak var productType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(product: ProductModel, collectionModel: CustomCollectionModel, image: UIImage?){
        
        let variants = product.variants
        var variantCount = 0
        for variant in variants {
            variantCount += variant.inventory_quantity
        }
        
        self.collectImage.downloaded(from: product.image.src)
        self.productName.text = product.title
        self.productType.text = product.product_type
        self.collectionName.text = collectionModel.title
        self.inventoryCount.text = "Inventory: \(variantCount)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
