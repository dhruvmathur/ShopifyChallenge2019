//
//  CustomCollectionViewModel.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-11.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CustomCollectionViewModel {
    
    let input: Input
    let output: Output
    
    struct Input {
        let eventViewReady: AnyObserver<Void>
        let cellTapped: AnyObserver<IndexPath>
    }
    
    struct Output {
        let customCollectionModels: Driver<[CustomCollectionModel]>
        let initateSegue: Driver<CustomCollectionModel>
    }
    
    private let viewReadySubject = PublishSubject<Void>()
    private let cellTappedSubject = PublishSubject<IndexPath>()
    
    init() {
        self.input = Input(eventViewReady: viewReadySubject.asObserver(), cellTapped: cellTappedSubject.asObserver())
        
        let collectionModels = viewReadySubject
            .flatMap({ _ -> Observable<[CustomCollectionModel]> in
                return ShopifyAPIService.shared.getCustomCollections()
            })
        
        let tapResult = cellTappedSubject
            .withLatestFrom(collectionModels){ index, models in
            return (index, models) }
            .map{ data in
                return data.1[data.0.row]
        }
        
        self.output = Output(customCollectionModels: collectionModels.asDriver(onErrorJustReturn: []), initateSegue: tapResult.asDriver(onErrorJustReturn: CustomCollectionModel(json: [:])))
    }
}
