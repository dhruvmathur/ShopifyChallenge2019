//
//  CustomCollectionModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-11.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class CustomCollectionModel: Decodable {
    let id: Int
    let handle: String
    let title: String
    let body_html: String
    let image: ImageModel?

    init(json: [String:Any]){
        id = json["id"] as? Int ?? 0
        handle = json["handle"] as? String ?? ""
        title = json["title"] as? String ?? ""
        body_html = json["body_html"] as? String ?? ""
        image = json["image"] as? ImageModel
    }
}
