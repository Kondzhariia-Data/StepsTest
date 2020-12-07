//
//  CommentsPresenter.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

protocol CommentsPresentationLogic {
    func presentSetupInfo(response: Comments.SetupInfo.Response)
    func presentFetchNextPageComments(response: Comments.Fetch.Response)
    func presentEndOfComments(response: Comments.Fetch.Response)
}

class CommentsPresenter {

    weak var viewController: CommentsDisplayLogic?
}

// MARK: - Private Methods
extension CommentsPresenter {

    private func setupDisplayedComments(comments: [Comment]) -> [Comments.DisplayedComment] {
        var displayedComments = [Comments.DisplayedComment]()

        comments.forEach { comment in
            let displayedComment = Comments.DisplayedComment(id: comment.id, name: comment.name, email: comment.email, body: comment.body)
            displayedComments.append(displayedComment)
        }
        return displayedComments
    }
}

// MARK: - Comments Presentation Logic
extension CommentsPresenter: CommentsPresentationLogic {

    func presentSetupInfo(response: Comments.SetupInfo.Response) {
        let displayedComments = setupDisplayedComments(comments: response.comments)
        let viewModel = Comments.SetupInfo.ViewModel(displayedComments: displayedComments)
        viewController?.displaySetupInfoSuccess(viewModel: viewModel)
    }
    
    func presentFetchNextPageComments(response: Comments.Fetch.Response) {
        let displayedComments = setupDisplayedComments(comments: response.comments)
        let viewModel = Comments.Fetch.ViewModel(displayedComments: displayedComments, error: response.error)

        if response.error != nil {
            viewController?.displayFetchNextPageCommentsError(viewModel: viewModel)
        } else {
            viewController?.displayFetchNextPageCommentsSuccess(viewModel: viewModel)
        }
    }

    func presentEndOfComments(response: Comments.Fetch.Response) {
        let displayedComments = setupDisplayedComments(comments: response.comments)
        let viewModel = Comments.Fetch.ViewModel(displayedComments: displayedComments, error: response.error)
        viewController?.displayFetchEndOfComments(viewModel: viewModel)
    }
}
