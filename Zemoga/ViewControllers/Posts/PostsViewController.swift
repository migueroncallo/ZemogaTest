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
    
    var favorites = false
    
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
        
        configureNavigationBar()
        configureTableView()
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }

    //MARK: - IBActions

    @IBAction func removePosts(_ sender: UIButton) {
        posts.removeAll()
        PostsApi.shared.deletePosts()
        tableView.reloadData()
    }
    
    @IBAction func displayPosts(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            favorites = false
        case 1:
            favorites = true
            
        default: break
        }
        
        loadData()
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
        if favorites{
            PostsApi.shared.getFavorites({ (posts) in
                self.stopAnimating()
                self.posts = posts
                self.tableView.reloadData()
            })
        }else{
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
    
    @objc func refreshData(_ sender: UIBarButtonItem){
        startAnimating()
        self.posts.removeAll()
        PostsApi.shared.getPosts(reload: true) { (posts, error) in
            self.stopAnimating()
            if let p = posts{
                self.posts = p
                self.tableView.reloadData()
            }else{
                //TODO: Handle errors
                print(error!)
            }
        }
    }
    
    func configureNavigationBar(){
        
        navigationItem.title = "Posts"
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshData(_:)))
        navigationItem.rightBarButtonItem = refreshButton
    }
}

extension PostsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        try! realm.write {
            posts[indexPath.row].read = true
            tableView.reloadData()
        }
        
        let postDetailVC = PostDetailViewController.init(post: posts[indexPath.row])
        self.navigationController?.pushViewController(postDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            try! realm.write {
                realm.delete(posts[indexPath.row])
                posts.remove(at: indexPath.row)
                let range = NSMakeRange(0, self.tableView.numberOfSections)
                let sections = NSIndexSet(indexesIn: range)
                tableView.reloadSections(sections as IndexSet, with: .automatic) 
            }
        }
    }
}

extension PostsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self)) as! PostTableViewCell
        
        cell.configure(post: posts[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension PostsViewController: PostTableViewCellDelegate{
    
    func didToggleFav(){
        loadData()
    }
}
