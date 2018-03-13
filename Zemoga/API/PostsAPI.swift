//
//  PostsAPI.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/12/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire

class PostsApi{
    
    static let shared = PostsApi()
    
    func getPosts(){
        let url = URL(string: "\(baseURL)/posts")!
        
        Alamofire.request(url, method: .get)
        .validate()
            .response { (response) in
                
               print(response)
        }
    }
}
