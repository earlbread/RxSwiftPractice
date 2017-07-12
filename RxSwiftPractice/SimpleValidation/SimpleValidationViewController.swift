//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by Seunghun Lee on 2017-07-11.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit

class SimpleValidationViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var usernameValidLabel: UILabel!

  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordValidLabel: UILabel!

  @IBOutlet weak var validateButton: UIButton!
  
  let minimalUsernameLength = 5
  let minimalPasswordLength = 5
  
  var isUsernameValid = false
  var isPasswordValid = false
  
  override func viewDidLoad() {
    super.viewDidLoad()

    usernameTextField.addTarget(self, action: #selector(self.usernameTextFieldDidChange(_:)), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(self.passwordTextFieldDidChange(_:)), for: .editingChanged)

    usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
    passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"

    validateButton.isEnabled = false
  }

  func usernameTextFieldDidChange(_ textField: UITextField) {
    let text = textField.text ?? ""

    if text.characters.count < minimalUsernameLength {
      isUsernameValid = false
    } else {
      isUsernameValid = true
    }

    usernameValidLabel.isHidden = isUsernameValid
    validateButton.isEnabled = (isUsernameValid && isPasswordValid)
  }

  func passwordTextFieldDidChange(_ textField: UITextField) {
    let text = textField.text ?? ""

    if text.characters.count < minimalPasswordLength {
      isPasswordValid = false
    } else {
      isPasswordValid = true
    }

    passwordValidLabel.isHidden = isPasswordValid
    validateButton.isEnabled = (isUsernameValid && isPasswordValid)
  }

  @IBAction func validateButtonDidTap(_ sender: UIButton) {
    let alert = UIAlertController(title: "Simple Validation", message: "Valid!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alert, animated: true)
  }
}
