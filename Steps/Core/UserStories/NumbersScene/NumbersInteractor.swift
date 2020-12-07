//
//  NumbersInteractor.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

protocol NumbersBusinessLogic {
    func validate(request: Numbers.Validate.Request)
    func comments(request: Numbers.GetComments.Request)
    func cancelRequest(request: Numbers.CancelRequest.Request)
}

protocol NumbersDataStore {
    var comments: [Comment] { get }
    var commentsRequestConfigure: CommentsRequestConfigure! { get }
}

class NumbersInteractor {

    public var presenter: NumbersPresentationLogic?
    public var worker: NumbersWorker

    private var lowerBound: Int! = 0
    private var upperBound: Int! = 0

    var comments: [Comment] = []
    var totalCount: Int = 0

    var commentsRequestConfigure: CommentsRequestConfigure!

    init(worker: NumbersWorker = NumbersWorker()) {
        self.worker = worker
    }
}

// MARK: - Private Methods
extension NumbersInteractor {

    private func presentValidate(error: AppError? = nil) {
        let response = Numbers.Validate.Response(error: error)
        presenter?.presentValidate(response: response)
    }
}

// MARK: - Numbers Business Logic
extension NumbersInteractor: NumbersBusinessLogic {

    func validate(request: Numbers.Validate.Request) {
        guard let lowerBound = request.lowerBound, let upperBound = request.upperBound, lowerBound.isEmpty == false, upperBound.isEmpty == false else {
            let error = AppError(kind: .isNumbersEmpty)
            presentValidate(error: error)
            return
        }

        self.lowerBound = Int(lowerBound)
        self.upperBound = Int(upperBound)

        if self.lowerBound == self.upperBound {
            let error = AppError(kind: .numbersMatch)
            presentValidate(error: error)
        } else if self.lowerBound > self.upperBound {
            let error = AppError(kind: .boundLess)
            presentValidate(error: error)
        } else {
            presentValidate()
        }
    }

    func comments(request: Numbers.GetComments.Request) {
        worker.getComments(lowerBound: lowerBound, upperBound: upperBound, responseSuccess: { [weak self] comments, totalCount in
            self?.comments = comments
            self?.totalCount = totalCount

            // Set configure request
            self?.commentsRequestConfigure = CommentsRequestConfigure(lowerBound: self?.lowerBound ?? 0, upperBound: self?.upperBound ?? 0, totalCount: self?.totalCount ?? 0)

            let response = Numbers.GetComments.Response(error: nil)
            self?.presenter?.presentComments(response: response)
        }, responseError: { [weak self] error in
            self?.comments = []

            let response = Numbers.GetComments.Response(error: error)
            self?.presenter?.presentComments(response: response)
        })
    }

    func cancelRequest(request: Numbers.CancelRequest.Request) {
        worker.cancelRequest { [weak self] in
            let response = Numbers.CancelRequest.Response()
            self?.presenter?.presentCancelRequest(response: response)
        }
    }
}

// MARK: - Numbers Data Store
extension NumbersInteractor: NumbersDataStore {
}
