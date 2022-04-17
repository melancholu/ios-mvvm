//
//  UIColor.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import UIKit

extension UIColor {
    static func of(_ name: String) -> UIColor {
        return UIColor(named: name) ?? UIColor.clear
    }
}
