//
//  RxSimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by Seunghun Lee on 2017-07-12.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSimpleValidationViewController: UIViewController {
    
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var usernameValidLabel: UILabel!
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordValidLabel: UILabel!
  
  @IBOutlet weak var validateButton: UIButton!
  
  let minimalUsernameLength = 5
  let minimalPasswordLength = 5

  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
    passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"

    let usernameValid = usernameTextField.rx.text.orEmpty
      .map{ $0.characters.count >= self.minimalUsernameLength }
      .shareReplay(1)

    let passwordValid = passwordTextField.rx.text.orEmpty
      .map{ $0.characters.count >= self.minimalPasswordLength }
      .shareReplay(1)

    let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
      .shareReplay(1)

    usernameValid
      .bind(to: usernameValidLabel.rx.isHidden)
      .disposed(by: disposeBag)

    passwordValid
      .bind(to: passwordValidLabel.rx.isHidden)
      .disposed(by: disposeBag)

    everythingValid
      .bind(to: validateButton.rx.isEnabled)
      .disposed(by: disposeBag)

    validateButton.rx.tap
      .subscribe(onNext: { [weak self] in self?.showAlert() } )
      .disposed(by: disposeBag)
  }

  func showAlert() {
    let alert = UIAlertController(title: "Simple Validation", message: "Valid!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alert, animated: true)
  }
}
