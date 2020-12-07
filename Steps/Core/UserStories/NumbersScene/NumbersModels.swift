//
//  NumbersModels.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

struct CommentsRequestConfigure {
    let lowerBound: Int
    let upperBound: Int
    let totalCount: Int
}

enum Numbers {

    enum Validate {
        struct Request {
            let lowerBound: String?
            let upperBound: String?
        }

        struct Response {
            let error: AppError?
        }

        struct ViewModel {
            let error: AppError?
        }
    }

    enum GetComments {
        struct Request {
        }

        struct Response {
            let error: AppError?
        }

        struct ViewModel {
            let error: AppError?
        }
    }


    enum CancelRequest {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
        }
    }
}

