//
//  RxSimpleValidationMVVMViewController.swift
//  RxSwiftPractice
//
//  Created by Seunghun Lee on 2017-07-12.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSimpleValidationMVVMViewController: UIViewController {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var usernameValidLabel: UILabel!
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordValidLabel: UILabel!
  
  @IBOutlet weak var validateButton: UIButton!

  let viewModel = RxSimpleValidationMVVMViewModel()
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    usernameValidLabel.text = "Username has to be at least \(viewModel.minimalUsernameLength) characters"
    passwordValidLabel.text = "Password has to be at least \(viewModel.minimalPasswordLength) characters"

    usernameTextField.rx.text.orEmpty
      .bind(to: viewModel.username)
      .disposed(by: disposeBag)

    passwordTextField.rx.text.orEmpty
      .bind(to: viewModel.password)
      .disposed(by: disposeBag)

    viewModel.isUsernameValid
      .bind(to: usernameValidLabel.rx.isHidden)
      .disposed(by: disposeBag)

    viewModel.isPasswordValid
      .bind(to: passwordValidLabel.rx.isHidden)
      .disposed(by: disposeBag)

    viewModel.isValid
      .bind(to: validateButton.rx.isEnabled)
      .disposed(by: disposeBag)

    validateButton.rx.tap
      .subscribe(onNext: { [unowned self] in self.showAlert() })
      .disposed(by: disposeBag)
  }

  func showAlert() {
    let alert = UIAlertController(title: "Simple Validation", message: "Valid!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alert, animated: true)
  }

}
