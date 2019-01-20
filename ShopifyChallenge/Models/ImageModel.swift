//
//  ImageModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-13.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

class ImageModel: Decodable {
    let src: URL?
    
    init (json: [String:Any]){
        src = URL(string: json["src"] as! String) as URL? ?? URL(string: "")
    }
}
