//
//  CollectionDetailsModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-13.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class ProductModel: Decodable {
    let id: Int
    let title: String
    let body_html: String
    let vendor: String
    let product_type: String
    let variants: [VariantModel]
    let image: ProductImageModel

    init(json: [String:Any]) {
        id = json["id"] as? Int ?? 0
        title = json["title"] as? String ?? ""
        body_html = json["body_html"] as? String ?? ""
        vendor = json["vendor"] as? String ?? ""
        product_type = json["product_type"] as? String ?? ""
        variants = json["variants"] as? [VariantModel] ?? []
        image = json["image"] as? ProductImageModel ?? ProductImageModel(json: [:])
    }
}
