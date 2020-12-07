//
//  RequestBuilder.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//

import Foundation
import Alamofire

protocol URLRequestBuilder {
    var baseURL: String { get }
    var url: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestBuilder {
    var baseURL: String {
        return "http://jsonplaceholder.typicode.com"
    }

    var url: String {
        var components = URLComponents(string: baseURL)!
        components.path = "/" + path
        components.queryItems = queryItems
        return components.string ?? baseURL
    }
}

enum RequestBuilder: URLRequestBuilder {
    case comments(lowerBound: Int, upperBound: Int, page: Int = 1, limit: Int = PageSizeValues.comments, sort: String = "id")

    var path: String {
        switch self {
        case .comments:
            return "comments"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .comments(let lowerBound, let upperBound, _, _, _):
            var queryItems = [URLQueryItem]()
            let ids = lowerBound...upperBound
            ids.forEach { id in
                let queryItem = URLQueryItem(name: "id", value: "\(id)")
                queryItems.append(queryItem)
            }
            return queryItems
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }

    var parameters: Parameters? {
        switch self {
        case .comments(_, _, let page, let limit, let sort):
            return ["_page": page, "_limit": limit, "_sort": sort]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .comments:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .comments:
            return URLEncoding.queryString
        }
    }
}
