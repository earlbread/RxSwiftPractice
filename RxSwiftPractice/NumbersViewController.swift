//
//  NumbersViewController.swift
//  RxSwiftPractice
//
//  Created by Seunghun Lee on 2017-07-07.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {
  // MARK: Properties
  @IBOutlet weak var number1: UITextField!
  @IBOutlet weak var number2: UITextField!
  @IBOutlet weak var number3: UITextField!

  @IBOutlet weak var result: UILabel!

  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) {
      textValue1, textValue2, textValue3 -> Int in
      return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
      }
      .map{ $0.description }
      .bind(to: result.rx.text)
      .disposed(by: disposeBag)
  }
}
