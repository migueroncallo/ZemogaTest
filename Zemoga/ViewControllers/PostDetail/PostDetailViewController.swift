//
//  PostDetailViewController.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/13/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import UIKit
import RealmSwift

class PostDetailViewController: UIViewController {
    
    //MARK: - Variables
    
    var post: Post!
    let realm = try! Realm()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var userButton: UIButton!
    
    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Initializers
    
    init(post: Post) {
        
        self.post = post
        super.init(nibName: String(describing: PostDetailViewController.self), bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNavigationBar()
        configurePostData()
        setLikeFunction()
    }
    
    
    //MARK: - IBActions
    
    @IBAction func userDetail(_ sender: UIButton) {
    }
    
    
    //MARK: - Internal Helpers
    
    func configureNavigationBar(){
        navigationItem.title = "Post Detail"
    }
    
    func configurePostData(){
        titleLabel.text = post.title
        bodyLabel.text = post.body
        
        likeImage.image = post.isFav ? UIImage(named: "like-filled") : UIImage(named: "like-empty")
    }
    
    func configureTableView(){
        
    }
    
    func setLikeFunction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.likePost(_:)))
        likeImage.addGestureRecognizer(tap)
        likeImage.isUserInteractionEnabled = true
    }
    
    @objc func likePost(_ sender: UITapGestureRecognizer){
        try! realm.write {
            post.isFav = !post.isFav
        }
        
        configurePostData()
        
    }
    
    func loadUserInfo(){
        UserAPI.shared.getUser(id: post.userId) { (user, erro) in
            if let u = user{
                self.userButton.setTitle(u.username, for: <#T##UIControlState#>)
            }
        }
    }

}
