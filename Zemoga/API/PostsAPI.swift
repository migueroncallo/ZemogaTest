//
//  PostsAPI.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/12/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class PostsApi{
    
    static let shared = PostsApi()
    let realm = try! Realm()
    
    func getPosts(_ cb: @escaping ([Post]?, Error?)->()){
        let url = URL(string: "\(baseURL)/posts")!
        
        Alamofire.request(url, method: .get)
        .validate()
            .responseJSON { (response) in
                
                switch response.result{
                case .success:
                    let decoder = JSONDecoder()
                    let posts = try! decoder.decode([Post].self, from: response.data!)
                    
                    self.realm.beginWrite()
                    self.realm.add(posts)
                    try! self.realm.commitWrite()
                    
                    cb(posts, nil)
                    
                case .failure(let error):
                    cb(nil, error)
                }
        }
    }
}
