//
//  Post.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/12/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Post: Object, Codable {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc var title: String = ""
    @objc var body: String = ""
    
    
    private enum PostCodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    required convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: PostCodingKeys.self)
        let userId = try container.decode(Int.self, forKey: .userId)
        let id = try container.decode(Int.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let body = try container.decode(String.self, forKey: .body)
        self.init(userId: userId, id: id, title: title, body: body)
    }
    
    convenience init(userId: Int, id: Int, title: String, body: String ) {
        self.init()
        
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
