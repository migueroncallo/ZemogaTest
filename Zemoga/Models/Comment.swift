//
//  Comment.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/13/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import Foundation

struct Comment: Codable{
    var postId: Int!
    var id: Int!
    var name: String!
    var email: String!
    var body: String!
}
