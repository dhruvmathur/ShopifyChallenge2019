//
//  CollectionDetailsViewController.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-12.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class CollectionDetailsViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionDescription: UILabel!
    @IBOutlet weak var collectionHandle: UILabel!
    
    static var collectionModel: CustomCollectionModel? = nil
    var viewModel: CollectionDetailsViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        detailsTableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")

        setupTableView()
        setupView()
        
        viewModel = CollectionDetailsViewModel(collectionId: (CollectionDetailsViewController.collectionModel?.id)!)
        
        let imageForTableView: UIImageView = UIImageView(image: nil)
            
            imageForTableView.downloaded(from: (CollectionDetailsViewController.collectionModel?.image?.src)!)
        
        viewModel.output.productDetails
            .drive(detailsTableView.rx.items) { tableView, index, element in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailsTableViewCell
                cell.setup(product: element, collectionModel: CollectionDetailsViewController.collectionModel!, image: imageForTableView.image)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.input.eventViewReady.onNext(Void())
    }
    
    private func setupView(){
        self.cardView.layer.cornerRadius = 10
        self.detailsTableView.layer.cornerRadius = 10
        navigationController?.navigationBar.barTintColor = UIColor.gray
        self.collectionImage.downloaded(from: (CollectionDetailsViewController.collectionModel?.image?.src)!)
        self.collectionName.text = CollectionDetailsViewController.collectionModel?.title
        self.collectionHandle.text = CollectionDetailsViewController.collectionModel?.handle
        self.collectionDescription.text = CollectionDetailsViewController.collectionModel?.body_html
    }
    
    private func setupTableView() {
        //This is necessary since the UITableViewController automatically set his tableview delegate and dataSource to self
        detailsTableView.delegate = nil
        detailsTableView.dataSource = nil
        
        detailsTableView.tableFooterView = UIView() //Prevent empty rows
        detailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
