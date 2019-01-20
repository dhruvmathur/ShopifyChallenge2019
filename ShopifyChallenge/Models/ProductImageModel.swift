//
//  ProductImage.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-19.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class ProductImageModel: Decodable {
    let src: String
    
    init(json: [String:Any]) {
        src = json["src"] as? String ?? ""
    }
}
