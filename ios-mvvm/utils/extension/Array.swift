//
//  Array.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Foundation

extension Array {
    func getElement(at index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
