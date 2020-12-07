//
//  CommentsWorker.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

class CommentsWorker {
    private var networkService: NetworkService<RequestBuilder>

    typealias ResponseSuccess = ([Comment]) -> Void
    typealias ResponseError = (AppError?) -> Void

    init(networkService: NetworkService<RequestBuilder> = NetworkService<RequestBuilder>()) {
        self.networkService = networkService
    }
}

// MARK: - Public Methods
extension CommentsWorker {
    
    public func getComments(lowerBound: Int, upperBound: Int, page: Int, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        networkService.request(service: .comments(lowerBound: lowerBound, upperBound: upperBound, page: page), decodeType: [Comment].self) { result in
            switch result {
            case .success(let comments, _):
                responseSuccess(comments)
            case .failure(let error):
                responseError(error)
            }
        }
    }
}
