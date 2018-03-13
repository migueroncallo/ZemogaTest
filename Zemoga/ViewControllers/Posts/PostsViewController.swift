//
//  PostsViewController.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/12/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import UIKit
import RealmSwift
import NVActivityIndicatorView

class PostsViewController: UIViewController, NVActivityIndicatorViewable{

    
    //MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    let realm = try! Realm()
    
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
        configureTableView()
        loadData()
    }

    //MARK: - IBActions

    @IBAction func removePosts(_ sender: UIButton) {
    }
    
    //MARK: - Internal Helpers
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 73
    }
    
    func loadData(){
        print("loading data")
        startAnimating(message: "Loading", type: NVActivityIndicatorType.ballBeat)
        PostsApi.shared.getPosts(reload: false) { (posts, error) in
            print("data loaded")
            self.stopAnimating()
            if let p = posts{
                self.posts = p
                self.tableView.reloadData()
            }else{
                //TODO: Send error alert
            }
        }
    }
}

extension PostsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        try! realm.write {
            posts[indexPath.row].read = true
        }
        
        tableView.reloadData()
    }
}

extension PostsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self)) as! PostTableViewCell
        
        cell.configure(post: posts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
