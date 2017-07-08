//
//  AddingItemViewController.swift
//  RxSwiftPractice
//
//  Created by Seunghun Lee on 2017-07-08.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit

class AddingItemViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var items = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }

  @IBAction func addButtonDidTap(_ sender: UIBarButtonItem) {
    let section = 0
    let row = tableView.numberOfRows(inSection: section)
    let indexPath = IndexPath(row: row, section: section)
    let number = items.count.description
    let item = ("Item \(number)")

    items.append(item)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
}

extension AddingItemViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    cell.textLabel?.text = items[indexPath.row]

    return cell
  }
}
