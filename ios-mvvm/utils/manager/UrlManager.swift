//
//  UrlManager.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Foundation

final class UrlManager {
    private var TAG: String {
        return String(describing: Self.self)
    }

    private var component: URLComponents

    init() {
        component = URLComponents()
        component.host = "BASE URL"

        if component.host == "127.0.0.1" || component.host == "localhost" {
            self.component.port = 8000
            self.component.scheme = "http"
        } else {
            self.component.scheme = "https"
        }
    }

    func getUrl(path: String, queryParameters: [String: String]?) -> String {
        component.path = path
        component.queryItems = queryParameters?.map { element in URLQueryItem(name: element.key, value: element.value) }

        return component.url?.absoluteString ?? ""
    }
}

