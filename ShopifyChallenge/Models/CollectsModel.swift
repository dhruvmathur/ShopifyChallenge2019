//
//  CollectsModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-18.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class CollectsModel: Decodable {
    let collection_id: Int
    let product_id: Int
    
    init(json: [String:Any]) {
        collection_id = json["collection_id"] as? Int ?? 0
        product_id = json["product_id"] as? Int ?? 0
    }
}
