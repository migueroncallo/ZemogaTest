//
//  PostsViewController.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/12/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    //MARK: - Initializers
    
    init() {
        super.init(nibName: String(describing: PostsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        PostsApi.shared.getPosts()
        // Do any additional setup after loading the view.
    }

}
