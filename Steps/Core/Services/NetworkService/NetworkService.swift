//
//  NetworkService.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//

import Foundation
import Alamofire

enum Result<T: Codable> {
    case success(T, String?)
    case failure(AppError)
}

class NetworkService<T: URLRequestBuilder> {
    @discardableResult
    func request<U: Codable>(service: T, decodeType: U.Type, completion: @escaping(Result<U>) -> Void) -> DataRequest {
        let request = AF.request(service.url, method: service.method, parameters: service.parameters, encoding: service.encoding).responseDecodable(of: U.self) {
             response in
            switch response.result {
            case .success(let result):
                let totalCount = response.response?.allHeaderFields["X-Total-Count"] as? String
                completion(.success(result, totalCount))
            case .failure(let error):
                let appError = AppError(statusCode: error.responseCode, message: error.localizedDescription)
                completion(.failure(appError))
            }
        }
        return request
    }
}
