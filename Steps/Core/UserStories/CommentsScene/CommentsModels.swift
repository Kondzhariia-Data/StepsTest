//
//  CommentsModels.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit

enum Comments {

    struct DisplayedComment {
        let id: Int
        let name: String
        let email: String
        let body: String
    }

    enum SetupInfo {
        struct Request {
        }

        struct Response {
            let comments: [Comment]
        }

        struct ViewModel {
            let displayedComments: [DisplayedComment]
        }
    }

    enum Fetch {
        struct Request {
        }

        struct Response {
            let comments: [Comment]
            let error: AppError?
        }

        struct ViewModel {

            let displayedComments: [DisplayedComment]
            let error: AppError?
        }
    }
}
