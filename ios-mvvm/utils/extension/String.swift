//
//  String.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
