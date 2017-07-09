//
//  RxAddingItemViewController.swift
//  RxSwiftPractice
//
//  Created by Seunghun Lee on 2017-07-09.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxAddingItemViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  let items = Variable([String]())
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    items
      .asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self))
      { (row, element, cell) in
        cell.textLabel?.text = self.items.value[row]
      }
      .disposed(by: disposeBag)
  }

  @IBAction func addButtonDidTap(_ sender: UIBarButtonItem) {
    let number = items.value.count.description
    items.value.append("Item \(number)")
  }
}
