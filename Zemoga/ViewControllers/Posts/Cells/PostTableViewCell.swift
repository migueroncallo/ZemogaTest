//
//  PostTableViewCell.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/12/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    //MARK: - Variables
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var readView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(post: Post){
        titleLabel.text = post.title
        
        readView.isHidden = post.read
        readView.layer.cornerRadius = 12
        readView.clipsToBounds = true
    }


    
}
