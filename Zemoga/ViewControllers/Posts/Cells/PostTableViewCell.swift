//
//  PostTableViewCell.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/13/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import UIKit
import RealmSwift

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var readView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    let realm = try! Realm()
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(post: Post){
        titleLabel.text = post.title
        readView.isHidden = post.read
        readView.layer.cornerRadius = 6
        readView.clipsToBounds = true
        favoriteImage.image = post.isFav ? UIImage(named:"star-filled") : UIImage(named:"star-empty")
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.favPost(_:)))
        favoriteImage.addGestureRecognizer(tap)
        favoriteImage.isUserInteractionEnabled = true
        self.post = post
    }
    
    @objc func favPost(_ sender: UITapGestureRecognizer){
        
        try! realm.write {
            post.isFav = !post.isFav
            favoriteImage.image = post.isFav ? UIImage(named:"star-filled") : UIImage(named:"star-empty")
            
        }
    }
    
}
