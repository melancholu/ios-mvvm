//
//  UIFont.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import UIKit

extension UIFont {
    static func of(_ name: String, _ size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
