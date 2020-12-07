//
//  Comment.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
