//
//  Service.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

enum Service {
    case user

    var path: String {
        switch self {
        case .user:   return "/user/"
        }
    }
}
