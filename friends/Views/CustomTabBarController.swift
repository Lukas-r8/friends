//
//  CustomTabBarController.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 26/08/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionSetTabBarBackgroundImage(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        
        let main = MainViewController()
        let mainNavController = UINavigationController(rootViewController: main)
        mainNavController.tabBarItem = UITabBarItem(title: "main", image: nil, selectedImage: nil)
        mainNavController.title = "Profile"
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
        let eventsController = EventsCollectionViewController(collectionViewLayout: collectionViewLayout)
        let eventsNavController = UINavigationController(rootViewController: eventsController)
        eventsNavController.title = "Events"
        
        let ChatsController = ChatsTableViewController()
        let ChatsNavController = UINavigationController(rootViewController: ChatsController)
        ChatsNavController.title = "Chats"
        
        
        
        viewControllers = [mainNavController,eventsNavController, ChatsNavController]
    }
    
    



}

