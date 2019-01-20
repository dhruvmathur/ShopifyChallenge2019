//
//  VariantModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-19.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class VariantModel: Decodable {
    let inventory_quantity: Int
    
    init(json: [String:Any]) {
        inventory_quantity = json["inventory_quantity"] as? Int ?? 0
    }
}
