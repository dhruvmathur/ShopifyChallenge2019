//
//  CollectsWrapperModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-18.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class CollectsWrapperModel: Decodable {
    let collects: [CollectsModel]
    
    init (json: [String:Any]) {
        collects = json["collects"] as? [CollectsModel] ?? [CollectsModel(json: [:])]
    }
}
