//
//  NumbersViewController.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol NumbersDisplayLogic: class {
    func displayValidateSuccess(viewModel: Numbers.Validate.ViewModel)
    func displayValidateError(viewModel: Numbers.Validate.ViewModel)

    func displayCommentsSuccess(viewModel: Numbers.GetComments.ViewModel)
    func displayCommentsError(viewModel: Numbers.GetComments.ViewModel)

    func displayCancelRequestSuccess(viewModel: Numbers.CancelRequest.ViewModel)
}

class NumbersViewController: UIViewController {

    @IBOutlet private weak var lowerBoundTextField: UITextField!
    @IBOutlet private weak var upperBoundTextField: UITextField!
    @IBOutlet private weak var commentsButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var errorMessageLabel: UILabel!

    public var interactor: NumbersBusinessLogic?
    public var router: (NSObjectProtocol & NumbersRoutingLogic & NumbersDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()

        NumbersConfigurator.shared.configure(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
        displayCancelButtonState(showCancel: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareRoute(for: segue, router: router)
    }
}

// MARK: - Private Methods
extension NumbersViewController {

    private func showErrorMessage(_ message: String?) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }

    private func displayCancelButtonState(showCancel: Bool) {
        lowerBoundTextField.isEnabled = !showCancel
        upperBoundTextField.isEnabled = !showCancel
        commentsButton.isEnabled = !showCancel
        cancelButton.isHidden = !showCancel
    }
}

// MARK: - Actions
extension NumbersViewController {
    
    @IBAction private func didTapGetCommentsButton(_ sender: UIButton) {
        view.endEditing(true)

        let request = Numbers.Validate.Request(lowerBound: lowerBoundTextField.text, upperBound: upperBoundTextField.text)
        interactor?.validate(request: request)
    }

    @IBAction private func didTapCancelButton(_ sender: UIButton) {
        let request = Numbers.CancelRequest.Request()
        interactor?.cancelRequest(request: request)
    }
}

// MARK: - Text Field Delegate
extension NumbersViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let stringRange = Range(range, in: text) else {
            return false
        }

        let updatedText = text.replacingCharacters(in: stringRange, with: string)
        return updatedText.count < 4
    }
}

// MARK: - Numbers Display Logic
extension NumbersViewController: NumbersDisplayLogic {

    func displayValidateSuccess(viewModel: Numbers.Validate.ViewModel) {
        SVProgressHUD.show()
        errorMessageLabel.isHidden = true
        displayCancelButtonState(showCancel: true)

        let request = Numbers.GetComments.Request()
        interactor?.comments(request: request)
    }

    func displayValidateError(viewModel: Numbers.Validate.ViewModel) {
        SVProgressHUD.dismiss()
        showErrorMessage(viewModel.error?.message)
    }

    func displayCommentsSuccess(viewModel: Numbers.GetComments.ViewModel) {
        SVProgressHUD.dismiss()
        errorMessageLabel.isHidden = true
        displayCancelButtonState(showCancel: false)

        router?.navigateToComments()
    }
    
    func displayCommentsError(viewModel: Numbers.GetComments.ViewModel) {
        SVProgressHUD.dismiss()
        showErrorMessage(viewModel.error?.message)
        displayCancelButtonState(showCancel: false)
    }

    func displayCancelRequestSuccess(viewModel: Numbers.CancelRequest.ViewModel) {
        SVProgressHUD.dismiss()
        displayCancelButtonState(showCancel: false)
    }
}
