//
//  NumbersPresenter.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

protocol NumbersPresentationLogic {
    func presentValidate(response: Numbers.Validate.Response)
    func presentComments(response: Numbers.GetComments.Response)
    func presentCancelRequest(response: Numbers.CancelRequest.Response)
}

class NumbersPresenter {

    weak var viewController: NumbersDisplayLogic?
}

// MARK: - Numbers Presentation Logic
extension NumbersPresenter: NumbersPresentationLogic {
    
    func presentValidate(response: Numbers.Validate.Response) {
        let viewModel = Numbers.Validate.ViewModel(error: response.error)

        if response.error != nil {
            viewController?.displayValidateError(viewModel: viewModel)
        } else {
            viewController?.displayValidateSuccess(viewModel: viewModel)
        }
    }

    func presentComments(response: Numbers.GetComments.Response) {
        let viewModel = Numbers.GetComments.ViewModel(error: response.error)

        if response.error != nil {
            viewController?.displayCommentsError(viewModel: viewModel)
        } else {
            viewController?.displayCommentsSuccess(viewModel: viewModel)
        }
    }

    func presentCancelRequest(response: Numbers.CancelRequest.Response) {
        let viewModel = Numbers.CancelRequest.ViewModel()
        viewController?.displayCancelRequestSuccess(viewModel: viewModel)
    }
}
