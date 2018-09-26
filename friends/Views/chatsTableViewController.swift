//
//  chatsTableViewController.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 16/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChatsTableViewController: UITableViewController {
    var firebaseRef = Database.database().reference(fromURL: "https://friends-be9c9.firebaseio.com/")
    var users = [Users]()
    var chatsList = [Chats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.extensionSetNavigationControllerBar(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        navigationItem.title = "Chats"
        tableView.register(customTableViewCell.self, forCellReuseIdentifier: "tableCellID")
        tableView.separatorStyle = .none
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsList.count == 0 ? 15: chatsList.count
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellID", for: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    

        
        
        
        
        
    
    
    
    
    
    
    
    
    
}










//table view cell

class customTableViewCell: UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpTableCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.blue
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 10
        container.extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: 3))
        return container
    }()
    
    func setUpTableCell(){
        addSubview(containerView)
        addContainerConstraint()
    }
    
    func addContainerConstraint(){
        extensionSetConstraintsWithFormat(horizontalFormat: "|-15-[v0]-15-|", verticalFormat: "|-5-[v0]-5-|", views: [containerView])
        
    }
    
}


