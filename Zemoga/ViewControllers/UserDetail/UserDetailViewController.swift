//
//  UserDetailViewController.swift
//  Zemoga
//
//  Created by Miguel Roncallo on 3/13/18.
//  Copyright © 2018 Miguel Roncallo. All rights reserved.
//

import UIKit
import WebKit

class UserDetailViewController: UIViewController {

    //MARK: - Variables
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var websiteButton: UIButton!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    var user: User!
    //MARK: - Initializers
    
    init(user: User) {
        self.user = user
        super.init(nibName: String(describing: UserDetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureNavigationBar()
        // Do any additional setup after loading the view.
    }

    //MARK: - IBActions
    
    @IBAction func openWebsite(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: user.website)!, options: [:]) { (success) in
            print(success)
            if !success{
                let alert = UIAlertController(title: "Error", message: "Could not load page!", preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Internal Helpers
    
    func configureData(){
        nameLabel.text = user.name
        userLabel.text = "@\(user.username!)"
        emailLabel.text = user.email
        cityLabel.text = user.address.city
        addressLabel.text = "\(user.address.street!), \(user.address.suite!)"
        phoneLabel.text = user.phone
        websiteButton.setTitle(user.website, for: .normal)
        companyLabel.text = user.company.name
    }
    
    func configureNavigationBar(){
        
        navigationItem.title = "User Detail"
      
    }

}
