//
//  UserService.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Alamofire
import Combine

protocol UserServiceProtocol {
    func getUser() -> AnyPublisher<User, AFError>
}

class UserService: BaseService, UserServiceProtocol {
    fileprivate struct Urls {
        func GET_USER() -> String { return "\(Service.user.path)/" }
    }

    private let urls: Urls = Urls()

    func getUser() -> AnyPublisher<User, AFError> {
        return get(url: urlManager.getUrl(path: urls.GET_USER(), queryParameters: nil)).publishDecodable(type: User.self)
            .value()
            .eraseToAnyPublisher()
    }
}

