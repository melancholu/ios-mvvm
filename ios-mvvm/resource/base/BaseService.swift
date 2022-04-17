//
//  BaseService.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Alamofire

class BaseService {
    var TAG: String {
        return String(describing: Self.self)
    }

    private let alamofireManager: AlamofireManager
    private let session: Session
    private let statusCodeValidRange: Range<Int>
    let urlManager: UrlManager

    init(_ state: NetworkState = .live) {
        alamofireManager = state == .live ? AlamofireManager.shared : AlamofireManager(.test)
        session = alamofireManager.getSession()
        statusCodeValidRange = 200..<300
        urlManager = UrlManager()
    }

    func get(url: String) -> DataRequest {
        return request(url: url, method: .get, encoding: URLEncoding.default)
    }

    func post<T: Encodable>(url: String, params: T) -> DataRequest {
        return request(url: url, method: .post, params: params)
    }
    
    func patch<T: Encodable>(url: String, params: T) -> DataRequest {
        return request(url: url, method: .patch, params: params)
    }

    func patch(url: String, params: Parameters) -> DataRequest {
        return request(url: url, method: .patch, params: params, encoding: JSONEncoding.default)
    }

    func post(url: String, params: Parameters = [:]) -> DataRequest {
        return request(url: url, method: .post, params: params, encoding: JSONEncoding.default)
    }

    func put(url: String, params: Parameters = [:]) -> DataRequest {
        return request(url: url, method: .put, params: params, encoding: JSONEncoding.default)
    }

    func delete(url: String, params: Parameters = [:]) -> DataRequest {
        return request(url: url, method: .delete, encoding: JSONEncoding.default)
    }

    func upload(data: MultipartFormData, url: String, contentType: String) -> DataRequest {
        return session.upload(multipartFormData: data, to: URL(string: url)!, usingThreshold: UInt64.init(), method: .post, headers: ["Content-Type": contentType]).validate(statusCode: statusCodeValidRange)
    }

    private func request(url: String, method: HTTPMethod, params: Parameters = [:], encoding: ParameterEncoding) -> DataRequest {
        return session.request(url, method: method, parameters: params, encoding: encoding).validate(statusCode: statusCodeValidRange)
    }

    private func request<T: Encodable>(url: String, method: HTTPMethod, params: T) -> DataRequest {
        return session.request(url, method: method, parameters: params, encoder: JSONParameterEncoder.default).validate(statusCode: statusCodeValidRange)
    }
}

