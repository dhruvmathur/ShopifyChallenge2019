//
//  CustomCollectionsWrapperModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-13.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class CustomCollectionsWrapperModel: Decodable {
    let custom_collections: [CustomCollectionModel]
    
    init (json: [String:Any]) {
        custom_collections = json["custom_collections"] as? [CustomCollectionModel] ?? [CustomCollectionModel(json: [:])]
    }
}
