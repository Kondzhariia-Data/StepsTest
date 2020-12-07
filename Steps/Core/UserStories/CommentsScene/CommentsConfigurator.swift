//
//  CommentsConfigurator.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

class CommentsConfigurator {

    static let shared = CommentsConfigurator()

    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Method
extension CommentsConfigurator {

    public func configure(_ viewController: CommentsViewController) {

        let interactor = CommentsInteractor()
        let presenter = CommentsPresenter()
        let router = CommentsRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
