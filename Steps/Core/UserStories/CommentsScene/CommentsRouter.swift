//
//  CommentsRouter.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

@objc protocol CommentsRoutingLogic {
}

protocol CommentsDataPassing {

    var dataStore: CommentsDataStore? { get }
}

class CommentsRouter: NSObject {

    weak var viewController: CommentsViewController?
    public var dataStore: CommentsDataStore?
}

// MARK: - Comments Routing Logic
extension CommentsRouter: CommentsRoutingLogic {
}

// MARK: - Comments Data Passing
extension CommentsRouter: CommentsDataPassing {
}
