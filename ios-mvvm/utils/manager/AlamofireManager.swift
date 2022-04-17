//
//  AlamofireManager.swift
//  ios-mvvm
//
//  Created by song dong hyeok on 2022/04/17.
//

import Alamofire

final class AlamofireManager {
    private var TAG: String {
        return String(describing: Self.self)
    }

    static let shared = AlamofireManager(.live)

    private let state: NetworkState
    private var session: Session?

    init(_ state: NetworkState = .live) {
        self.state = state
        self.session = nil
    }

    func getSession() -> Session {
        guard session == nil else { return session! }

        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.headers = .default

        // TODO: implement mock class for test
//        if state == .test {
//            configuration.protocolClasses = [MockURLProtocol.self]
//        }

        session = Session(configuration: configuration, interceptor: AlamofireInterceptor(), eventMonitors: [AlamofireMonitor()])
        return session!
    }
}

final class AlamofireInterceptor: RequestInterceptor {
    private var TAG: String {
        return String(describing: Self.self)
    }
    private let MAX_RETRY_LIMIT: Int = 3
    private let retryableHTTPMethods: Set<HTTPMethod> = [.delete, .get]
    private let retryableHTTPStatusCodes: Set<Int> = [408, 500, 502, 503, 504]
    private let retryableURLErrorCodes: Set<URLError.Code> = RetryPolicy.defaultRetryableURLErrorCodes

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if request.retryCount < MAX_RETRY_LIMIT, shouldRetry(request: request, dueTo: error) {
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }

    func shouldRetry(request: Request, dueTo error: Error) -> Bool {
        guard let httpMethod = request.request?.method, retryableHTTPMethods.contains(httpMethod) else { return false }

        if let statusCode = request.response?.statusCode, retryableHTTPStatusCodes.contains(statusCode) {
            return true
        } else {
            let errorCode = (error as? URLError)?.code
            let afErrorCode = (error.asAFError?.underlyingError as? URLError)?.code

            guard let code = errorCode ?? afErrorCode else { return false }

            return retryableURLErrorCodes.contains(code)
        }
    }
}

final class AlamofireMonitor: EventMonitor {
    private var TAG: String {
        return String(describing: Self.self)
    }
    let queue = DispatchQueue(label: "NETWORK_QUEUE")

    func requestDidFinish(_ request: Request) {
        print(request)
    }

    public func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }

        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}

