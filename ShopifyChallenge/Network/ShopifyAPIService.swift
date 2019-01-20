//
//  ShopifyAPIService.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-09.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import SwiftyJSON

class ShopifyAPIService {
    static let shared = ShopifyAPIService()
    
    static let accessToken = "c32313df0d0ef512ca64d5b336a0d7c6"
    
    struct Constants {
        struct APIDetails {
            static let APIScheme = "https"
            static let APIHost = "shopicruit.myshopify.com"
            static let APIPath = "/admin/"
        }
    }
    
    func getCustomCollections() -> Observable<[CustomCollectionModel]> {
        let url = createURLFromParameters(parameters: ["access_token":ShopifyAPIService.accessToken], pathparam: "custom_collections.json")
        return Observable.create { observer in
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let collections = try JSONDecoder().decode(CustomCollectionsWrapperModel.self, from: data)
                    observer.onNext(collections.custom_collections)
                    observer.onCompleted()
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                    observer.onError(jsonErr)
                }
                }.resume()
            return Disposables.create()
        }
    }
    
    func getProducts(productIds: String) -> Observable<[ProductModel]> {
        print(productIds)
        let url = createURLFromParameters(parameters: ["ids" : productIds, "access_token":ShopifyAPIService.accessToken], pathparam: "products.json")
        print(url)
        return Observable.create { observer in
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let parsedProducts = try JSONDecoder().decode(ProductWrapperModel.self, from: data)
                    observer.onNext(parsedProducts.products)
                    observer.onCompleted()
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                    observer.onError(jsonErr)
                }
                }.resume()
            return Disposables.create()
        }
    }
    
    func getCollects(collectionId: Int) -> Observable<[CollectsModel]> {
        let url = createURLFromParameters(parameters: ["collection_id" : String(collectionId), "access_token":ShopifyAPIService.accessToken], pathparam: "collects.json")
        print(url)
        return Observable.create { observer in
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let parsedCollects = try JSONDecoder().decode(CollectsWrapperModel.self, from: data)
                    observer.onNext(parsedCollects.collects)
                    observer.onCompleted()
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                    observer.onError(jsonErr)
                }
                }.resume()
            return Disposables.create()
        }
    }
    
    private func createURLFromParameters(parameters: [String:Any], pathparam: String?) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.APIDetails.APIScheme
        components.host   = Constants.APIDetails.APIHost
        components.path   = Constants.APIDetails.APIPath
        if let paramPath = pathparam {
            components.path = Constants.APIDetails.APIPath + "\(paramPath)"
        }
        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        
        return components.url!
    }
    
}
