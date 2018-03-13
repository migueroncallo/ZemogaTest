//
//  CommentAPI.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/13/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire

class CommentAPI{
    static let shared = CommentAPI()
    
    func getCommentsForPost(postId: Int, _ cb: @escaping ([Comment]?, Error?)->()){
        
        let url = URL(string: "\(baseURL)/posts/\(postId)/comments")!
        
        Alamofire.request(url, method: .get)
        .validate()
            .responseJSON { (response) in
                
                switch response.result{
                case .success:
                    
                    let decoder = JSONDecoder()
                    let comments = try! decoder.decode([Comment].self, from: response.data!)
                    cb(comments, nil)
                    
                case .failure(let error):
                    cb(nil, error)
                }
        }
    }
}
