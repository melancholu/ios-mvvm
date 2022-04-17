//
//  BaseViewModel.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Foundation
import Combine

class BaseViewModel {

    var TAG: String {
        return String(describing: Self.self)
    }
    var bindings = Set<AnyCancellable>()

}
