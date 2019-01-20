//
//  ViewController.swift
//  ShopifyChallenge
//
//  Created by Dhruv Mathur on 2019-01-09.
//  Copyright © 2019 Dhruv Mathur. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomCollectionViewController: UITableViewController {
    
    @IBOutlet var collectionsTableView: UITableView!
    
    var viewModel: CustomCollectionViewModel!
    
    private let cellIdentifier = "collectionViewCell"
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel = CustomCollectionViewModel()
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = UIColor.gray

        viewModel.output.customCollectionModels
            .drive(tableView.rx.items) { tableView, index, element in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = element.title
                cell.textLabel?.font = UIFont.init(name: "Gill Sans", size: 17)
                cell.imageView?.downloaded(from: (element.image?.src)!)
                if indexPath.row % 2 == 0 {
                    cell.backgroundColor = UIColor.darkGray
                } else {
                    cell.backgroundColor = UIColor.gray
                }
                cell.textLabel?.textColor = UIColor.white
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.asObservable()
            .bind(to: viewModel.input.cellTapped)
            .disposed(by: disposeBag)
        
        viewModel.output.initateSegue
            .drive(onNext: { data in
                CollectionDetailsViewController.collectionModel = data
                self.performSegue(withIdentifier: "segue", sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.input.eventViewReady.onNext(Void())
    }
    
    private func setupTableView() {
        collectionsTableView.delegate = nil
        collectionsTableView.dataSource = nil
        
        collectionsTableView.tableFooterView = UIView() 
        collectionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

