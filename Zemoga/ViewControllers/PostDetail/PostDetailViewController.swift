//
//  PostDetailViewController.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/13/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import UIKit
import RealmSwift
import NVActivityIndicatorView

class PostDetailViewController: UIViewController, NVActivityIndicatorViewable {
    
    //MARK: - Variables
    
    var post: Post!
    var comments = [Comment]()
    let realm = try! Realm()
    var user: User!
    
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
        loadUserInfo()
        configureTableView()
        loadPostComments()
    }
    
    
    //MARK: - IBActions
    
    @IBAction func userDetail(_ sender: UIButton) {
        let userDetailVc = UserDetailViewController.init(user: user)
        self.navigationController?.pushViewController(userDetailVc, animated: true)
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: CommentTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommentTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 73
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
    
    func loadPostComments(){
        startAnimating()
        
        CommentAPI.shared.getCommentsForPost(postId: post.id) { (comments, error) in
            if let c = comments{
                self.comments = c
                self.tableView.reloadData()
            }else{
                
                //TODO: Handle errors
                print(error!)
            }
        }
    }
    
    func loadUserInfo(){
        startAnimating()
        UserAPI.shared.getUser(id: post.userId) { (user, error) in
            self.stopAnimating()
            if let u = user{
                self.userButton.setTitle(u.username, for: .normal)
                self.user = u
            }else{
                //TODO: Handle errors
                print(error!)
            }
        }
    }

}

extension PostDetailViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentTableViewCell.self)) as! CommentTableViewCell
        
        cell.configure(comment: comments[indexPath.row])
        
        return cell
    }
    
}

extension PostDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
