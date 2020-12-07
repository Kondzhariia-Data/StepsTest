//
//  AppError.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright © 2020 Steps. All rights reserved.
//

import Foundation

struct ErrorMessage {
    static let boundLess = "Lower bound should be less then upper one"
    static let isNumbersEmpty = "Enter both numbers"
    static let noInternetConnection = "The Internet connection appears to be offline"
    static let numbersMatch = "The numbers should not match. Please enter two different numbers"
    static let other = "Sorry, something went wrong. Please try again in a few minutes"
}

enum StatusCode: Int {
    case cancelled = -999
}

struct AppError: Error {

    enum Kind {
        case custom
        case boundLess
        case isNumbersEmpty
        case noInternetConnection
        case numbersMatch
        case other
    }

    let statusCode: Int?
    let message: String?
    let kind: Kind?

    init(kind: Kind) {
        self.kind = kind
        self.statusCode = 666
        switch kind {
        case .boundLess:
            message = ErrorMessage.boundLess
        case .isNumbersEmpty:
            message = ErrorMessage.isNumbersEmpty
        case .noInternetConnection:
            message = ErrorMessage.noInternetConnection
        case .numbersMatch:
            message = ErrorMessage.numbersMatch
        case .other:
            message = ErrorMessage.other
        default:
            message = ErrorMessage.other
        }
    }

    init(statusCode: Int?, message: String?) {
        self.kind = .custom
        self.message = message
        self.statusCode = statusCode
    }

    init(message: String?) {
        self.kind = .custom
        self.message = message
        self.statusCode = nil
    }
}
