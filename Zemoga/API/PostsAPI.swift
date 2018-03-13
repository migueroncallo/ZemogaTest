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
    
    
    func getPosts(reload: Bool, _ cb: @escaping ([Post]?, Error?)->()){
        let url = URL(string: "\(baseURL)/posts")!
        if reload{
            self.deletePosts()
                
            Alamofire.request(url, method: .get)
                .validate()
                .responseJSON { (response) in
                    
                    switch response.result{
                    case .success:
                        let decoder = JSONDecoder()
                        let posts = try! decoder.decode([Post].self, from: response.data!)
                        
                        for i in 0...19 {
                            posts[i].read = false
                        }
                        try! self.realm.write {
                            self.realm.add(posts)
                        }
                        
                        cb(posts, nil)
                        
                    case .failure(let error):
                        cb(nil, error)
                    }
            }
        }
        
        let posts = Array(realm.objects(Post.self))
        
        
        if posts.count == 0{
            Alamofire.request(url, method: .get)
                .validate()
                .responseJSON { (response) in
                    
                    switch response.result{
                    case .success:
                        let decoder = JSONDecoder()
                        let posts = try! decoder.decode([Post].self, from: response.data!)
                        
                        for i in 0...19 {
                            posts[i].read = false
                        }
                        
                        self.realm.beginWrite()
                        self.realm.add(posts)
                        try! self.realm.commitWrite()
                        
                        cb(posts, nil)
                        
                    case .failure(let error):
                        cb(nil, error)
                    }
            }
        }else{
            cb(posts, nil)
        }
        
    }
    
    func deletePosts(){
        try! realm.write {
            realm.delete(realm.objects(Post.self))
        }
    }
    
    func getFavorites(_ cb: @escaping([Post])->()){
        cb(Array(realm.objects(Post.self).filter("isFav == true")))
    }
}
