//
//  Issue.swift
//  RxSwiftStudy
//
//  Created by JH on 19/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit

struct Issue {
    let id: Int
    let number: Int
    let title: String
    let user: User
    let state: String
    let comments: Int
    let body: String
    let createdAt: Date
}
