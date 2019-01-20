//
//  ProductWrapperModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-13.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class ProductWrapperModel: Decodable {
    let products: [ProductModel]
    
    init(json: [String:Any]) {
        products = json["products"] as? [ProductModel] ?? [ProductModel(json: [:])]
    }
}
