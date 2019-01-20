//
//  CollectionDetailsViewModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-17.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CollectionDetailsViewModel {
    
    let input: Input
    let output: Output
    
    struct Input {
        let eventViewReady: AnyObserver<Void>
        let collectionData: AnyObserver<CustomCollectionModel>
    }
    
    struct Output {
        let productDetails: Driver<[ProductModel]>
    }
    
    private let viewReadySubject = PublishSubject<Void>()
    private let collectionDataSubject = PublishSubject<CustomCollectionModel>()
    
    init(collectionId: Int) {
        self.input = Input(eventViewReady: viewReadySubject.asObserver(), collectionData: collectionDataSubject.asObserver())
        
        let productModels = viewReadySubject
            .flatMap({ ShopifyAPIService.shared.getCollects(collectionId: collectionId) })
            .map({ collects -> [String] in
                var productArray: [String] = []
                for collect in collects {
                    productArray.append(String(collect.product_id))
                }
                return productArray
            }).flatMap({ productArray -> Observable<[ProductModel]> in
                let products = productArray.joined(separator: ",")
                return ShopifyAPIService.shared.getProducts(productIds: products)
            })
        
        self.output = Output(productDetails: productModels.asDriver(onErrorJustReturn: [ProductModel(json: [:])]))
    }
}
