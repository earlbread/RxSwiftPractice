//
//  RxSimpleValidationMVVMViewModel.swift
//  RxSwiftPractice
//
//  Created by Seunghun Lee on 2017-07-12.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import RxSwift

struct RxSimpleValidationMVVMViewModel {
  var username = Variable("")
  var password = Variable("")
  
  let minimalUsernameLength = 5
  let minimalPasswordLength = 5

  var isUsernameValid: Observable<Bool> {
    return username.asObservable().map { $0.characters.count >= self.minimalUsernameLength }
  }

  var isPasswordValid: Observable<Bool> {
    return password.asObservable().map { $0.characters.count >= self.minimalPasswordLength }
  }

  var isValid: Observable<Bool> {
    return Observable.combineLatest(isUsernameValid, isPasswordValid) { $0 && $1 }
  }
}
