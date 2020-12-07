//
//  NumbersRouter.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

@objc protocol NumbersRoutingLogic {
    func routeToComments(segue: UIStoryboardSegue)

    func navigateToComments()
}

protocol NumbersDataPassing {

    var dataStore: NumbersDataStore? { get }
}

class NumbersRouter: NSObject {

    weak var viewController: NumbersViewController?
    public var dataStore: NumbersDataStore?
}

// MARK: - Numbers Routing Logic
extension NumbersRouter: NumbersRoutingLogic {

    func routeToComments(segue: UIStoryboardSegue) {
        let commentsViewController = segue.destination as? CommentsViewController
        var commentsDataStore = commentsViewController?.router?.dataStore
        commentsDataStore?.comments = dataStore?.comments ?? []
        commentsDataStore?.commentsRequestConfigure = dataStore?.commentsRequestConfigure
    }

    func navigateToComments() {
        viewController?.performSegue(withIdentifier: R.segue.numbersViewController.comments.identifier, sender: .none)
    }
}

// MARK: - Numbers Data Passing
extension NumbersRouter: NumbersDataPassing {
}
