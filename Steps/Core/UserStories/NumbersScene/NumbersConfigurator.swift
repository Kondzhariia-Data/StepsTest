//
//  NumbersConfigurator.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

class NumbersConfigurator {

    static let shared = NumbersConfigurator()

    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Method
extension NumbersConfigurator {

    public func configure(_ viewController: NumbersViewController) {

        let interactor = NumbersInteractor()
        let presenter = NumbersPresenter()
        let router = NumbersRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
