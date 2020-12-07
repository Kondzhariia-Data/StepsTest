//
//  CommentsInteractor.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

protocol CommentsBusinessLogic {
    func setupInfo(request: Comments.SetupInfo.Request)
    func fetchNextPage(request: Comments.Fetch.Request)
}

protocol CommentsDataStore {

    var comments: [Comment] { get set }
    var commentsRequestConfigure: CommentsRequestConfigure! { get set }
}

class CommentsInteractor {

    public var presenter: CommentsPresentationLogic?
    public var worker: CommentsWorker

    var commentsRequestConfigure: CommentsRequestConfigure!

    private var totalPagesCount: Int {
        return calculatePage(count: commentsRequestConfigure.totalCount)
    }

    private var page: Int {
        return calculatePage(count: comments.count)
    }

    var comments: [Comment] = []

    init(worker: CommentsWorker = CommentsWorker()) {
        self.worker = worker
    }
}

// MARK: - Private Methods
extension CommentsInteractor {
    private func calculatePage(count: Int) -> Int {
        let calcultePage: Double = Double(count) / Double(PageSizeValues.comments)
        return Int(calcultePage.rounded(.up))
    }
}

// MARK: - Comments Business Logic
extension CommentsInteractor: CommentsBusinessLogic {

    func setupInfo(request: Comments.SetupInfo.Request) {
        let response = Comments.SetupInfo.Response(comments: comments)
        presenter?.presentSetupInfo(response: response)
    }

    func fetchNextPage(request: Comments.Fetch.Request) {
        // Check is last page of comments
        guard totalPagesCount > page else {
            let response = Comments.Fetch.Response(comments: [], error: nil)
            presenter?.presentEndOfComments(response: response)
            return
        }

        // Get comments next page
        worker.getComments(lowerBound: commentsRequestConfigure.lowerBound, upperBound: commentsRequestConfigure.upperBound, page: page + 1, responseSuccess: { [weak self] comments in

            self?.comments += comments

            let response = Comments.Fetch.Response(comments: comments, error: nil)
            self?.presenter?.presentFetchNextPageComments(response: response)
        }, responseError: { [weak self] error in

            let response = Comments.Fetch.Response(comments: [], error: error)
            self?.presenter?.presentFetchNextPageComments(response: response)
        })
    }
}

// MARK: - Comments Data Store
extension CommentsInteractor: CommentsDataStore {
}
