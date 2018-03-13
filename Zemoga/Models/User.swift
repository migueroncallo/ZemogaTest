//
//  User.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/12/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import Foundation

struct User: Codable{
    var id: Int!
    var name: String!
    var email: String!
    var username: String!
    var address: Address!
    var phone: String!
    var website: String!
    var company: Company!
}

struct Address: Codable{
    var street: String!
    var suite: String!
    var city: String!
    var zipcode: String!
}

struct Company: Codable{
    var name: String!
    var catchPhrase: String!
    var bs: String!
}
