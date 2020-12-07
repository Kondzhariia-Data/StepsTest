//
//  NumbersWorker.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit
import Alamofire

class NumbersWorker {
    private var networkService: NetworkService<RequestBuilder>
    private var request: DataRequest?

    typealias ResponseSuccess = ([Comment], Int) -> Void
    typealias ResponseError = (AppError?) -> Void
    typealias CompletionHandler = () -> Void

    init(networkService: NetworkService<RequestBuilder> = NetworkService<RequestBuilder>()) {
        self.networkService = networkService
    }
}

// MARK: - Public Methods
extension NumbersWorker {

    public func getComments(lowerBound: Int, upperBound: Int, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        request = networkService.request(service: .comments(lowerBound: lowerBound, upperBound: upperBound), decodeType: [Comment].self) { result in
            switch result {
            case .success(let comments, let totalCount):
                // if total is nil, then returned 500 (all comments)
                var total: Int = 500
                if let totalCount = totalCount {
                    total = Int(totalCount) ?? 500
                }
                responseSuccess(comments, total)
            case .failure(let error):
                responseError(error)
            }
        }
    }

    public func cancelRequest(completionHandler: @escaping CompletionHandler) {
        request?.cancel()
        completionHandler()
    }
}
