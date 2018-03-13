//
//  UserAPI.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/13/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire

class UserAPI{
    static let shared = UserAPI()
    
    func getUser(id: Int, _ cb: @escaping (User?, Error?)->()){
        
        let url = URL(string: "\(baseURL)/users/\(id)")!
        
        Alamofire.request(url, method: .get)
        .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    let decoder = JSONDecoder()
                    
                    let user = try! decoder.decode(User.self, from: response.data!)
                    
                    cb(user, nil)
                    
                case .failure(let e):
                    cb(nil, e)
                }
        }
    }
}
